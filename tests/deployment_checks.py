"""HTTP deployment/security regression against local, isolated Apache fixtures."""
import concurrent.futures, hashlib, json, os, re, secrets, subprocess
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlsplit
import requests, urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
ROOT=Path(__file__).resolve().parents[1]
REPORT=ROOT/'tests/refactor'
ENV={**os.environ,'APP_ENV':'testing','LEARNOW_TEST_DATABASE':'learnow_refactor_test'}
PASSWORD='Test-Only-Learnow-2026!'
checks=[]
def check(ok,name,detail=''):
    checks.append({'passed':bool(ok),'name':name})
    print(('PASS ' if ok else 'FAIL ')+name+(' :: '+str(detail)[:300] if not ok else ''),flush=True)
def sql(query,params=None):
    p=subprocess.run(['php','tests/fixtures.php','sql',query,json.dumps(params or [])],cwd=ROOT,env=ENV,capture_output=True,text=True,check=True)
    return json.loads(p.stdout)
def scalar(query,params=None):
    rows=sql(query,params);return next(iter(rows[0].values())) if rows else None
class URLs(HTMLParser):
    def __init__(self):super().__init__();self.items=[]
    def handle_starttag(self,tag,attrs):
        for name,value in attrs:
            if name in ['href','src','action','data-private-notes','data-api-button'] and value:self.items.append((tag,name,value))
def csrf(session,base):
    r=session.get(base+'/register',timeout=15,verify=False)
    token=re.search(r'name="csrf-token" content="([^"]+)',r.text)
    assert token,(r.status_code,r.text[:200])
    session.headers.update({'X-CSRF-Token':token.group(1),'Accept':'application/json'})
    return r
def post(session,base,path,data):return session.post(base+path,json=data,timeout=25,verify=False)
def data(email):return {'full_name':'Isolated deployment learner','email':email,'password':PASSWORD,'password_confirmation':PASSWORD,'terms':True}
try:
    for base in ['http://127.0.0.1:8083','http://127.0.0.1:8084/classroom/skills','https://localhost:8443/college']:
        sql('DELETE FROM rate_limits')
        label=urlsplit(base).netloc+urlsplit(base).path
        s=requests.Session();r=csrf(s,base)
        check(r.status_code==200,label+' registration page')
        check(f'name="app-url" content="{base}"' in r.text,label+' APP_URL metadata matches this deployment')
        urls=URLs();urls.feed(r.text)
        bad=[u for _,_,u in urls.items if not u.startswith(('#','mailto:','tel:',base+'/','https://www.youtube-nocookie.com/'))]
        check(not bad,label+' all registration links, forms and assets use the configured base',bad)
        check('nosniff'==r.headers.get('X-Content-Type-Options'),label+' no-sniff header')
        check("script-src 'self'" in r.headers.get('Content-Security-Policy',''),label+' script CSP remains enforced')
        if base.startswith('https:'):
            check('max-age=' in r.headers.get('Strict-Transport-Security',''),label+' production HSTS')
            check("frame-ancestors 'self'" in r.headers.get('Content-Security-Policy',''),label+' production anti-framing policy')
            check('X-Learnow-Test-Instance' not in r.headers,label+' production does not emit the test marker')
        assets=[('/assets/css/fonts.css','text/css'),('/assets/css/main.css','text/css'),('/assets/css/refinements.css','text/css'),('/assets/js/app.js','javascript'),('/assets/js/url.js','javascript'),('/assets/js/api.js','javascript'),('/assets/fonts/font-0.ttf','font'),('/assets/fonts/font-8.ttf','font'),('/assets/images/favicon.svg','svg')]
        for path,kind in assets:
            a=s.get(base+path,timeout=15,verify=False)
            check(a.status_code==200 and kind in a.headers.get('Content-Type',''),label+' asset '+path,a.headers.get('Content-Type'))
        fonts=s.get(base+'/assets/css/fonts.css',verify=False).text
        check('/assets/fonts/' not in fonts and '../fonts/font-0.ttf' in fonts,label+' stylesheet dependencies are base-relative')
        for path in ['/.env','/.git/config','/app/bootstrap.php','/vendor/autoload.php','/bin/migrate.php','/config/database.php','/database/migrations/001_initial.sql','/storage/mysql/mysql/user.frm','/storage/logs/application.log','/storage/backups/preview-verification.sql.gz','/tests/fixtures.php','/composer.json','/public/index.php','/README.md']:
            p=s.get(base+path,verify=False,timeout=15,allow_redirects=False)
            check(p.status_code in [403,404],label+' private path denied: '+path,p.status_code)
        a=s.get(base+'/assets/css/not-present.css',verify=False);check(a.status_code==404,label+' missing static asset is not falsely successful')
        a=s.get(base+'/api/not-present',verify=False);check(a.status_code==404 and a.headers.get('Content-Type','').startswith('application/json'),label+' prefixed API 404 is JSON')
        a=s.head(base+'/register',verify=False);check(a.status_code==200 and not a.content,label+' HEAD keeps GET route semantics without a body')
        a=s.get(base+'/register?ref=URLTEST123',verify=False);check('value="URLTEST123"' in a.text,label+' routing preserves query parameters')
        check(post(s,base,'/api/auth/register',{**data('bad-terms-'+secrets.token_hex(4)+'@test.learnow.invalid'),'terms':'false'}).status_code==422,label+' false-like terms are not accepted as consent')
        check(post(s,base,'/api/auth/register',{**data('bad-types-'+secrets.token_hex(4)+'@test.learnow.invalid'),'password_confirmation':[]}).status_code==422,label+' malformed password confirmation is a validation error')
        no_csrf=requests.Session();a=post(no_csrf,base,'/api/auth/register',data('csrf-'+secrets.token_hex(4)+'@test.learnow.invalid'));check(a.status_code==403,label+' registration requires CSRF')
        a=s.post(base+'/api/auth/register',json=data('cross-site-'+secrets.token_hex(4)+'@test.learnow.invalid'),headers={'Sec-Fetch-Site':'cross-site'},verify=False);check(a.status_code==403,label+' cross-site mutations rejected')
        email='deploy-'+secrets.token_hex(5)+'@test.learnow.invalid';a=post(s,base,'/api/auth/register',data(email));check(a.status_code==201,label+' actual registration succeeds',a.text)
        check(a.json().get('redirect')==base+'/onboarding',label+' registration redirect is absolute and correctly prefixed')
        expected_path=(urlsplit(base).path.rstrip('/') or '')+'/'
        cookies=[c for c in s.cookies if c.name in ['ln_access','ln_refresh','ln_csrf']]
        check(len(cookies)==3 and all(c.path==expected_path for c in cookies),label+' all authentication/CSRF cookies use the mount path')
        check(all(c.secure==base.startswith('https:') for c in cookies),label+' cookie Secure matches the verified deployment mode')
        check(all(c.has_nonstandard_attr('HttpOnly') and c.get_nonstandard_attr('SameSite')=='Lax' for c in cookies),label+' cookies preserve HttpOnly and SameSite=Lax')
        uid=scalar('SELECT id FROM users WHERE email=?',[email]);check(bool(uid),label+' registration writes a real account')
        check(str(scalar('SELECT password_hash FROM users WHERE id=?',[uid])).startswith('$argon2id$'),label+' stored password is an Argon2id hash')
        check(int(scalar('SELECT COUNT(*) FROM xp_transactions WHERE user_id=?',[uid]))==0,label+' registration invents no XP')
        for table in ['user_preferences','study_schedules','notification_preferences','onboarding_responses','referral_codes','auth_sessions']:
            check(int(scalar(f'SELECT COUNT(*) FROM {table} WHERE user_id=?',[uid]))==1,label+' registration schema relationship: '+table)
        a=post(s,base,'/api/onboarding',{'step':7,'finish':True,'timezone':'Africa/Lagos','path_id':1,'interests':[1]});check(a.status_code==200,label+' onboarding submission works')
        for path in ['/dashboard','/paths/web-development-foundations','/lessons/1','/portfolio','/settings','/referrals','/notifications']:
            p=s.get(base+path,verify=False,timeout=15);check(p.status_code==200,label+' learner page '+path)
            collected=URLs();collected.feed(p.text)
            escaped=[u for _,_,u in collected.items if u.startswith('/') or (u.startswith(urlsplit(base).scheme+'://'+urlsplit(base).netloc) and not u.startswith(base+'/'))]
            check(not escaped,label+' generated URLs stay inside the installation: '+path,escaped)
        a=s.get(base+'/referrals',verify=False);check(f'value="{base}/register?ref=' in a.text,label+' referral share URL uses APP_URL, not browser origin')
        a=post(s,base,'/api/auth/logout',{});check(a.status_code==200 and a.json().get('redirect')==base+'/',label+' logout redirect')
        a=post(s,base,'/api/auth/login',{'email':email,'password':PASSWORD});check(a.status_code==200 and a.json().get('redirect')==base+'/dashboard',label+' actual login succeeds')
        a=post(s,base,'/api/auth/register',data(email.upper()));check(a.status_code==422,label+' normalised duplicate email fails honestly')
    # Concurrent duplicate registration under a real multiprocess Apache server.
    base='http://127.0.0.1:8084/classroom/skills'
    sql('DELETE FROM rate_limits')
    same='race-'+secrets.token_hex(5)+'@test.learnow.invalid'
    sessions=[requests.Session(),requests.Session()]
    for s in sessions:csrf(s,base)
    with concurrent.futures.ThreadPoolExecutor(2) as pool:statuses=list(pool.map(lambda s:post(s,base,'/api/auth/register',data(same)).status_code,sessions))
    check(sorted(statuses)==[201,422],'Concurrent duplicate signup yields one account and one explicit rejection',statuses)
    check(int(scalar('SELECT COUNT(*) FROM users WHERE email=?',[same]))==1,'Concurrent duplicate signup persists exactly one user')
    # Force the session write to fail: account/profile/referral inserts must roll back too.
    sql('CREATE TRIGGER qa_registration_session_failure BEFORE INSERT ON refresh_tokens FOR EACH ROW SIGNAL SQLSTATE \'45000\' SET MESSAGE_TEXT=\'QA forced refresh persistence failure\'')
    try:
        broken='rollback-'+secrets.token_hex(5)+'@test.learnow.invalid';s=requests.Session();csrf(s,base)
        a=post(s,base,'/api/auth/register',data(broken));j=a.json()
        check(a.status_code==500 and re.fullmatch('[0-9a-f]{12}',j.get('reference','')) is not None,'A failed session write has a safe diagnostic reference, not fabricated success')
        check(int(scalar('SELECT COUNT(*) FROM users WHERE email=?',[broken]))==0,'A failed session write rolls back the complete new account')
        log=ROOT/'storage/qa-apache/webroot/classroom/skills/storage/logs/application.log'
        line=next((json.loads(x) for x in log.read_text().splitlines() if j.get('reference','MISSING') in x),{})
        check('QA forced refresh persistence failure' in line.get('message','') and bool(line.get('trace')),'The response reference resolves to useful private diagnostics')
        check(PASSWORD not in log.read_text() and 'password' not in a.text.lower() and 'SQLSTATE' not in a.text,'Failure response/logging omit passwords and public SQL/stack details')
    finally:sql('DROP TRIGGER IF EXISTS qa_registration_session_failure')
except Exception as error:
    import traceback;traceback.print_exc();check(False,'Unexpected deployment-test exception',error)
finally:
    passed=sum(c['passed'] for c in checks);failed=len(checks)-passed
    REPORT.joinpath('deployment-results.json').write_text(json.dumps({'passed':passed,'failed':failed,'checks':checks},indent=2))
    print(f'\n{passed} passed; {failed} failed.')
    raise SystemExit(1 if failed else 0)
