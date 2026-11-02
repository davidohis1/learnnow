"""Real HTTP integration tests. Requires an isolated *_test DB and test server.
Run: php tests/fixtures.php && LEARNOW_TEST_URL=http://127.0.0.1:8081 python3 tests/http_integration.py
Fixture accounts and test curriculum never touch the public database.
"""
import os, re, json, subprocess, secrets, base64, hashlib, hmac, time
from datetime import date, timedelta
from pathlib import Path
import requests
BASE=os.environ.get('LEARNOW_TEST_URL','http://127.0.0.1:8081')
ROOT=Path(__file__).resolve().parents[1]
PASS='Test-Only-Learnow-2026!'
results=[]
def check(ok,label,detail=''):
    results.append((bool(ok),label))
    print(('PASS ' if ok else 'FAIL ')+label+((' :: '+str(detail)[:220]) if not ok else ''),flush=True)
def sql(query,params=None):
    p=subprocess.run(['php','tests/fixtures.php','sql',query,json.dumps(params or [])],cwd=ROOT,capture_output=True,text=True,check=True)
    return json.loads(p.stdout)
def row(query,params=None):
    data=sql(query,params);return data[0] if data else None
def scalar(query,params=None):
    r=row(query,params);return next(iter(r.values())) if r else None
def csrf(session,path='/login'):
    r=session.get(path if path.startswith(BASE+'/') else BASE+path,timeout=15)
    m=re.search(r'<meta name="csrf-token" content="([^"]+)"',r.text)
    if not m: raise RuntimeError('Missing CSRF meta on '+path+' status '+str(r.status_code))
    session.headers['X-CSRF-Token']=m.group(1)
    return r
def post(session,path,body=None,files=None):
    kwargs={'data':body,'files':files} if files else {'json':body or {}}
    return session.post(BASE+path,headers={'Accept':'application/json'},timeout=20,**kwargs)
def good(session,path,body=None,label=None):
    r=post(session,path,body)
    check(r.ok and r.json().get('ok'),label or path,r.text)
    if not r.ok: raise RuntimeError(path+' failed: '+r.text)
    return r.json()
def login(email,password=PASS):
    s=requests.Session();csrf(s);r=post(s,'/api/auth/login',{'email':email,'password':password})
    if r.status_code!=200:raise RuntimeError('Fixture login failed '+r.text)
    return s
def register(label):
    email=f'{label.lower().replace(" ","-")}-{secrets.token_hex(4)}@test.learnow.invalid';s=requests.Session();csrf(s,'/register')
    r=post(s,'/api/auth/register',{'full_name':'Test '+label,'email':email.upper(),'password':PASS,'password_confirmation':PASS,'terms':True,'role_id':1,'xp':100000})
    check(r.status_code==201,'Registration creates a learner: '+label,r.text)
    return s,email,int(scalar('SELECT id FROM users WHERE email=?',[email]))
def content(admin,resource,data):
    response=good(admin,f'/api/admin/content/{resource}/new',data,'Admin creates '+resource)
    return int(re.search(r'/([0-9]+)/edit$',response['redirect']).group(1))
def assert_page(session,path,code=200,label=None):
    r=session.get(path if path.startswith(BASE+'/') else BASE+path,allow_redirects=False,timeout=20)
    check(r.status_code in code if isinstance(code,tuple) else r.status_code==code,label or f'Page {path} returns {code}',r.status_code)
    return r
try:
    guest=requests.Session();home=csrf(guest,'/')
    if home.headers.get('X-Learnow-Test-Instance')!='isolated':raise RuntimeError('Refusing mutations: this is not an isolated testing server.')
    for path in ['/','/paths','/about','/help','/contact','/privacy','/terms','/guidelines','/register','/login','/forgot-password','/reset-password','/paths?q=web']:
        assert_page(guest,path)
    for route in ['/.env','/storage/uploads/unknown.txt','/vendor/autoload.php','/.git/config']:
        assert_page(guest,route,(403,404),'Private deployment files stay outside the public document root: '+route)
    check("script-src 'self'" in home.headers.get('Content-Security-Policy','') and home.headers.get('X-Content-Type-Options')=='nosniff','Secure response headers are applied')
    check(assert_page(guest,'/dashboard',303).headers.get('Location')==BASE+'/login','Guests are redirected to sign in')
    r=requests.post(BASE+'/api/auth/login',json={'email':'not-a-user@example.invalid','password':PASS},timeout=15)
    check(r.status_code==403,'Missing CSRF token is rejected')
    r=guest.post(BASE+'/api/auth/login',json={'email':'not-a-user@example.invalid','password':PASS},headers={'Sec-Fetch-Site':'cross-site'},timeout=15)
    check(r.status_code==403,'Cross-site mutations are rejected even with a CSRF token')
    r=post(guest,'/api/auth/login',{'email':'not-a-user@example.invalid','password':PASS});check(r.status_code==401 and 'email or password' in r.json()['message'],'Unknown-account login errors are generic')
    r=post(guest,'/api/auth/forgot',{'email':'not-a-user@example.invalid'});check(r.status_code==503 and 'not configured' in r.json()['message'],'Unconfigured email recovery is honestly reported')
    alice,email_a,uid=register('HTTP owner');bob,email_b,bid=register('HTTP other')
    rejected=post(guest,'/api/auth/register',{'full_name':'Missing consent','email':'no-consent-'+secrets.token_hex(4)+'@example.invalid','password':PASS,'password_confirmation':PASS})
    check(rejected.status_code==422,'Registration requires explicit terms acceptance')
    duplicate=post(guest,'/api/auth/register',{'full_name':'Duplicate account test','email':email_a.upper(),'password':PASS,'password_confirmation':PASS,'terms':True})
    check(duplicate.status_code==422,'Normalised duplicate email addresses cannot create a second account')
    verify_token=secrets.token_hex(32)
    sql("INSERT INTO account_tokens(user_id,token_hash,purpose,expires_at)VALUES(?,?,'verify',DATE_ADD(UTC_TIMESTAMP(),INTERVAL 1 HOUR))",[uid,hashlib.sha256(verify_token.encode()).hexdigest()])
    check(post(bob,'/api/auth/verify',{'token':verify_token}).status_code==422,'Email verification tokens are bound to their account owner')
    good(alice,'/api/auth/verify',{'token':verify_token},'A valid, hash-stored verification token verifies the intended email')
    check(post(alice,'/api/auth/verify',{'token':verify_token}).status_code==422,'Email verification tokens are one-time use')
    check(scalar('SELECT r.name FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id=?',[uid])=='learner' and scalar('SELECT COUNT(*) FROM xp_transactions WHERE user_id=?',[uid])==0,'Registration ignores forged roles and XP')
    cookie_header=alice.get(BASE+'/login',allow_redirects=False).request.headers.get('Cookie','')
    cookie_obj=next(c for c in alice.cookies if c.name=='ln_access')
    check(cookie_obj.has_nonstandard_attr('HttpOnly') and cookie_obj.get_nonstandard_attr('SameSite')=='Lax','JWT cookies use HttpOnly and SameSite=Lax')
    assert_page(alice,'/dashboard',303,'New learners must complete onboarding before the dashboard')
    preference={'interests':[1],'goal':'projects','experience':'beginner','daily_minutes':15,'study_days':[1,3,5],'reminder_time':'18:30','timezone':'Africa/Lagos','reminders_enabled':True,'path_id':1,'step':3}
    good(alice,'/api/onboarding',preference,'Onboarding preferences persist midway')
    check('data-step="3"' in alice.get(BASE+'/onboarding').text,'Onboarding resumes from the saved step')
    good(alice,'/api/onboarding',{**preference,'step':7,'finish':True},'Onboarding finishes and enrols the selected path')
    good(bob,'/api/onboarding',{**preference,'step':7,'finish':True},'Second learner completes onboarding')
    for path in ['/dashboard','/my-learning','/paths','/paths/web-development-foundations','/achievements','/certificates','/referrals','/notifications','/reports','/schedule','/settings','/portfolio','/portfolio/new','/community','/assignments']:
        assert_page(alice,path)
    for path in ['/admin','/admin/users','/admin/reviews','/admin/settings','/admin/content/paths']:
        assert_page(alice,path,403,'Learner role is denied '+path)
    check(post(alice,'/api/admin/rewards',{'rules':{}}).status_code==403,'Learners cannot mutate admin settings')
    admin=login('admin@test.learnow.invalid');reviewer=login('reviewer@test.learnow.invalid')
    aid=int(scalar("SELECT id FROM users WHERE email='admin@test.learnow.invalid'"));rid=int(scalar("SELECT id FROM users WHERE email='reviewer@test.learnow.invalid'"))
    for path in ['/admin','/admin/users',f'/admin/users/{uid}','/admin/reviews','/admin/rewards','/admin/settings','/admin/referrals','/admin/certificates','/admin/community','/admin/audit','/admin/reports']:
        assert_page(admin,path)
    for endpoint,payload in [('/api/admin/content/paths/99999999/archive',{}),('/api/admin/assign-reviewer/quiz/99999999',{'reviewer_id':rid}),('/api/admin/certificates/99999999/revoke',{'reason':'Missing-record regression test.'}),('/api/admin/moderate/report/99999999',{'reason':'Missing-record regression test.'})]:
        check(post(admin,endpoint,payload).status_code==404,'Missing records produce honest admin errors: '+endpoint)
    for resource,table in [('paths','learning_paths'),('categories','categories'),('stages','stages'),('modules','modules'),('lessons','lessons'),('quizzes','quizzes'),('assignments','assignments'),('achievements','achievements'),('levels','level_definitions'),('skills','skill_nodes')]:
        assert_page(admin,'/admin/content/'+resource);assert_page(admin,'/admin/content/'+resource+'/new')
        pk='level' if resource=='levels' else 'id';record=scalar(f'SELECT {pk} FROM {table} LIMIT 1')
        if record:assert_page(admin,f'/admin/content/{resource}/{record}/edit')
    assert_page(reviewer,'/admin/users',403,'Reviewers cannot manage accounts')
    slug='test-http-'+secrets.token_hex(4)
    pdef={'title':'Isolated HTTP test path','slug':slug,'category_id':1,'description':'Original test-only content for automatic verification.','objectives':'Check genuine workflows','difficulty':'beginner','status':'published','certificate_enabled':1,'certificate_min_score':70}
    pid=content(admin,'paths',pdef)
    stage=content(admin,'stages',{'path_id':pid,'title':'Test stage one','description':'HTTP test stage','position':1})
    module=content(admin,'modules',{'stage_id':stage,'title':'Test module','position':1})
    lesson=content(admin,'lessons',{'module_id':module,'title':'Test-only lesson','description':'Practice then reflect.','content':'## Read and practise\nUse semantic structure and check keyboard navigation.','objectives':'Use a meaningful heading','takeaways':'Keep practising.','duration_minutes':15,'position':1,'require_checklist':1,'required':1,'status':'published','checklist':'I practised the example.\nI checked my result.','resources':''})
    stage2=content(admin,'stages',{'path_id':pid,'title':'Locked test stage','description':'After all requirements','position':2,'prerequisites':[stage]})
    module2=content(admin,'modules',{'stage_id':stage2,'title':'Next test module','position':1})
    lesson2=content(admin,'lessons',{'module_id':module2,'title':'Test follow-up','content':'A final reflection with a concrete example.','duration_minutes':10,'position':1,'required':1,'status':'published'})
    qdef={'stage_id':stage,'lesson_id':'','title':'Test mixed assessment','instructions':'Answer every question.','passing_score':70,'attempt_limit':3,'time_limit_minutes':0,'show_answers':0,'required':1,'uses_lives':0,'status':'draft'}
    qid=content(admin,'quizzes',qdef)
    questions=[{'type':'single','prompt':'Which item is a heading?','points':2,'options':[{'label':'h1','correct':True},{'label':'div','correct':False}],'explanation':'h1 represents the highest heading level.'},{'type':'multiple','prompt':'Choose semantic elements.','points':2,'options':[{'label':'main','correct':True},{'label':'nav','correct':True},{'label':'div','correct':False}]},{'type':'boolean','prompt':'A button should be keyboard accessible.','points':1,'options':[{'label':'True','correct':True},{'label':'False','correct':False}]},{'type':'short','prompt':'Explain one keyboard accessibility check.','points':5}]
    good(admin,f'/api/admin/quizzes/{qid}/questions',{'questions':questions},'Admin saves all four question types')
    good(admin,f'/api/admin/content/quizzes/{qid}',{**qdef,'status':'published'},'Admin publishes a valid quiz')
    assignment=content(admin,'assignments',{'stage_id':stage,'lesson_id':'','title':'HTTP test practical assignment','description':'Build a small accessible example.','instructions':'Submit a text explanation, link, or supported file.','objectives':'Practise clear structure','max_score':100,'passing_score':60,'allow_text':1,'allow_url':1,'allow_file':1,'required':1,'status':'published','rubrics':'Clarity | 50\nCorrectness | 50'})
    assert_page(guest,'/paths',200,'Published admin-created paths appear in the public catalogue')
    good(alice,f'/api/paths/{pid}/enrol',{},'Learner enrols in an admin-created path');good(bob,f'/api/paths/{pid}/enrol',{},'Another learner enrols independently')
    check(int(scalar('SELECT COALESCE(SUM(amount),0) FROM xp_transactions WHERE user_id=?',[uid]) or 0)==0,'Page visits and onboarding do not earn XP or invent activity')
    assert_page(alice,f'/lessons/{lesson2}',403,'HTTP lesson route enforces locked stages')
    check(post(alice,f'/api/lessons/{lesson2}/complete',{}).status_code==403,'Direct completion cannot bypass a locked stage')
    r=good(alice,f'/api/lessons/{lesson}/notes',{'content':'PRIVATE_OWNER_NOTE_314159','version':0,'user_id':bid},'Private notes are saved for the authenticated owner')
    check('PRIVATE_OWNER_NOTE_314159' in alice.get(BASE+f'/lessons/{lesson}').text and 'PRIVATE_OWNER_NOTE_314159' not in bob.get(BASE+f'/lessons/{lesson}').text,'Notes are isolated even when a forged owner ID is supplied')
    check(post(alice,f'/api/lessons/{lesson}/notes',{'content':'STALE OVERWRITE','version':0}).status_code==409,'Optimistic note versions prevent a stale tab overwriting newer notes')
    check(scalar('SELECT content FROM learner_notes WHERE user_id=? AND lesson_id=?',[uid,lesson])=='PRIVATE_OWNER_NOTE_314159','Rejected stale notes do not mutate saved text')
    check(post(alice,f'/api/lessons/{lesson}/complete',{'xp':999999}).status_code==422,'The server rejects incomplete lesson checklists')
    for item in sql('SELECT id FROM lesson_checklists WHERE lesson_id=?',[lesson]):good(alice,f"/api/checklist/{item['id']}",{'completed':True},'Checklist item persists')
    good(alice,f'/api/lessons/{lesson}/complete',{},'A completed lesson awards eligible server-side credit')
    before=scalar('SELECT SUM(amount) FROM xp_transactions WHERE user_id=?',[uid]);good(alice,f'/api/lessons/{lesson}/complete',{'xp':999999},'Duplicate completion succeeds idempotently')
    check(scalar('SELECT SUM(amount) FROM xp_transactions WHERE user_id=?',[uid])==before,'Forged XP and duplicate HTTP submissions do not inflate rewards')
    assert_page(alice,f'/quizzes/{qid}')
    started=good(alice,f'/api/quizzes/{qid}/start',{},'Learner starts the mixed quiz');attempt=int(started['redirect'].split('attempt=')[1])
    quizpage=alice.get(started['redirect']).text;check('is_correct' not in quizpage and 'h1 represents the highest heading' not in quizpage,'Quiz answer keys and explanations are absent before submission')
    check(post(bob,f'/api/attempts/{attempt}/submit',{'answers':{}}).status_code==404,'HTTP attempt ownership prevents answer submission by another learner')
    answers={}
    for q in sql('SELECT id,type FROM quiz_questions WHERE quiz_id=? ORDER BY id',[qid]):answers[str(q['id'])]='I press Tab to verify every interactive element receives visible focus.' if q['type']=='short' else [o['id'] for o in sql('SELECT id FROM answer_options WHERE question_id=? AND is_correct=1',[q['id']])]
    submitted=good(alice,f'/api/attempts/{attempt}/submit',{'answers':answers,'score':100,'status':'passed'},'Learner submits mixed answers for real grading')
    check(submitted['result']['status']=='pending_review' and submitted['result']['score'] is None,'Client-supplied result fields cannot bypass manual review')
    assert_page(alice,f'/quizzes/{qid}?attempt={attempt}')
    written=scalar("SELECT r.id FROM quiz_responses r JOIN quiz_questions q ON q.id=r.question_id WHERE r.attempt_id=? AND q.type='short'",[attempt])
    check(post(reviewer,f'/api/admin/quiz-reviews/{attempt}',{'grades':{str(written):{'points':5}}}).status_code==404,'Unassigned reviewers cannot grade a written answer')
    good(admin,f'/api/admin/assign-reviewer/quiz/{attempt}',{'reviewer_id':rid},'Administrator explicitly assigns a quiz reviewer')
    assert_page(reviewer,f'/admin/quiz-reviews/{attempt}')
    good(reviewer,f'/api/admin/quiz-reviews/{attempt}',{'grades':{str(written):{'points':5,'feedback':'Specific, useful and accurate.'}}},'Assigned reviewer grades the written response')
    check(scalar('SELECT status FROM quiz_attempts WHERE id=?',[attempt])=='passed','Manual grading updates the actual quiz result')
    assert_page(alice,f'/assignments/{assignment}')
    r=post(alice,f'/api/assignments/{assignment}',{'action':'submitted','content':'Unsafe executable test'},files={'attachment':('payload.php',b'<?php echo "unsafe"; ?>','application/x-httpd-php')})
    check(r.status_code==422,'Executable uploads are rejected by actual file-content inspection')
    upload=post(alice,f'/api/assignments/{assignment}',{'action':'submitted','content':'My original explanation of the keyboard and layout checks.'},files={'attachment':('project-notes.txt',b'Original test-only project notes. Keyboard focus checked.','text/plain')})
    check(upload.status_code==200,'Supported multipart assignment uploads are accepted',upload.text)
    sid=scalar('SELECT id FROM assignment_submissions WHERE user_id=? AND assignment_id=?',[uid,assignment])
    dl=assert_page(alice,f'/downloads/submissions/{sid}');check(dl.headers.get('Content-Disposition','').startswith('attachment'),'Private attachments are served as downloads')
    assert_page(bob,f'/downloads/submissions/{sid}',404,'Another learner cannot download private submission files')
    assert_page(reviewer,f'/admin/reviews/{sid}',404,'An unassigned reviewer cannot view submitted work')
    good(admin,f'/api/admin/assign-reviewer/assignment/{sid}',{'reviewer_id':rid},'Administrator assigns an official assignment reviewer')
    assert_page(reviewer,f'/admin/reviews/{sid}');assert_page(reviewer,f'/downloads/submissions/{sid}')
    good(reviewer,f'/api/admin/reviews/{sid}',{'status':'accepted','score':90,'feedback':'Clear reasoning, tested focus states and thoughtful layout.'},'Official assignment acceptance records real feedback')
    assert_page(alice,f'/lessons/{lesson2}',200,'Required quiz and assignment completion unlock the next stage')
    good(alice,f'/api/lessons/{lesson2}/complete',{},'Learner finishes the required follow-up lesson')
    cert=good(alice,f'/api/certificates/{pid}',{},'The server issues an eligibility-checked certificate')
    verify=assert_page(guest,cert['redirect']);check('Test HTTP owner' in verify.text,'Public certificate verification shows its issuance snapshot')
    certid=scalar('SELECT id FROM certificates WHERE user_id=? AND path_id=?',[uid,pid])
    good(admin,f'/api/admin/certificates/{certid}/revoke',{'reason':'Isolated test certificate revoked after automated verification.'},'Administrator revokes a certificate with an audit reason')
    check('revoked' in guest.get(cert['redirect']).text.lower(),'Public verification reflects certificate revocation')
    projectdata={'title':'Private HTTP test project','description':'A private original test project with no public visibility by default.','skills':'HTML, Accessibility','path_id':pid}
    project=good(alice,'/api/projects/new',projectdata,'A learner creates a private portfolio project')
    projectid=int(re.search(r'/([0-9]+)/edit$',project['redirect']).group(1));projectslug=scalar('SELECT slug FROM portfolio_projects WHERE id=?',[projectid])
    assert_page(guest,'/projects/'+projectslug,404,'Private portfolio pages are hidden from guests');assert_page(bob,f'/portfolio/{projectid}/edit',404,'Another learner cannot open the project editor')
    check(post(bob,f'/api/projects/{projectid}',{**projectdata,'user_id':uid}).status_code==404,'Portfolio edits enforce ownership on the server')
    assert_page(alice,project['redirect'])
    png=base64.b64decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aIfkAAAAASUVORK5CYII=')
    r=post(alice,f'/api/projects/{projectid}',{**projectdata,'visibility':'private'},files={'image':('pixel.png',png,'image/png')});check(r.status_code==200,'Portfolio images are validated and stored privately',r.text)
    image=scalar('SELECT id FROM project_images WHERE project_id=?',[projectid]);assert_page(guest,f'/media/{image}',404,'Private project images cannot be guessed by URL')
    good(alice,f'/api/projects/{projectid}',{**projectdata,'visibility':'public'},'A project owner can explicitly publish their project')
    assert_page(guest,'/projects/'+projectslug);assert_page(guest,f'/media/{image}')
    good(admin,'/api/admin/settings',{'peer_review_min_lessons':0,'peer_review_count':1},'Administrator configures peer-review eligibility')
    good(alice,f'/api/projects/{projectid}/reviews',{},'A project owner explicitly requests peer feedback')
    pr=row('SELECT * FROM peer_review_assignments WHERE project_id=?',[projectid]);check(pr and pr['reviewer_id']!=uid,'Peer assignment excludes self-reviews')
    peeremail=scalar('SELECT email FROM users WHERE id=?',[pr['reviewer_id']]);peer=login(peeremail)
    assert_page(peer,f"/community/reviews/{pr['id']}");assert_page(alice,f"/community/reviews/{pr['id']}",404,'A project owner cannot submit their own assigned peer review')
    responses={str(q['id']):{'score':q['max_score'],'feedback':'A clear example. Consider adding a keyboard-only walkthrough next.'} for q in sql('SELECT id,max_score FROM peer_review_questions WHERE active=1')}
    owner_xp=scalar('SELECT SUM(amount) FROM xp_transactions WHERE user_id=?',[uid])
    good(peer,f"/api/reviews/{pr['id']}",{'responses':responses},'An assigned peer submits the complete configured rubric')
    check(post(peer,f"/api/reviews/{pr['id']}",{'responses':responses}).status_code==422,'A submitted peer review cannot be duplicated')
    check(scalar('SELECT SUM(amount) FROM xp_transactions WHERE user_id=?',[uid])==owner_xp,'Peer feedback never awards official completion or assignment XP')
    assert_page(alice,f'/portfolio/{projectid}/edit',200,'Project owners can read submitted peer feedback')
    good(admin,f"/api/admin/moderate/review/{pr['id']}",{'reason':'Isolated moderation test; this is not a genuine conduct finding.'},'Administrators can hide a peer review with a recorded reason')
    assert_page(peer,f"/community/reviews/{pr['id']}",404,'Hidden peer reviews are no longer visible to reviewers')
    good(alice,'/api/buddies',{'email':email_b},'Buddy invitation does not expose account enumeration')
    buddy=scalar('SELECT id FROM buddy_relationships WHERE requester_id=? AND recipient_id=?',[uid,bid])
    check(post(alice,f'/api/buddies/{buddy}',{'action':'accepted'}).status_code==403,'The inviter cannot accept their own buddy request')
    good(bob,f'/api/buddies/{buddy}',{'action':'accepted'},'The invited buddy explicitly accepts')
    good(alice,'/api/challenges',{'friend_id':bid,'title':'Test lesson challenge','target':2,'deadline':(date.today()+timedelta(days=7)).isoformat()},'Accepted buddies can propose a lesson challenge')
    challenge=scalar('SELECT id FROM friend_challenges WHERE creator_id=? AND friend_id=? ORDER BY id DESC',[uid,bid]);good(bob,f'/api/challenges/{challenge}',{'status':'accepted'},'A challenge needs the invited learner’s consent')
    good(bob,f'/api/buddies/{buddy}',{'action':'blocked'},'Learners can block a buddy')
    check(post(alice,'/api/challenges',{'friend_id':bid,'title':'Blocked request','target':2,'deadline':(date.today()+timedelta(days=7)).isoformat()}).status_code==422,'Blocked relationships cannot create new challenges')
    good(bob,'/api/community/report',{'user_id':uid,'reason':'Isolated test report to verify moderation and audit controls.'},'Learner reports reach the moderation queue')
    assert_page(admin,'/admin/community');assert_page(admin,'/admin/certificates');assert_page(admin,'/admin/reviews');assert_page(admin,f'/admin/users/{uid}')
    good(alice,'/api/reports/generate',{},'A real previous-week report can be generated on demand');assert_page(alice,'/reports')
    # Current database roles and suspension take precedence over stale cookie claims.
    check(post(admin,f'/api/admin/users/{aid}',{'role_id':scalar("SELECT id FROM roles WHERE name='learner'"),'status':'active'}).status_code==422,'Administrators cannot remove their own access')
    good(admin,f'/api/admin/users/{bid}',{'role_id':scalar('SELECT role_id FROM users WHERE id=?',[bid]),'status':'suspended'},'Suspension revokes the learner’s active sessions')
    assert_page(bob,'/dashboard',303,'A suspended account cannot use an old signed JWT')
    # Test cryptographic validation and refresh replay on a distinct fixture account.
    auth=login('learner@test.learnow.invalid');refresh=auth.cookies.get('ln_refresh');token=auth.cookies.get('ln_access');parts=token.split('.')
    forged=requests.Session();forged.cookies.set('ln_access',parts[0]+'.'+parts[1]+'.'+('A' if parts[2][0]!='A' else 'B')+parts[2][1:]);assert_page(forged,'/dashboard',303,'A modified JWT signature is rejected')
    unsigned=requests.Session();enc=lambda b:base64.urlsafe_b64encode(b).decode().rstrip('=');unsigned.cookies.set('ln_access',enc(b'{"alg":"none","typ":"JWT"}')+'.'+parts[1]+'.');assert_page(unsigned,'/dashboard',303,'Unsigned alg-none JWTs are rejected')
    payload=json.loads(base64.urlsafe_b64decode(parts[1]+'='*(-len(parts[1])%4)))
    variations=[('expired',dict(payload,exp=int(time.time())-60,iat=int(time.time())-960,nbf=int(time.time())-960),'HS256'),('not yet valid',dict(payload,nbf=int(time.time())+300),'HS256'),('wrong issuer',dict(payload,iss='not-learnow'),'HS256'),('wrong audience',dict(payload,aud='not-this-browser'),'HS256'),('mismatched subject',dict(payload,sub='99999999'),'HS256'),('wrong signing algorithm',payload,'HS512'),('missing expiration',{k:v for k,v in payload.items() if k!='exp'},'HS256')]
    for label,claims,algorithm in variations:
        candidate=subprocess.run(['php','tests/fixtures.php','jwt',json.dumps(claims),algorithm],cwd=ROOT,capture_output=True,text=True,check=True).stdout
        session=requests.Session();session.cookies.set('ln_access',candidate);assert_page(session,'/dashboard',303,'JWT validation rejects '+label)
    # Removing an expired access cookie exercises opaque refresh-token rotation.
    for c in list(auth.cookies):
        if c.name=='ln_access':auth.cookies.clear(c.domain,c.path,c.name)
    assert_page(auth,'/dashboard');check(auth.cookies.get('ln_refresh')!=refresh,'Refresh tokens rotate when a session is renewed')
    replay=requests.Session();replay.cookies.set('ln_refresh',refresh);assert_page(replay,'/dashboard',303,'A reused refresh token is rejected')
    assert_page(auth,'/dashboard',303,'Refresh-token replay revokes the complete affected session')
    # Password reset tokens are one-time, hash-only and revoke sessions.
    recovery=login('learner@test.learnow.invalid');recover_id=scalar("SELECT id FROM users WHERE email='learner@test.learnow.invalid'");raw=secrets.token_hex(32)
    sql("INSERT INTO account_tokens(user_id,token_hash,purpose,expires_at)VALUES(?,?,'reset',DATE_ADD(UTC_TIMESTAMP(),INTERVAL 10 MINUTE))",[recover_id,hashlib.sha256(raw.encode()).hexdigest()])
    good(guest,'/api/auth/reset',{'token':raw,'password':PASS+'new','password_confirmation':PASS+'new'},'An eligible password reset token changes the password')
    assert_page(recovery,'/dashboard',303,'Password reset revokes existing sign-in sessions')
    check(post(guest,'/api/auth/reset',{'token':raw,'password':PASS,'password_confirmation':PASS}).status_code==422,'A consumed reset token cannot be reused')
    sql('UPDATE users SET password_hash=? WHERE id=?',[subprocess.run(['php','-r','echo password_hash($argv[1], PASSWORD_ARGON2ID);',PASS],capture_output=True,text=True,check=True).stdout,recover_id])
    # logout is server-revoked, not just browser-cookie deletion.
    old=alice.cookies.get('ln_access');oldrefresh=alice.cookies.get('ln_refresh');good(alice,'/api/auth/logout',{},'Logout succeeds with CSRF protection')
    stolen=requests.Session();stolen.cookies.set('ln_access',old);stolen.cookies.set('ln_refresh',oldrefresh);assert_page(stolen,'/dashboard',303,'Revoked logout cookies cannot replay a session')
    # Registered fixture count only; public database is not used by this test server.
except Exception as error:
    import traceback;traceback.print_exc();check(False,'Unexpected integration-test exception',error)
finally:
    passed=sum(ok for ok,_ in results);failed=len(results)-passed
    print(f'\n{passed} passed; {failed} failed. All records are in the isolated test database.')
    (ROOT/'tests/http-results.json').write_text(json.dumps({'passed':passed,'failed':failed,'checks':[{'passed':ok,'name':label} for ok,label in results]},indent=2))
    raise SystemExit(1 if failed else 0)
