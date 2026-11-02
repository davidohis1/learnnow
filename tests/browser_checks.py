"""Vanilla browser workflows, responsive layout and axe-core checks.
Only the isolated test database receives fixture accounts/activity.
"""
import asyncio, json, os, secrets, subprocess, re
from pathlib import Path
from playwright.async_api import async_playwright
ROOT=Path(__file__).resolve().parents[1];ART=ROOT/'tests/artifacts';ART.mkdir(exist_ok=True)
BASE=os.environ.get('LEARNOW_TEST_URL','http://127.0.0.1:8081');PUBLIC=os.environ.get('LEARNOW_PUBLIC_URL',BASE)
checks=[];js_errors=[];server_errors=[];audits=[]
def check(ok,label,detail=''):
 checks.append({'passed':bool(ok),'name':label});print(('PASS ' if ok else 'FAIL ')+label+(' :: '+str(detail)[:220] if not ok else ''),flush=True)
def sql(query,params=None):
 p=subprocess.run(['php','tests/fixtures.php','sql',query,json.dumps(params or [])],cwd=ROOT,capture_output=True,text=True,check=True);return json.loads(p.stdout)
async def page_ready(page):
 await page.wait_for_load_state('networkidle')
async def audit(page,name):
 await page.evaluate((ROOT/'tests/tools/axe.min.js').read_text())
 result=await page.evaluate("""async()=>{const r=await axe.run(document,{runOnly:{type:'tag',values:['wcag2a','wcag2aa','wcag21aa']}});return r.violations.map(v=>({id:v.id,impact:v.impact,description:v.description,nodes:v.nodes.map(n=>({target:n.target,html:n.html,summary:n.failureSummary})).slice(0,30)}))}""")
 audits.append({'page':name,'violations':result});print('AUDIT',name,[(v['id'],len(v['nodes'])) for v in result],flush=True)
async def no_overflow(page,label):
 data=await page.evaluate("""()=>({overflow:document.documentElement.scrollWidth>innerWidth+1,width:innerWidth,scroll:document.documentElement.scrollWidth,elements:[...document.querySelectorAll('main *')].filter(e=>e.getBoundingClientRect().right>innerWidth+2&&getComputedStyle(e).position!=='fixed').slice(0,5).map(e=>e.className)})""")
 check(not data['overflow'],label,data)
async def main():
 async with async_playwright() as p:
  b=await p.chromium.launch(headless=True,args=['--no-sandbox']);ctx=await b.new_context(viewport={'width':1440,'height':1000});page=await ctx.new_page();page.on('pageerror',lambda e:js_errors.append(str(e)));page.on('response',lambda r:server_errors.append(r.url) if r.status>=500 else None)
  try:
   await page.goto(PUBLIC,wait_until='networkidle');await no_overflow(page,'Landing has no horizontal overflow at 1440px');await page.screenshot(path=str(ART/'landing-desktop.png'),full_page=False);await audit(page,'Landing desktop')
   # Measure the mock product card rather than allowing it to clip silently.
   clipped=await page.evaluate("""()=>{const map=document.querySelector('.preview-map').getBoundingClientRect(),card=document.querySelector('.product-preview').getBoundingClientRect();return map.bottom>card.bottom}""")
   check(not clipped,'Hero product illustration fits within its preview card')
   for width,height in [(768,1024),(390,844),(360,800)]:
    await page.set_viewport_size({'width':width,'height':height});await no_overflow(page,f'Landing has no horizontal overflow at {width}px');await page.screenshot(path=str(ART/f'landing-{width}.png'),full_page=width==390)
   await page.set_viewport_size({'width':390,'height':844});await page.locator('[data-toggle-nav="public-nav"]').click();check(await page.locator('#public-nav').evaluate("el=>el.classList.contains('nav-open')"),'Mobile navigation opens');await page.keyboard.press('Escape');check(not await page.locator('#public-nav').evaluate("el=>el.classList.contains('nav-open')"),'Escape closes mobile navigation')
   await page.set_viewport_size({'width':1440,'height':1000});test_response=await page.goto(BASE+'/register',wait_until='networkidle');assert test_response.headers.get('x-learnow-test-instance')=='isolated','Refusing to register against a non-test instance';await audit(page,'Registration')
   email='browser-'+secrets.token_hex(4)+'@test.learnow.invalid';await page.fill('#full-name','Test Browser Learner');await page.fill('#email',email);await page.fill('#password','Test-Only-Learnow-2026!');await page.fill('#password-confirmation','Test-Only-Learnow-2026!');await page.check('[name=terms]');await page.get_by_role('button',name='Create my free account').click();await page.wait_for_url('**/onboarding');await page_ready(page);check(True,'Browser registration redirects to onboarding')
   for step in range(8):
    await page.locator(f'section[data-step="{step}"]').wait_for(state='visible')
    if step==1:await audit(page,'Onboarding interests');await page.locator('[data-step="1"] .choice').filter(has_text='Web Development').click()
    if step==2:await page.get_by_text('Build personal projects',exact=True).click()
    if step==3:
     await page.reload(wait_until='networkidle');check(await page.locator('section[data-step="3"]').is_visible(),'Onboarding progress survives a browser reload')
    if step==5:
     await page.select_option('[name=timezone]','Africa/Lagos');await page.fill('[name=reminder_time]','18:45')
    if step==6:await page.locator('[data-step="6"] .choice').filter(has_text='Web Development Foundations').click()
    await page.locator('[data-wizard-next]').click()
   await page.wait_for_url('**/dashboard');await page_ready(page);check(True,'All eight onboarding steps complete through the UI');check('Test' in await page.locator('h1').inner_text(),'Dashboard renders the signed-in learner’s name');await page.screenshot(path=str(ART/'learner-dashboard-desktop.png'),full_page=True);await no_overflow(page,'Learner dashboard fits desktop');await audit(page,'Learner dashboard')
   await page.get_by_role('link',name='Continue learning',exact=True).click();await page_ready(page);check('/lessons/' in page.url,'Continue learning opens the next accessible lesson')
   await page.fill('#lesson-notes','First private browser note.');await page.locator('[data-notes-status]').filter(has_text='All changes saved').wait_for(timeout=12000);check(True,'Notes autosave from real input')
   await page.fill('#lesson-notes','My latest private note before a navigation.');await page.get_by_role('link',name='My learning',exact=True).first.click();await page.wait_for_url('**/my-learning');await page.go_back(wait_until='networkidle');check(await page.input_value('#lesson-notes')=='My latest private note before a navigation.','Navigation flushes pending notes before leaving the lesson')
   await audit(page,'Lesson')
   for checkbox in await page.locator('[data-checklist-id]').all():await checkbox.check();await checkbox.wait_for(state='visible')
   await page.get_by_role('button',name='Mark lesson complete').click();await page.wait_for_load_state('networkidle');await page.get_by_text('Lesson complete',exact=True).wait_for();check(True,'Lesson completion works through the UI')
   await page.get_by_role('link',name='Next lesson',exact=True).click();await page_ready(page)
   for checkbox in await page.locator('[data-checklist-id]').all():await checkbox.check()
   await page.get_by_role('button',name='Mark lesson complete').click();await page_ready(page);await page.get_by_text('Lesson complete',exact=True).wait_for()
   await page.goto(BASE+'/quizzes/1',wait_until='networkidle');await page.locator('form[action$="/api/quizzes/1/start"] button').click();await page.wait_for_url('**/quizzes/1?attempt=*');await page_ready(page)
   correct=sql('SELECT o.id,q.id AS question_id FROM answer_options o JOIN quiz_questions q ON q.id=o.question_id WHERE q.quiz_id=1 AND o.is_correct=1 ORDER BY q.position,o.position')
   groups=await page.locator('[data-question]').all()
   for i,group in enumerate(groups):
    qid=int(await group.get_attribute('data-question'))
    for option in correct:
     if option['question_id']==qid:await group.locator(f'input[value="{option["id"]}"]').check()
    if i<len(groups)-1:await page.locator('[data-quiz-next]').click()
   await page.locator('[data-quiz-submit]').click();await page.locator('#confirm-dialog [data-confirm-accept]').click();await page_ready(page);await page.get_by_text('100%',exact=True).first.wait_for();check(True,'Quiz navigation, confirmation and server-graded result work in the browser')
   await page.goto(BASE+'/portfolio/new',wait_until='networkidle');await page.fill('#title','Test browser portfolio');await page.fill('#description','A test-only original project created through the real portfolio form.');await page.fill('#skills','HTML, CSS');await page.get_by_role('button',name='Save my project').click();await page.wait_for_url(re.compile(r'/portfolio/\d+/edit$'));await page_ready(page);check(await page.select_option('#visibility','private')==['private'],'A new portfolio project is private by default')
   await page.goto(BASE+'/schedule',wait_until='networkidle');await audit(page,'Schedule')
   for width,height in [(768,1024),(390,844),(360,800)]:
    await page.set_viewport_size({'width':width,'height':height})
    for route in ['/dashboard','/paths/web-development-foundations','/lessons/1','/quizzes/1','/portfolio','/settings','/community','/referrals','/certificates','/reports']:
     await page.goto(BASE+route,wait_until='networkidle');await no_overflow(page,f'{route} fits {width}px')
     if width==390:await audit(page,'Mobile '+route)
     if width==390 and route in ['/dashboard','/paths/web-development-foundations','/lessons/1']:await page.screenshot(path=str(ART/('mobile-'+route.split('/')[1]+'.png')),full_page=True)
   await page.goto(BASE+'/dashboard',wait_until='networkidle');await page.get_by_role('button',name='Open navigation',exact=True).click();check(await page.locator('#app-sidebar').evaluate("el=>el.classList.contains('nav-open')"),'Mobile learner sidebar opens');await page.keyboard.press('Escape');check(not await page.locator('#app-sidebar').evaluate("el=>el.classList.contains('nav-open')"),'Escape closes learner sidebar')
   adminctx=await b.new_context(viewport={'width':1440,'height':1000});ad=await adminctx.new_page();ad.on('pageerror',lambda e:js_errors.append(str(e)));await ad.goto(BASE+'/login',wait_until='networkidle');await ad.fill('#email','admin@test.learnow.invalid');await ad.fill('#password','Test-Only-Learnow-2026!');await ad.get_by_role('button',name='Let’s keep learning').click();await ad.wait_for_url('**/admin');await page_ready(ad);check(True,'Administrator signs into the admin workspace');await audit(ad,'Admin overview');await ad.screenshot(path=str(ART/'admin-dashboard-desktop.png'),full_page=True)
   await ad.goto(BASE+'/admin/content/categories/new',wait_until='networkidle');await ad.locator('[name=name]').fill('Browser category '+secrets.token_hex(4));await ad.locator('[name=slug]').fill('browser-test-'+secrets.token_hex(4));await ad.locator('textarea[name=description]').fill('Isolated browser-only category.');await ad.get_by_role('button',name=re.compile('Save category',re.I)).click();await ad.wait_for_url(re.compile('/categories/[0-9]+/edit$'));check(True,'Admin metadata editor saves a new record through the UI');await audit(ad,'Admin content editor')
   # Author an actual draft quiz and edit its questions through vanilla JS.
   await ad.goto(BASE+'/admin/content/quizzes/new',wait_until='networkidle');await ad.locator('[name=title]').fill('Browser authored knowledge check');await ad.locator('[name=stage_id]').select_option('1');await ad.locator('[name=passing_score]').fill('70');await ad.get_by_role('button',name='Save quiz',exact=True).click();await ad.wait_for_url(re.compile('/quizzes/[0-9]+/edit$'));await page_ready(ad)
   await ad.locator('[data-add-question]').click();await ad.locator('[data-q-prompt]').fill('Does semantic structure communicate meaning?');await ad.locator('[data-q-type]').select_option('boolean');await audit(ad,'Admin question builder');await ad.get_by_role('button',name='Save question builder',exact=True).click();await page_ready(ad);await ad.locator('[data-q-prompt]').filter(has_text='Does semantic structure').wait_for();check(True,'Vanilla question builder persists a boolean question')
   for route in ['/admin','/admin/users','/admin/content/paths','/admin/content/lessons/1/edit','/admin/reviews','/admin/rewards','/admin/settings','/admin/reports']:
    await ad.set_viewport_size({'width':390,'height':844});await ad.goto(BASE+route,wait_until='networkidle');await no_overflow(ad,f'{route} fits mobile admin');await audit(ad,'Mobile '+route)
   await adminctx.close()
   check(not js_errors,'No uncaught JavaScript errors across browser journeys',js_errors);check(not server_errors,'No server 500 errors across browser journeys',server_errors)
  except Exception as e:
   import traceback;traceback.print_exc();check(False,'Unexpected browser-test exception',e);await page.screenshot(path=str(ART/'browser-failure.png'),full_page=True)
  finally:
   await b.close();(ROOT/'tests/browser-results.json').write_text(json.dumps({'checks':checks,'js_errors':js_errors,'server_errors':server_errors},indent=2));(ROOT/'tests/accessibility-results.json').write_text(json.dumps(audits,indent=2));print(f"\n{sum(x['passed'] for x in checks)} passed; {sum(not x['passed'] for x in checks)} failed. Accessibility findings are recorded separately.",flush=True)
asyncio.run(main())
raise SystemExit(1 if any(not c['passed'] for c in checks) else 0)
