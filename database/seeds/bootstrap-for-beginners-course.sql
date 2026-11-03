-- Bootstrap 5 Crash Course: 20 video lessons + final project briefing, 21 quizzes, 20 practice assignments and 2 final projects.
-- Built from the Net Ninja "Bootstrap 5 Crash Course Tutorial" videos you provided.
-- Run in phpMyAdmin with YOUR database selected. Run it once.
-- To reinstall later, first run:  DELETE FROM learning_paths WHERE slug='bootstrap-for-beginners';  (this also deletes enrolments and progress for the course)
START TRANSACTION;
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Web Development','web-development','Build useful things for the web.','code','orange',1);
SET @cat=(SELECT id FROM categories WHERE slug='web-development');
INSERT INTO learning_paths(category_id,title,slug,description,objectives,difficulty,status,certificate_enabled,certificate_min_score) VALUES(@cat,'Bootstrap 5 Crash Course', 'bootstrap-for-beginners', 'Style pages fast with Bootstrap 5. Follow 20 short video lessons on setup, colour, typography, buttons, utilities, containers, the 12-column grid, navbars, cards, accordions, icons, forms and interactive components such as tooltips, modals, offcanvas, dropdowns and tabs. Pass a quiz after every lesson, practise with an assignment and finish with a real responsive project.', 'Set up Bootstrap 5 from a CDN and read the documentation
Use colour, typography, buttons and utility classes to style quickly
Lay pages out with containers and the responsive 12-column grid
Build navbars, cards, accordions, lists, forms and icon buttons
Add interactive components: tooltips, modals, offcanvas, dropdowns and tabs
Customise Bootstrap with CSS variables and Sass', 'beginner', 'published', 1, 60);
SET @path=LAST_INSERT_ID();
SET @prev_stage=NULL;

-- ===== STAGE 1: Getting Started =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Getting Started','Meet Bootstrap 5, create your project and load the framework.',0);
SET @stage=LAST_INSERT_ID();
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Getting Started',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Getting Started');

-- Lesson 1: Intro & Setup
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Intro & Setup', 'See what the course builds and set up a project that loads Bootstrap 5 from a CDN.', 'Create a project folder with an index.html file.
Link the Bootstrap CSS and JavaScript bundle files.
Open the page in a browser and confirm Bootstrap is working.', '## What this lesson covers

See what the course builds and set up a project that loads Bootstrap 5 from a CDN.

- Bootstrap 5 is a CSS framework that supplies ready-made classes for layout and components.
- The CSS link controls styling; the JavaScript bundle adds interactive behaviour.
- Your own stylesheet must be linked after Bootstrap so your rules win.

## Key code
```html
<!-- in the head -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- before the closing body tag -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
```

## Tip
Link your own stylesheet after the Bootstrap CSS so your overrides always win.

## Practice
Create a folder named bootstrap-practice. Add an index.html file with the Bootstrap CSS link, the JS bundle script before the closing body tag, and one button using the btn btn-primary classes. Take a screenshot of the styled button.', 'Bootstrap 5 is a CSS framework that supplies ready-made classes for layout and components.
The CSS link controls styling; the JavaScript bundle adds interactive behaviour.
Your own stylesheet must be linked after Bootstrap so your rules win.', 'O_9u1P5YjVc', 7, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a project folder with an index.html file.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Link the Bootstrap CSS and JavaScript bundle files.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Open the page in a browser and confirm Bootstrap is working.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=O_9u1P5YjVc'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Intro & Setup','https://www.youtube.com/results?search_query=Intro+&+Setup'),(@lesson,'Bootstrap docs: Get started','https://getbootstrap.com/docs/5.3/getting-started/introduction/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Intro & Setup','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which Bootstrap file adds component behaviour such as modals and dropdowns?','The JavaScript bundle powers interactive components. The CSS file only styles them.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'bootstrap.bundle.min.js',1,0),(@q,'bootstrap.min.css',0,1),(@q,'index.html',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','You must install Bootstrap with npm before you can use it.','You can use the CDN links or download the compiled files; npm is optional.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Intro & Setup','Practise: See what the course builds and set up a project that loads Bootstrap 5 from a CDN','Create a folder named bootstrap-practice. Add an index.html file with the Bootstrap CSS link, the JS bundle script before the closing body tag, and one button using the btn btn-primary classes. Take a screenshot of the styled button.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Intro & Setup: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 2: Bootstrap 5 New Features
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Bootstrap 5 New Features', 'Learn what changed in Bootstrap 5 compared with version 4 and why it is easier to use.', 'Name three changes in Bootstrap 5.
Explain why jQuery is no longer required.
Spot a new utility or component class in the docs.', '## What this lesson covers

Learn what changed in Bootstrap 5 compared with version 4 and why it is easier to use.

- Bootstrap 5 no longer needs jQuery; components use vanilla JavaScript.
- Internet Explorer support was dropped, which allows modern CSS such as custom properties and flexbox gaps.
- Bootstrap 5 adds an xxl breakpoint, responsive font sizes with RFS and utility API classes.

## Tip
Check which version a tutorial targets. Bootstrap 4 examples use classes that Bootstrap 5 changed or removed.

## Practice
Open the Bootstrap 5 docs and list three things that changed from version 4 in a text file. Add a responsive heading using the display-4 class to your practice page.', 'Bootstrap 5 no longer needs jQuery; components use vanilla JavaScript.
Internet Explorer support was dropped, which allows modern CSS such as custom properties and flexbox gaps.
Bootstrap 5 adds an xxl breakpoint, responsive font sizes with RFS and utility API classes.', 'YQRmczOYIG0', 4, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name three changes in Bootstrap 5.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why jQuery is no longer required.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Spot a new utility or component class in the docs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=YQRmczOYIG0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Bootstrap 5 New Features','https://www.youtube.com/results?search_query=Bootstrap+5+New+Features'),(@lesson,'Bootstrap docs: Migrating to v5','https://getbootstrap.com/docs/5.3/migration/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Bootstrap 5 New Features','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why does Bootstrap 5 not need jQuery?','Bootstrap 5 rewrote its plugins in plain JavaScript.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Its components are written in vanilla JavaScript',1,0),(@q,'jQuery is built into the CSS file',0,1),(@q,'Browsers now include jQuery',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which extra grid breakpoint did Bootstrap 5 introduce?','Bootstrap 5 adds the xxl breakpoint above xl.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'xxl',1,0),(@q,'xxxl',0,1),(@q,'sm-xs',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Bootstrap 5 New Features','Practise: Learn what changed in Bootstrap 5 compared with version 4 and why it is easier to use','Open the Bootstrap 5 docs and list three things that changed from version 4 in a text file. Add a responsive heading using the display-4 class to your practice page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Bootstrap 5 New Features: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 2: Colour, Typography and Buttons =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Colour, Typography and Buttons','Use the colour palette, text helpers, buttons and utility classes.',1);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Colour, Typography and Buttons',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Colour, Typography and Buttons');

-- Lesson 3: Colours & Typography
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Colours & Typography', 'Apply Bootstrap colour classes to text and backgrounds and use its typography helpers.', 'Colour text and backgrounds with theme classes.
Change text size, weight and alignment.
Use lead, blockquote and truncate helpers.', '## What this lesson covers

Apply Bootstrap colour classes to text and backgrounds and use its typography helpers.

- Theme classes such as text-primary, text-danger and bg-dark set colours without custom CSS.
- Display headings (display-1 to display-6) create large page titles.
- Text utilities cover alignment, weight, case, decoration and truncation.

## Key code
```html
<h1 class="display-3">Hello Bootstrap</h1>
<p class="lead">A short, larger introduction.</p>
<p class="text-muted">Small print in a softer colour.</p>
<div class="bg-dark text-white p-4">Dark panel</div>
```

## Practice
Build a small page with one h1 using display-3, a lead paragraph, three paragraphs coloured with text-primary, text-success and text-muted, and a dark section using bg-dark text-white p-4.', 'Theme classes such as text-primary, text-danger and bg-dark set colours without custom CSS.
Display headings (display-1 to display-6) create large page titles.
Text utilities cover alignment, weight, case, decoration and truncation.', 'iUCyU_U0J2E', 10, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Colour text and backgrounds with theme classes.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Change text size, weight and alignment.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use lead, blockquote and truncate helpers.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=iUCyU_U0J2E'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Colours & Typography','https://www.youtube.com/results?search_query=Colours+&+Typography'),(@lesson,'Bootstrap docs: Typography','https://getbootstrap.com/docs/5.3/content/typography/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Colours & Typography','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class makes a paragraph larger and lighter for an introduction?','The lead class styles a short introductory paragraph.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'lead',1,0),(@q,'display-1',0,1),(@q,'fw-bold',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','bg-primary sets the background colour to the theme primary colour.','bg-* classes set background colours from the theme palette.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Colours & Typography','Practise: Apply Bootstrap colour classes to text and backgrounds and use its typography helpers','Build a small page with one h1 using display-3, a lead paragraph, three paragraphs coloured with text-primary, text-success and text-muted, and a dark section using bg-dark text-white p-4.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Colours & Typography: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 4: Buttons & Button Groups
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Buttons & Button Groups', 'Style links and buttons and group them together.', 'Create solid, outline and size-variant buttons.
Disable a button and style links as buttons.
Group related buttons with btn-group.', '## What this lesson covers

Style links and buttons and group them together.

- The btn class is required and a variant class such as btn-primary sets the colour.
- Outline variants use btn-outline-* and stay light until hovered.
- btn-group joins buttons visually and optional btn-group-lg or btn-group-sm changes their size.

## Key code
```html
<button class="btn btn-primary">Save</button>
<button class="btn btn-outline-secondary">Cancel</button>
<div class="btn-group">
  <button class="btn btn-success">Left</button>
  <button class="btn btn-success">Middle</button>
  <button class="btn btn-success">Right</button>
</div>
```

## Practice
Create a row of four buttons: one primary, one outline-secondary, one large warning and one disabled. Then group three buttons in a btn-group and screenshot the result.', 'The btn class is required and a variant class such as btn-primary sets the colour.
Outline variants use btn-outline-* and stay light until hovered.
btn-group joins buttons visually and optional btn-group-lg or btn-group-sm changes their size.', 'ZZXGmoQ4PdI', 7, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create solid, outline and size-variant buttons.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Disable a button and style links as buttons.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Group related buttons with btn-group.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=ZZXGmoQ4PdI'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Buttons & Button Groups','https://www.youtube.com/results?search_query=Buttons+&+Button+Groups'),(@lesson,'Bootstrap docs: Buttons','https://getbootstrap.com/docs/5.3/components/buttons/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Buttons & Button Groups','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pair of classes creates a blue solid button?','The btn class plus a variant class creates a solid themed button.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'btn btn-primary',1,0),(@q,'button primary',0,1),(@q,'btn-outline-primary',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class keeps buttons on one line as a joined group?','btn-group wraps the buttons and removes the gaps between them.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'btn-group',1,0),(@q,'btn-row',0,1),(@q,'d-inline',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Buttons & Button Groups','Practise: Style links and buttons and group them together','Create a row of four buttons: one primary, one outline-secondary, one large warning and one disabled. Then group three buttons in a btn-group and screenshot the result.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Buttons & Button Groups: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 5: Utility Classes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Utility Classes', 'Use the utility classes for spacing, display, flexbox, borders and more.', 'Apply margin and padding utilities.
Show and hide elements at different screen sizes.
Centre items with flex utilities.', '## What this lesson covers

Use the utility classes for spacing, display, flexbox, borders and more.

- Spacing utilities follow a pattern: m for margin, p for padding, plus a side and a size such as mt-3.
- Display utilities such as d-none and d-lg-block control visibility per breakpoint.
- Flex utilities turn an element into a flex container and align its children.

## Key code
```html
<div class="d-flex justify-content-center align-items-center" style="min-height:60vh">
  <div class="p-4 mt-5 border rounded shadow-sm">Pricing card</div>
</div>
```

## Practice
Rebuild a simple pricing card using only utility classes for spacing, borders, rounded corners and shadow. Centre it on the page with d-flex, justify-content-center and align-items-center and a min-height.', 'Spacing utilities follow a pattern: m for margin, p for padding, plus a side and a size such as mt-3.
Display utilities such as d-none and d-lg-block control visibility per breakpoint.
Flex utilities turn an element into a flex container and align its children.', 'nCeHeA7IsvU', 12, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Apply margin and padding utilities.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Show and hide elements at different screen sizes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Centre items with flex utilities.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=nCeHeA7IsvU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Utility Classes','https://www.youtube.com/results?search_query=Utility+Classes'),(@lesson,'Bootstrap docs: Utilities','https://getbootstrap.com/docs/5.3/utilities/spacing/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Utility Classes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class adds margin on the top only?','The t stands for top, so mt-3 sets top margin.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'mt-3',1,0),(@q,'m-3',0,1),(@q,'pt-3',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class hides an element on small screens but shows it from the large breakpoint up?','Combine d-none with d-lg-block to reveal the element at large sizes.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'d-none d-lg-block',1,0),(@q,'d-lg-none',0,1),(@q,'d-block d-none',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Utility Classes','Practise: Use the utility classes for spacing, display, flexbox, borders and more','Rebuild a simple pricing card using only utility classes for spacing, borders, rounded corners and shadow. Centre it on the page with d-flex, justify-content-center and align-items-center and a min-height.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Utility Classes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 3: Containers and the Grid =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Containers and the Grid','Control page width and build responsive multi-column layouts.',2);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Containers and the Grid',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Containers and the Grid');

-- Lesson 6: Containers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Containers', 'Use containers to hold content at sensible widths.', 'Use container, container-fluid and responsive containers.
Nest content inside a container correctly.
Choose the right container for a layout.', '## What this lesson covers

Use containers to hold content at sensible widths.

- container centres content and sets a max width that changes at each breakpoint.
- container-fluid always fills the full width of the viewport.
- Responsive containers such as container-md stay fluid until that breakpoint.

## Key code
```html
<div class="container">Fixed-width content</div>
<div class="container-fluid">Full-width content</div>
<div class="container-lg">Fluid until the lg breakpoint</div>
```

## Practice
Create three stacked sections, each using a different container class, with a background colour on each container so you can see the width change as you resize the window. Screenshot both a narrow and a wide window.', 'container centres content and sets a max width that changes at each breakpoint.
container-fluid always fills the full width of the viewport.
Responsive containers such as container-md stay fluid until that breakpoint.', 'Y6q8R-9y6a0', 6, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use container, container-fluid and responsive containers.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Nest content inside a container correctly.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose the right container for a layout.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Y6q8R-9y6a0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Containers','https://www.youtube.com/results?search_query=Containers'),(@lesson,'Bootstrap docs: Containers','https://getbootstrap.com/docs/5.3/layout/containers/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Containers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which container fills the full width at every screen size?','container-fluid has no max width, so it always fills the viewport.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'container-fluid',1,0),(@q,'container',0,1),(@q,'container-md',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A container sets a maximum width and centres its content.','Containers keep line lengths readable on big screens.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Containers','Practise: Use containers to hold content at sensible widths','Create three stacked sections, each using a different container class, with a background colour on each container so you can see the width change as you resize the window. Screenshot both a narrow and a wide window.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Containers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 7: Grid Layout (part 1)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Grid Layout (part 1)', 'Build columns with the 12-column grid.', 'Create rows and columns with row and col.
Set column widths with col-6 and friends.
Apply breakpoint classes so widths change responsively.', '## What this lesson covers

Build columns with the 12-column grid.

- The grid uses rows that hold 12 column units in total.
- col-4 takes four of twelve units; col-md-6 takes half the row from the md breakpoint up.
- Columns without a number share the remaining space equally.

## Key code
```html
<div class="row">
  <div class="col-12 col-md-6 col-lg-3">One</div>
  <div class="col-12 col-md-6 col-lg-3">Two</div>
  <div class="col-12 col-md-6 col-lg-3">Three</div>
  <div class="col-12 col-md-6 col-lg-3">Four</div>
</div>
```

## Practice
Build a four-column row on desktop that becomes two columns on tablets and one column on phones. Use col-12 col-md-6 col-lg-3 and give each column a coloured background.', 'The grid uses rows that hold 12 column units in total.
col-4 takes four of twelve units; col-md-6 takes half the row from the md breakpoint up.
Columns without a number share the remaining space equally.', 'irfbn103AzE', 12, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create rows and columns with row and col.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set column widths with col-6 and friends.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Apply breakpoint classes so widths change responsively.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=irfbn103AzE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Grid Layout (part 1)','https://www.youtube.com/results?search_query=Grid+Layout+(part+1)'),(@lesson,'Bootstrap docs: Grid system','https://getbootstrap.com/docs/5.3/layout/grid/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Grid Layout (part 1)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How many column units does a Bootstrap row contain?','Every Bootstrap row is divided into twelve column units.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'12',1,0),(@q,'16',0,1),(@q,'24',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class makes an element half width from the medium breakpoint up?','The breakpoint comes first, then the number of units.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'col-md-6',1,0),(@q,'col-6-md',0,1),(@q,'md-col-6',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Grid Layout (part 1)','Practise: Build columns with the 12-column grid','Build a four-column row on desktop that becomes two columns on tablets and one column on phones. Use col-12 col-md-6 col-lg-3 and give each column a coloured background.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Grid Layout (part 1): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 8: Grid Layout (part 2)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Grid Layout (part 2)', 'Use row-cols, gutters, alignment and ordering in the grid.', 'Set a number of columns per row with row-cols.
Change spacing between columns with gutter classes.
Align and reorder columns at different breakpoints.', '## What this lesson covers

Use row-cols, gutters, alignment and ordering in the grid.

- row-cols-2 and row-cols-md-3 control how many columns appear per row.
- Gutter classes such as g-2, gx-4 and gy-3 change the space between columns.
- Alignment classes such as align-items-center and justify-content-between control placement inside a row.

## Key code
```html
<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
  <div class="col"><div class="border p-3">Card</div></div>
  <div class="col"><div class="border p-3">Card</div></div>
  <div class="col"><div class="border p-3">Card</div></div>
</div>
```

## Practice
Create a card gallery using row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4, add six simple cards and check that the layout reflows at each breakpoint.', 'row-cols-2 and row-cols-md-3 control how many columns appear per row.
Gutter classes such as g-2, gx-4 and gy-3 change the space between columns.
Alignment classes such as align-items-center and justify-content-between control placement inside a row.', 'yCCIztB-S_k', 8, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set a number of columns per row with row-cols.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Change spacing between columns with gutter classes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Align and reorder columns at different breakpoints.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=yCCIztB-S_k'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Grid Layout (part 2)','https://www.youtube.com/results?search_query=Grid+Layout+(part+2)'),(@lesson,'Bootstrap docs: Grid options','https://getbootstrap.com/docs/5.3/layout/grid/#grid-options');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Grid Layout (part 2)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class sets three columns per row from the medium breakpoint up?','row-cols sets the number of columns per row.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'row-cols-md-3',1,0),(@q,'col-md-3-row',0,1),(@q,'row-md-3',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which utility adds space between all grid columns and rows?','The g-* classes set gutters inside the row.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'g-4',1,0),(@q,'p-4',0,1),(@q,'m-4',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Grid Layout (part 2)','Practise: Use row-cols, gutters, alignment and ordering in the grid','Create a card gallery using row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4, add six simple cards and check that the layout reflows at each breakpoint.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Grid Layout (part 2): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 4: Navbars, Cards and Content =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Navbars, Cards and Content','Build navigation and content blocks with ready-made components.',3);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Navbars, Cards and Content',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Navbars, Cards and Content');

-- Lesson 9: Navbars
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Navbars', 'Build a responsive navigation bar that collapses on small screens.', 'Create a navbar with a brand and links.
Add a collapse toggle for mobile screens.
Pin the navbar and align items left or right.', '## What this lesson covers

Build a responsive navigation bar that collapses on small screens.

- A navbar combines navbar, navbar-expand-lg and a colour scheme such as navbar-dark bg-dark.
- The navbar-toggler button needs data-bs-toggle="collapse" and data-bs-target to open the menu.
- Utilities such as me-auto and ms-auto push links to the left or right.

## Key code
```html
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="#">Learnow</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mainNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
      </ul>
    </div>
  </div>
</nav>
```

## Practice
Build a navbar with a brand, four links, a right-aligned sign-in button and a working mobile toggle. Resize the window to prove the menu collapses and opens.', 'A navbar combines navbar, navbar-expand-lg and a colour scheme such as navbar-dark bg-dark.
The navbar-toggler button needs data-bs-toggle="collapse" and data-bs-target to open the menu.
Utilities such as me-auto and ms-auto push links to the left or right.', '7AT1X9Z41sA', 13, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a navbar with a brand and links.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a collapse toggle for mobile screens.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pin the navbar and align items left or right.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7AT1X9Z41sA'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Navbars','https://www.youtube.com/results?search_query=Navbars'),(@lesson,'Bootstrap docs: Navbar','https://getbootstrap.com/docs/5.3/components/navbar/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Navbars','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute pair makes the navbar toggle open the menu?','Bootstrap 5 uses data-bs-toggle and data-bs-target to wire the toggle to the menu.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'data-bs-toggle="collapse" with data-bs-target',1,0),(@q,'data-toggle="nav"',0,1),(@q,'data-bs-open="menu"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class makes the navbar horizontal only from the large breakpoint up?','navbar-expand-lg collapses below the lg breakpoint.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'navbar-expand-lg',1,0),(@q,'navbar-large',0,1),(@q,'navbar-fluid',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Navbars','Practise: Build a responsive navigation bar that collapses on small screens','Build a navbar with a brand, four links, a right-aligned sign-in button and a working mobile toggle. Resize the window to prove the menu collapses and opens.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Navbars: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 10: Cards
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Cards', 'Present content in cards with headers, images and footers.', 'Build a card with a body, title and text.
Add images, headers and footers.
Use card groups and stretched links.', '## What this lesson covers

Present content in cards with headers, images and footers.

- A card needs the card class, usually with an inner card-body.
- Card parts include card-header, card-img-top, card-title, card-text and card-footer.
- card-group keeps equal heights, and h-100 makes cards in a grid match height.

## Key code
```html
<div class="card h-100">
  <img src="photo.jpg" class="card-img-top" alt="Product">
  <div class="card-body">
    <h5 class="card-title">Wireless mouse</h5>
    <p class="card-text text-muted">Comfortable and quiet.</p>
    <a href="#" class="btn btn-primary w-100">Add to cart</a>
  </div>
</div>
```

## Practice
Build a three-card product grid using row row-cols-1 row-cols-md-3 g-4, each with an image, title, text, price and a full-width button. Make the cards equal height with h-100.', 'A card needs the card class, usually with an inner card-body.
Card parts include card-header, card-img-top, card-title, card-text and card-footer.
card-group keeps equal heights, and h-100 makes cards in a grid match height.', 'NRoET8-8cbw', 12, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build a card with a body, title and text.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add images, headers and footers.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use card groups and stretched links.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=NRoET8-8cbw'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Cards','https://www.youtube.com/results?search_query=Cards'),(@lesson,'Bootstrap docs: Cards','https://getbootstrap.com/docs/5.3/components/card/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Cards','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class holds the padding and content inside a card?','card-body adds the internal spacing for card content.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'card-body',1,0),(@q,'card-content',0,1),(@q,'card-pad',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class makes cards in a row share the same height?','h-100 stretches each card to the full height of its column.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'h-100',1,0),(@q,'h-auto',0,1),(@q,'w-100',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Cards','Practise: Present content in cards with headers, images and footers','Build a three-card product grid using row row-cols-1 row-cols-md-3 g-4, each with an image, title, text, price and a full-width button. Make the cards equal height with h-100.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Cards: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 11: Accordions
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Accordions', 'Show and hide sections of content with an accordion.', 'Build an accordion from accordion items.
Connect buttons to panels with data attributes.
Open one panel at a time with a parent container.', '## What this lesson covers

Show and hide sections of content with an accordion.

- Accordion markup uses accordion, accordion-item, accordion-header and accordion-collapse.
- The button uses data-bs-toggle="collapse" and data-bs-target pointing at the panel id.
- Setting data-bs-parent keeps only one panel open at a time.

## Key code
```html
<div class="accordion" id="faq">
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#a1" data-bs-parent="#faq">Question one</button>
    </h2>
    <div id="a1" class="accordion-collapse collapse show" data-bs-parent="#faq">
      <div class="accordion-body">Answer one.</div>
    </div>
  </div>
</div>
```

## Practice
Build a FAQ accordion with four questions. Keep only one answer open at a time and style the first panel as open using show and the collapsed class on the button.', 'Accordion markup uses accordion, accordion-item, accordion-header and accordion-collapse.
The button uses data-bs-toggle="collapse" and data-bs-target pointing at the panel id.
Setting data-bs-parent keeps only one panel open at a time.', 'cVThXv6hYW0', 12, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build an accordion from accordion items.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Connect buttons to panels with data attributes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Open one panel at a time with a parent container.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=cVThXv6hYW0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Accordions','https://www.youtube.com/results?search_query=Accordions'),(@lesson,'Bootstrap docs: Accordion','https://getbootstrap.com/docs/5.3/components/accordion/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Accordions','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute keeps only one accordion panel open at a time?','The parent attribute closes the others when a panel opens.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'data-bs-parent',1,0),(@q,'data-bs-single',0,1),(@q,'data-bs-close',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Accordion panels need the Bootstrap JavaScript bundle to open and close.','Collapse behaviour is powered by the JavaScript bundle.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Accordions','Practise: Show and hide sections of content with an accordion','Build a FAQ accordion with four questions. Keep only one answer open at a time and style the first panel as open using show and the collapsed class on the button.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Accordions: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 12: List Groups
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'List Groups', 'Display lists of items with list groups.', 'Create a list group with items.
Add active, disabled and flush styles.
Build a horizontal or linked list group.', '## What this lesson covers

Display lists of items with list groups.

- list-group holds list-group-item children.
- The flush variant removes the outer border and rounded corners.
- list-group-item-action adds hover styles for clickable items.

## Key code
```html
<ul class="list-group">
  <li class="list-group-item active">Account</li>
  <li class="list-group-item">Notifications</li>
  <li class="list-group-item disabled">Billing</li>
</ul>
```

## Practice
Create a settings menu of six items, one active and one disabled, and a second version with list-group-flush inside a card. Screenshot both.', 'list-group holds list-group-item children.
The flush variant removes the outer border and rounded corners.
list-group-item-action adds hover styles for clickable items.', 'gwgeMole3gs', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a list group with items.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add active, disabled and flush styles.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build a horizontal or linked list group.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=gwgeMole3gs'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: List Groups','https://www.youtube.com/results?search_query=List+Groups'),(@lesson,'Bootstrap docs: List group','https://getbootstrap.com/docs/5.3/components/list-group/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: List Groups','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class removes the outer border from a list group?','flush removes outer borders and rounding.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'list-group-flush',1,0),(@q,'list-group-clear',0,1),(@q,'border-0-group',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class adds hover feedback to clickable list items?','list-group-item-action adds the hover and focus states.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'list-group-item-action',1,0),(@q,'list-group-link',0,1),(@q,'item-hover',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: List Groups','Practise: Display lists of items with list groups','Create a settings menu of six items, one active and one disabled, and a second version with list-group-flush inside a card. Screenshot both.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','List Groups: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 13: Bootstrap Icons
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Bootstrap Icons', 'Add Bootstrap Icons to buttons, links and lists.', 'Link the Bootstrap Icons stylesheet.
Place an icon in a button or list item.
Size and colour icons with utilities.', '## What this lesson covers

Add Bootstrap Icons to buttons, links and lists.

- Bootstrap Icons is a separate CSS file from the main Bootstrap stylesheet.
- Icons use the bi class plus a name such as bi-alarm.
- Icons inherit text colour and can be sized with fs-* or custom CSS.

## Key code
```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<button class="btn btn-outline-primary"><i class="bi bi-search" aria-hidden="true"></i> Search</button>
```

## Practice
Add icons to your navbar links, a search button and a list of features. Use at least five different icons and add aria-hidden="true" to decorative ones.', 'Bootstrap Icons is a separate CSS file from the main Bootstrap stylesheet.
Icons use the bi class plus a name such as bi-alarm.
Icons inherit text colour and can be sized with fs-* or custom CSS.', 'rhvMRsE_6sY', 5, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Link the Bootstrap Icons stylesheet.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Place an icon in a button or list item.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Size and colour icons with utilities.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=rhvMRsE_6sY'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Bootstrap Icons','https://www.youtube.com/results?search_query=Bootstrap+Icons'),(@lesson,'Bootstrap Icons','https://icons.getbootstrap.com/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Bootstrap Icons','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class pattern shows the alarm icon?','Use the bi base class with bi- plus the icon name.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'bi bi-alarm',1,0),(@q,'icon-alarm',0,1),(@q,'bi-alarm-icon',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Bootstrap Icons is included in bootstrap.min.css.','Icons need their own icon stylesheet to be loaded.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Bootstrap Icons','Practise: Add Bootstrap Icons to buttons, links and lists','Add icons to your navbar links, a search button and a list of features. Use at least five different icons and add aria-hidden="true" to decorative ones.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Bootstrap Icons: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 5: Forms and Interactive Components =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Forms and Interactive Components','Build forms and add tooltips, modals, offcanvas and dropdowns.',4);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Forms and Interactive Components',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Forms and Interactive Components');

-- Lesson 14: Working with Forms
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Working with Forms', 'Build complete Bootstrap forms with labels, checks, input groups and validation.', 'Create text inputs and selects with labels.
Use checkboxes, switches and input groups.
Show validation feedback with is-invalid.', '## What this lesson covers

Build complete Bootstrap forms with labels, checks, input groups and validation.

- form-control styles text inputs, form-select styles dropdowns and form-label styles labels.
- form-check wraps checkboxes and switches, with form-check-input on the input.
- Adding is-invalid to a field shows the invalid-feedback message.

## Key code
```html
<form class="p-4 border rounded">
  <div class="mb-3">
    <label class="form-label" for="email">Email</label>
    <input type="email" class="form-control is-invalid" id="email">
    <div class="invalid-feedback">Enter a valid email address.</div>
  </div>
  <div class="form-check mb-3">
    <input class="form-check-input" type="checkbox" id="terms">
    <label class="form-check-label" for="terms">Accept the terms</label>
  </div>
  <button class="btn btn-primary">Send</button>
</form>
```

## Practice
Build a contact form with name, email, subject select, message textarea, a terms checkbox and a submit button. Add validation styles to one field to show an error message.', 'form-control styles text inputs, form-select styles dropdowns and form-label styles labels.
form-check wraps checkboxes and switches, with form-check-input on the input.
Adding is-invalid to a field shows the invalid-feedback message.', 'dKVX22GR7zQ', 14, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create text inputs and selects with labels.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use checkboxes, switches and input groups.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Show validation feedback with is-invalid.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=dKVX22GR7zQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Working with Forms','https://www.youtube.com/results?search_query=Working+with+Forms'),(@lesson,'Bootstrap docs: Forms','https://getbootstrap.com/docs/5.3/forms/overview/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Working with Forms','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class styles a text input field?','form-control gives inputs the Bootstrap look and focus ring.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'form-control',1,0),(@q,'input-field',0,1),(@q,'form-text',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class shows a red error state on a field?','is-invalid pairs with invalid-feedback to display the message.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'is-invalid',1,0),(@q,'is-error',0,1),(@q,'text-danger-input',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Working with Forms','Practise: Build complete Bootstrap forms with labels, checks, input groups and validation','Build a contact form with name, email, subject select, message textarea, a terms checkbox and a submit button. Add validation styles to one field to show an error message.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Working with Forms: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 15: Tooltips
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Tooltips', 'Add small helpful tooltips to buttons and links.', 'Add tooltip attributes to an element.
Initialise tooltips with JavaScript.
Change placement and trigger options.', '## What this lesson covers

Add small helpful tooltips to buttons and links.

- Tooltips need data-bs-toggle="tooltip" and a title attribute.
- Each tooltip must be initialised, for example with a loop over all elements that have the tooltip data attribute.
- Options such as placement and trigger control where and when the tooltip appears.

## Key code
```html
<button class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="top" title="Saves your work">Save</button>
<script>
  document.querySelectorAll(''[data-bs-toggle="tooltip"]'')
    .forEach(el => new bootstrap.Tooltip(el));
</script>
```

## Practice
Add tooltips to three buttons with top, right and bottom placement. Initialise them in a script tag and test that they appear and disappear.', 'Tooltips need data-bs-toggle="tooltip" and a title attribute.
Each tooltip must be initialised, for example with a loop over all elements that have the tooltip data attribute.
Options such as placement and trigger control where and when the tooltip appears.', 'WTrW-1JsDYE', 6, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add tooltip attributes to an element.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Initialise tooltips with JavaScript.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Change placement and trigger options.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=WTrW-1JsDYE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Tooltips','https://www.youtube.com/results?search_query=Tooltips'),(@lesson,'Bootstrap docs: Tooltips','https://getbootstrap.com/docs/5.3/components/tooltips/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Tooltips','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which data attribute turns an element into a tooltip trigger?','The tooltip data attribute marks the element; the title supplies the text.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'data-bs-toggle="tooltip"',1,0),(@q,'data-bs-toggle="modal"',0,1),(@q,'title="tooltip"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Tooltips work without any JavaScript initialisation.','Tooltips must be initialised before they respond.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Tooltips','Practise: Add small helpful tooltips to buttons and links','Add tooltips to three buttons with top, right and bottom placement. Initialise them in a script tag and test that they appear and disappear.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Tooltips: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 16: Modals
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Modals', 'Show focused dialogs with modals.', 'Create a modal with header, body and footer.
Open a modal with a button and data attributes.
Change modal size and centre it on screen.', '## What this lesson covers

Show focused dialogs with modals.

- Modal markup uses modal, modal-dialog and modal-content.
- A trigger uses data-bs-toggle="modal" with data-bs-target pointing at the modal id.
- Sizes such as modal-lg and helpers such as modal-dialog-centered change the dialog.

## Key code
```html
<button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDelete">Delete</button>
<div class="modal fade" id="confirmDelete" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">Please confirm</h5></div>
      <div class="modal-body">This cannot be undone. Continue?</div>
      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button class="btn btn-danger">Delete</button>
      </div>
    </div>
  </div>
</div>
```

## Practice
Build a confirmation modal that asks before deleting a record. It should have a warning header, a question in the body and Cancel and Delete buttons in the footer.', 'Modal markup uses modal, modal-dialog and modal-content.
A trigger uses data-bs-toggle="modal" with data-bs-target pointing at the modal id.
Sizes such as modal-lg and helpers such as modal-dialog-centered change the dialog.', 'tt5uUMQgzl0', 8, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a modal with header, body and footer.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Open a modal with a button and data attributes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Change modal size and centre it on screen.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=tt5uUMQgzl0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Modals','https://www.youtube.com/results?search_query=Modals'),(@lesson,'Bootstrap docs: Modal','https://getbootstrap.com/docs/5.3/components/modal/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Modals','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class wraps the visible dialog box inside a modal?','modal-content is the styled box that holds header, body and footer.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'modal-content',1,0),(@q,'modal-box',0,1),(@q,'modal-body',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class centres the modal vertically on the page?','modal-dialog-centered is added to the dialog element.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'modal-dialog-centered',1,0),(@q,'modal-middle',0,1),(@q,'align-modal-center',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Modals','Practise: Show focused dialogs with modals','Build a confirmation modal that asks before deleting a record. It should have a warning header, a question in the body and Cancel and Delete buttons in the footer.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Modals: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 17: Offcanvas
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Offcanvas', 'Slide panels in from the edge of the screen.', 'Create an offcanvas panel with a trigger.
Choose which side the panel slides from.
Use offcanvas responsively for mobile menus.', '## What this lesson covers

Slide panels in from the edge of the screen.

- Offcanvas uses offcanvas, offcanvas-header and offcanvas-body.
- Placement classes are offcanvas-start, offcanvas-end, offcanvas-top and offcanvas-bottom.
- Responsive variants such as offcanvas-lg only behave as a panel below that breakpoint.

## Key code
```html
<button class="btn btn-primary" data-bs-toggle="offcanvas" data-bs-target="#settings">Settings</button>
<div class="offcanvas offcanvas-end" id="settings" tabindex="-1">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title">Settings</h5>
    <button class="btn-close" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">Panel content.</div>
</div>
```

## Practice
Build a slide-out settings panel from the right with a close button and three setting rows. Add a second panel from the left for navigation and screenshot both.', 'Offcanvas uses offcanvas, offcanvas-header and offcanvas-body.
Placement classes are offcanvas-start, offcanvas-end, offcanvas-top and offcanvas-bottom.
Responsive variants such as offcanvas-lg only behave as a panel below that breakpoint.', 'aUVTxD5MasM', 6, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create an offcanvas panel with a trigger.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose which side the panel slides from.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use offcanvas responsively for mobile menus.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=aUVTxD5MasM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Offcanvas','https://www.youtube.com/results?search_query=Offcanvas'),(@lesson,'Bootstrap docs: Offcanvas','https://getbootstrap.com/docs/5.3/components/offcanvas/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Offcanvas','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class makes a panel slide in from the right edge?','Bootstrap 5 uses logical names: start and end.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'offcanvas-end',1,0),(@q,'offcanvas-right',0,1),(@q,'offcanvas-side',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Offcanvas panels can be used as a mobile-only menu with offcanvas-md.','The responsive variants switch between panel and normal layout.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Offcanvas','Practise: Slide panels in from the edge of the screen','Build a slide-out settings panel from the right with a close button and three setting rows. Add a second panel from the left for navigation and screenshot both.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Offcanvas: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 18: Dropdowns
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Dropdowns', 'Add dropdown menus to buttons and navigation.', 'Create a dropdown menu from a button.
Add dividers, headers and split buttons.
Choose the drop direction.', '## What this lesson covers

Add dropdown menus to buttons and navigation.

- A dropdown needs the dropdown wrapper, a toggle with data-bs-toggle="dropdown" and a dropdown-menu.
- dropdown-item styles each entry, with dropdown-divider and dropdown-header for structure.
- Classes such as dropup, dropend and dropstart change the direction.

## Key code
```html
<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown">Actions</button>
  <ul class="dropdown-menu">
    <li><h6 class="dropdown-header">Manage</h6></li>
    <li><a class="dropdown-item" href="#">Edit</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item text-danger" href="#">Delete</a></li>
  </ul>
</div>
```

## Practice
Add a dropdown to a card header with actions Edit, Duplicate and a red Delete item below a divider. Include one dropdown-header label.', 'A dropdown needs the dropdown wrapper, a toggle with data-bs-toggle="dropdown" and a dropdown-menu.
dropdown-item styles each entry, with dropdown-divider and dropdown-header for structure.
Classes such as dropup, dropend and dropstart change the direction.', 'lu4HFx3bzy8', 4, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a dropdown menu from a button.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add dividers, headers and split buttons.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose the drop direction.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=lu4HFx3bzy8'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Dropdowns','https://www.youtube.com/results?search_query=Dropdowns'),(@lesson,'Bootstrap docs: Dropdowns','https://getbootstrap.com/docs/5.3/components/dropdowns/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Dropdowns','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class marks a single entry inside a dropdown menu?','dropdown-item provides the padding and hover styling for each entry.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'dropdown-item',1,0),(@q,'menu-item',0,1),(@q,'nav-link',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which wrapper class is required around a dropdown button and menu?','The dropdown wrapper positions the menu under the toggle.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'dropdown',1,0),(@q,'drop-wrap',0,1),(@q,'btn-group-only',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Dropdowns','Practise: Add dropdown menus to buttons and navigation','Add a dropdown to a card header with actions Edit, Duplicate and a red Delete item below a divider. Include one dropdown-header label.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Dropdowns: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 6: Customising Bootstrap and Tabs =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Customising Bootstrap and Tabs','Theme Bootstrap like your own product and switch content with tabs.',5);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Customising Bootstrap and Tabs',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Customising Bootstrap and Tabs');

-- Lesson 19: Customizing Bootstrap
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Customizing Bootstrap', 'Override Bootstrap defaults with CSS variables, your own stylesheet and Sass.', 'Override theme colours with CSS variables.
Add a custom stylesheet after Bootstrap.
Explain how Sass variables rebuild Bootstrap.', '## What this lesson covers

Override Bootstrap defaults with CSS variables, your own stylesheet and Sass.

- Bootstrap 5 exposes CSS variables such as --bs-primary for runtime theming.
- Placing your CSS after the Bootstrap file lets your rules override defaults.
- A Sass build lets you change variables such as $primary and recompile, so the change reaches every component.

## Key code
```css
:root {
  --bs-primary: #0b5d3b;
  --bs-primary-rgb: 11, 93, 59;
}
.btn-primary {
  --bs-btn-bg: #0b5d3b;
  --bs-btn-border-color: #0b5d3b;
}
```

## Tip
Never edit the Bootstrap files you download, or your changes disappear on the next update.

## Practice
Create a theme.css file that changes the primary colour, adds a custom font and rounds all buttons more. Link it after Bootstrap and show the result in a screenshot.', 'Bootstrap 5 exposes CSS variables such as --bs-primary for runtime theming.
Placing your CSS after the Bootstrap file lets your rules override defaults.
A Sass build lets you change variables such as $primary and recompile, so the change reaches every component.', 'nCX3QVl_PiI', 16, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Override theme colours with CSS variables.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a custom stylesheet after Bootstrap.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain how Sass variables rebuild Bootstrap.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=nCX3QVl_PiI'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Customizing Bootstrap','https://www.youtube.com/results?search_query=Customizing+Bootstrap'),(@lesson,'Bootstrap docs: CSS variables','https://getbootstrap.com/docs/5.3/customize/css-variables/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Customizing Bootstrap','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which CSS variable sets the theme primary colour?','Bootstrap 5 defines --bs-primary and similar variables on the root element.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'--bs-primary',1,0),(@q,'--primary',0,1),(@q,'--theme-color',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Sass changes require recompiling Bootstrap.','Sass variables are processed at build time, not in the browser.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Customizing Bootstrap','Practise: Override Bootstrap defaults with CSS variables, your own stylesheet and Sass','Create a theme.css file that changes the primary colour, adds a custom font and rounds all buttons more. Link it after Bootstrap and show the result in a screenshot.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Customizing Bootstrap: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 20: Tabs
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Tabs', 'Switch between panels of content with tabs and pills.', 'Create a tab strip with nav and nav-tabs.
Connect each tab to its panel.
Use pills and vertical tabs.', '## What this lesson covers

Switch between panels of content with tabs and pills.

- Tabs use nav and nav-tabs with nav-link buttons inside nav-item.
- Each button needs data-bs-toggle="tab" and data-bs-target pointing at a tab-pane id.
- The active class on the link and active show on the pane decide what is visible.

## Key code
```html
<ul class="nav nav-tabs">
  <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#desc">Description</button></li>
  <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#reviews">Reviews</button></li>
</ul>
<div class="tab-content pt-3">
  <div class="tab-pane active show" id="desc">Description text.</div>
  <div class="tab-pane" id="reviews">Reviews text.</div>
</div>
```

## Practice
Build a product page with three tabs: Description, Reviews and Shipping. Show a short paragraph in each pane and make the first tab active by default.', 'Tabs use nav and nav-tabs with nav-link buttons inside nav-item.
Each button needs data-bs-toggle="tab" and data-bs-target pointing at a tab-pane id.
The active class on the link and active show on the pane decide what is visible.', 'IMM93WydBSw', 7, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a tab strip with nav and nav-tabs.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Connect each tab to its panel.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use pills and vertical tabs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=IMM93WydBSw'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Tabs','https://www.youtube.com/results?search_query=Tabs'),(@lesson,'Bootstrap docs: Navs and tabs','https://getbootstrap.com/docs/5.3/components/navs-tabs/');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Tabs','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which data attribute turns a nav link into a tab control?','The tab toggle links the nav item to its pane.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'data-bs-toggle="tab"',1,0),(@q,'data-bs-toggle="pill" only',0,1),(@q,'data-bs-toggle="nav"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pair of classes makes the first tab pane visible?','The pane needs active and show to be displayed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'active show',1,0),(@q,'active hide',0,1),(@q,'show only',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Tabs','Practise: Switch between panels of content with tabs and pills','Build a product page with three tabs: Description, Reviews and Shipping. Show a short paragraph in each pane and make the first tab active by default.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Tabs: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 7: Final Project =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Final Project','Bring everything together in two real projects and a review quiz.',6);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Final Project',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Final Project');

-- Lesson 21: Final Project Briefing
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Final Project Briefing', 'Plan the final projects and check that you are ready to build them.', 'Read both project briefs.
Sketch the pages and components you need.
List the Bootstrap components you will reuse.', '## What this lesson covers

Plan the final projects and check that you are ready to build them.

- A responsive page combines the grid, utilities, cards and a navbar.
- Reusing Bootstrap components keeps your own CSS small.
- Plan the layout at mobile, tablet and desktop widths before you code.

## Practice
Read both briefs, sketch the mobile and desktop layouts on paper and list every Bootstrap component you will use. Submit the sketch as a photo or PDF with your component list.', 'A responsive page combines the grid, utilities, cards and a navbar.
Reusing Bootstrap components keeps your own CSS small.
Plan the layout at mobile, tablet and desktop widths before you code.', NULL, 12, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read both project briefs.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Sketch the pages and components you need.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List the Bootstrap components you will reuse.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9joIM91nLzd_qaH_AimmdAR'),(@lesson,'Search YouTube: Final Project Briefing','https://www.youtube.com/results?search_query=Final+Project+Briefing');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Final review quiz','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which Bootstrap feature makes a layout adapt to screen size?','Breakpoint classes such as col-md-6 and d-lg-block drive responsive layout.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The responsive grid and breakpoint classes',1,0),(@q,'The container only',0,1),(@q,'Custom fonts',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Reusing Bootstrap components means writing less custom CSS.','Components already ship with styling and behaviour.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which belong in a clean Bootstrap project?','Override with your own stylesheet and keep the markup meaningful.',2,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A custom stylesheet loaded after Bootstrap',1,0),(@q,'Editing bootstrap.min.css by hand',0,1),(@q,'Semantic HTML around Bootstrap classes',1,2),(@q,'Hard-coded pixel widths for every section',0,3);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 1: Responsive business landing page','Build and publish a complete responsive landing page with Bootstrap 5.','Build a landing page for a small business of your choice with Bootstrap 5.
Requirements: a responsive navbar with a working mobile toggle, a hero section using the grid and utilities, a features row of cards (three on desktop, one on mobile), a pricing section using cards and a highlighted plan, an FAQ accordion, a contact form with labels and validation styling, a footer with icons, and at least one modal or offcanvas panel.
Use your own stylesheet after Bootstrap for colours and spacing, and keep every image with alt text.

Submit a live URL (GitHub Pages, Netlify or your host) or a repository link, plus a short note on one responsive problem you fixed.','Build a complete responsive page with Bootstrap components',100,60,1,1,1,1,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Layout is responsive at phone, tablet and desktop widths',30),(@assign,'Required components present and working',30),(@assign,'Clean markup, alt text and sensible class usage',20),(@assign,'Design, colour and spacing are consistent',10),(@assign,'Live link and reflection note',10);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 2: Admin dashboard (optional challenge)','Build a dashboard layout with a sidebar, stat cards and a data table.','Build a dashboard page with Bootstrap 5.
Include a fixed sidebar or offcanvas navigation on mobile, a top navbar with a dropdown user menu, four stat cards in a responsive row, a table of recent orders with badges for status, a tabbed panel for overview and activity, and two buttons that open modals.

Submit a live URL or repository link and a short note describing your layout approach.','Combine grid, cards, tables, tabs and modals in one layout',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Layout and sidebar work on all screen sizes',30),(@assign,'All requested components present',30),(@assign,'Consistent spacing and styling',20),(@assign,'Clean markup and alt text',10),(@assign,'Live link and note',10);
SET @prev_stage=@stage;

COMMIT;
SELECT 'Bootstrap 5 Crash Course installed' AS result,(SELECT COUNT(*) FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=@path) AS lessons,(SELECT COUNT(*) FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE s.path_id=@path) AS quizzes,(SELECT COUNT(*) FROM assignments a JOIN stages s ON s.id=a.stage_id WHERE s.path_id=@path) AS assignments;
