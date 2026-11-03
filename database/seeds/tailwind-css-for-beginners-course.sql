-- Tailwind CSS for Beginners: 19 video lessons, 19 quizzes, 18 practice assignments and 2 final projects.
-- Built from the Net Ninja "Tailwind CSS Tutorial" videos you provided.
-- Run in phpMyAdmin with YOUR database selected. Run it once.
-- To reinstall later, first run:  DELETE FROM learning_paths WHERE slug='tailwind-css-for-beginners';  (this also deletes enrolments and progress for the course)
START TRANSACTION;
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Web Development','web-development','Build useful things for the web.','code','orange',1);
SET @cat=(SELECT id FROM categories WHERE slug='web-development');
INSERT INTO learning_paths(category_id,title,slug,description,objectives,difficulty,status,certificate_enabled,certificate_min_score) VALUES(@cat,'Tailwind CSS for Beginners', 'tailwind-css-for-beginners', 'Build interfaces with utility classes instead of custom CSS. Follow 19 short video lessons on setup, fonts, colour, spacing, borders, the Tailwind config, flexbox, responsive classes, cards, badges, the @apply directive, grids, buttons, icons, hover effects, a responsive navbar and transitions. Pass a quiz after every lesson, practise with an assignment and finish with a real page.', 'Set up Tailwind CSS and understand the utility-first approach
Control colour, typography, spacing and borders with utilities
Extend the theme with tailwind.config and custom fonts
Lay out pages with flexbox, grids and responsive prefixes
Build cards, badges, buttons, icons and a responsive navigation bar
Add hover states and transitions, and reuse styles with @apply', 'beginner', 'published', 1, 60);
SET @path=LAST_INSERT_ID();
SET @prev_stage=NULL;

-- ===== STAGE 1: Getting Started =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Getting Started','Meet Tailwind, create your project and start with the HTML template.',0);
SET @stage=LAST_INSERT_ID();
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Getting Started',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Getting Started');

-- Lesson 1: Intro & Setup
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Intro & Setup', 'Understand the utility-first idea and set up a page that loads Tailwind CSS.', 'Create a project folder with an index.html file.
Load Tailwind from the Play CDN for quick experiments.
Style one heading with utility classes.', '## What this lesson covers

Understand the utility-first idea and set up a page that loads Tailwind CSS.

- Tailwind provides small single-purpose classes such as text-center and p-4.
- Styles live in the markup, so you rarely write new CSS files.
- The Play CDN is fine for learning; production projects compile Tailwind with the CLI or a bundler.

## Key code
```html
<script src="https://cdn.tailwindcss.com"></script>
<h1 class="text-4xl font-bold text-blue-600">Hello Tailwind</h1>
<p class="mt-4 text-gray-600">Utility classes style this text.</p>
```

## Tip
Read a class name as a sentence: text-blue-600 means "text colour blue, shade 600".

## Practice
Create a folder named tailwind-practice with an index.html file that loads Tailwind, and style a heading with text-4xl font-bold text-blue-600 and a paragraph with mt-4 text-gray-600. Submit a screenshot.', 'Tailwind provides small single-purpose classes such as text-center and p-4.
Styles live in the markup, so you rarely write new CSS files.
The Play CDN is fine for learning; production projects compile Tailwind with the CLI or a bundler.', 'bxmDnn7lrnk', 14, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a project folder with an index.html file.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Load Tailwind from the Play CDN for quick experiments.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Style one heading with utility classes.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=bxmDnn7lrnk'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Intro & Setup','https://www.youtube.com/results?search_query=Intro+&+Setup'),(@lesson,'Tailwind docs: Installation','https://tailwindcss.com/docs/installation');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Intro & Setup','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is the main idea behind Tailwind CSS?','Tailwind supplies utilities; you compose the design in your HTML.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Small utility classes applied directly in the markup',1,0),(@q,'A set of prebuilt components such as cards',0,1),(@q,'A JavaScript framework',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The Play CDN is intended for production use.','The Play CDN is for development and experiments; production sites compile Tailwind.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Intro & Setup','Practise: Understand the utility-first idea and set up a page that loads Tailwind CSS','Create a folder named tailwind-practice with an index.html file that loads Tailwind, and style a heading with text-4xl font-bold text-blue-600 and a paragraph with mt-4 text-gray-600. Submit a screenshot.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Intro & Setup: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 2: HTML Template
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Template', 'Create a reusable HTML template and a first layout block.', 'Write the base HTML template with the Tailwind script.
Add a header, a main area and a footer.
Use spacing utilities to build a simple page shell.', '## What this lesson covers

Create a reusable HTML template and a first layout block.

- A template saves time: write the boilerplate once and reuse it for every page.
- The main content area is usually wrapped in a max-w container with mx-auto and px-4.
- The Play CDN script must load before the elements that use its classes.

## Key code
```html
<body class="bg-gray-50 text-gray-800">
  <header class="max-w-5xl mx-auto px-4 py-6">Header</header>
  <main class="max-w-5xl mx-auto px-4">Page content</main>
  <footer class="max-w-5xl mx-auto px-4 mt-16 py-6 border-t text-center text-sm text-gray-500">Footer</footer>
</body>
```

## Practice
Create template.html with a header, main and footer. Put the main content in a max-w-5xl mx-auto px-4 wrapper and add a footer with border-t mt-16 py-6 text-center.', 'A template saves time: write the boilerplate once and reuse it for every page.
The main content area is usually wrapped in a max-w container with mx-auto and px-4.
The Play CDN script must load before the elements that use its classes.', '3ZMUgga6SsY', 10, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write the base HTML template with the Tailwind script.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a header, a main area and a footer.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use spacing utilities to build a simple page shell.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=3ZMUgga6SsY'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: HTML Template','https://www.youtube.com/results?search_query=HTML+Template'),(@lesson,'Tailwind docs: Container','https://tailwindcss.com/docs/container');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Template','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pair of classes centres a block and caps its width?','max-w-* caps the width and mx-auto centres the block.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'max-w-5xl mx-auto',1,0),(@q,'w-full center',0,1),(@q,'mx-5 max-h-5xl',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A shared HTML template saves time across pages.','You write the boilerplate once and reuse it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: HTML Template','Practise: Create a reusable HTML template and a first layout block','Create template.html with a header, main and footer. Put the main content in a max-w-5xl mx-auto px-4 wrapper and add a footer with border-t mt-16 py-6 text-center.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','HTML Template: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 2: Design Basics =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Design Basics','Colour, typography, spacing, borders and your own theme.',1);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Design Basics',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Design Basics');

-- Lesson 3: Fonts & Colors
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fonts & Colors', 'Style text and backgrounds with Tailwind colour and font utilities.', 'Set font size, weight and family.
Use the colour palette for text and backgrounds.
Combine shades to build contrast.', '## What this lesson covers

Style text and backgrounds with Tailwind colour and font utilities.

- Font sizes run from text-xs to text-9xl; font weights use font-light to font-black.
- Colours use a name and a shade, such as text-purple-700 or bg-gray-100.
- Shades from 50 to 950 let you build accessible contrast without inventing colours.

## Key code
```html
<h2 class="text-2xl font-semibold text-gray-900">Amara Okafor</h2>
<p class="text-sm text-gray-500">Frontend developer</p>
<button class="bg-indigo-600 text-white px-4 py-2 rounded-lg">Follow</button>
```

## Practice
Build a small profile card with a text-2xl font-semibold name, a text-sm text-gray-500 role, and a button with bg-indigo-600 text-white. Screenshot the result.', 'Font sizes run from text-xs to text-9xl; font weights use font-light to font-black.
Colours use a name and a shade, such as text-purple-700 or bg-gray-100.
Shades from 50 to 950 let you build accessible contrast without inventing colours.', 'w0KZhi3DD-0', 9, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set font size, weight and family.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the colour palette for text and backgrounds.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Combine shades to build contrast.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=w0KZhi3DD-0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Fonts & Colors','https://www.youtube.com/results?search_query=Fonts+&+Colors'),(@lesson,'Tailwind docs: Text colour','https://tailwindcss.com/docs/text-color');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fonts & Colors','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class makes text extra large and bold?','text-* sets size and font-* sets weight.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'text-2xl font-bold',1,0),(@q,'big-text bold',0,1),(@q,'font-2xl',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class sets a dark purple text colour?','The pattern is utility, colour name, then shade.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'text-purple-700',1,0),(@q,'text-purple',0,1),(@q,'purple-text-700',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fonts & Colors','Practise: Style text and backgrounds with Tailwind colour and font utilities','Build a small profile card with a text-2xl font-semibold name, a text-sm text-gray-500 role, and a button with bg-indigo-600 text-white. Screenshot the result.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fonts & Colors: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 4: Margin, Padding & Borders
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Margin, Padding & Borders', 'Control spacing and borders with utilities.', 'Apply margin and padding on individual sides.
Add borders, rounded corners and shadows.
Use space-y to separate stacked children.', '## What this lesson covers

Control spacing and borders with utilities.

- Spacing uses m for margin and p for padding with sides t, r, b, l, x and y.
- border, rounded-* and shadow-* give an element an edge and depth.
- space-y-4 adds vertical gaps between the children of one element.

## Key code
```html
<div class="p-6 rounded-xl border border-gray-200 shadow-md space-y-3">
  <h3 class="font-semibold">Card title</h3>
  <p class="text-sm text-gray-600">Card text.</p>
</div>
```

## Practice
Create a card with p-6, rounded-xl, border, shadow-md and space-y-3 between its inner elements. Add a hover shadow change and screenshot it.', 'Spacing uses m for margin and p for padding with sides t, r, b, l, x and y.
border, rounded-* and shadow-* give an element an edge and depth.
space-y-4 adds vertical gaps between the children of one element.', '1g4W2U-l350', 7, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Apply margin and padding on individual sides.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add borders, rounded corners and shadows.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use space-y to separate stacked children.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=1g4W2U-l350'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Margin, Padding & Borders','https://www.youtube.com/results?search_query=Margin,+Padding+&+Borders'),(@lesson,'Tailwind docs: Padding','https://tailwindcss.com/docs/padding');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Margin, Padding & Borders','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class adds padding on the left and right only?','The x axis covers left and right.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'px-4',1,0),(@q,'p-4',0,1),(@q,'py-4',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','rounded-lg softens the corners of an element.','rounded utilities control the corner radius.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Margin, Padding & Borders','Practise: Control spacing and borders with utilities','Create a card with p-6, rounded-xl, border, shadow-md and space-y-3 between its inner elements. Add a hover shadow change and screenshot it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Margin, Padding & Borders: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 5: Tailwind Config
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Tailwind Config', 'Extend the default theme with your own colours, fonts and spacing.', 'Add a tailwind.config object to the page.
Extend colours and font sizes.
Use the new values in your markup.', '## What this lesson covers

Extend the default theme with your own colours, fonts and spacing.

- The config object lets you extend the theme without editing Tailwind itself.
- theme.extend adds values; theme replaces the defaults.
- After adding a custom colour such as brand you can use bg-brand and text-brand.

## Key code
```html
<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: { brand: ''#0f766e'' },
        fontFamily: { display: [''Poppins'', ''sans-serif''] }
      }
    }
  }
</script>
<h1 class="font-display text-brand">Custom theme</h1>
```

## Practice
Add a tailwind.config object with a brand colour, a custom font family and an extra spacing value. Use bg-brand, font-display and p-18 somewhere on the page and screenshot it.', 'The config object lets you extend the theme without editing Tailwind itself.
theme.extend adds values; theme replaces the defaults.
After adding a custom colour such as brand you can use bg-brand and text-brand.', '6UVQlB1eo5A', 11, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a tailwind.config object to the page.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Extend colours and font sizes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the new values in your markup.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=6UVQlB1eo5A'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Tailwind Config','https://www.youtube.com/results?search_query=Tailwind+Config'),(@lesson,'Tailwind docs: Configuration','https://tailwindcss.com/docs/configuration');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Tailwind Config','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which key adds new values while keeping the Tailwind defaults?','extend merges your values with the defaults.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'theme.extend',1,0),(@q,'theme.replace',0,1),(@q,'theme.only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','After adding brand to the config colours, which class sets a brand background?','Custom colours follow the same utility naming pattern.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'bg-brand',1,0),(@q,'background-brand',0,1),(@q,'brand-bg',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Tailwind Config','Practise: Extend the default theme with your own colours, fonts and spacing','Add a tailwind.config object with a brand colour, a custom font family and an extra spacing value. Use bg-brand, font-display and p-18 somewhere on the page and screenshot it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Tailwind Config: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 6: Custom Fonts
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Custom Fonts', 'Load and use web fonts such as Poppins in a Tailwind project.', 'Import a Google Font in the page.
Register the font family in the config.
Apply the font with a utility class.', '## What this lesson covers

Load and use web fonts such as Poppins in a Tailwind project.

- A font must be loaded before the browser can display it.
- Registering the family in fontFamily gives you a utility such as font-poppins.
- Always keep a fallback family such as sans-serif in the list.

## Key code
```html
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<script>
  tailwind.config = { theme: { extend: { fontFamily: { poppins: [''Poppins'', ''sans-serif''] } } } }
</script>
<h1 class="font-poppins font-semibold">Poppins heading</h1>
```

## Practice
Load two Google Fonts, register both in the config and build a page where headings use one font and body text uses the other. Screenshot the difference.', 'A font must be loaded before the browser can display it.
Registering the family in fontFamily gives you a utility such as font-poppins.
Always keep a fallback family such as sans-serif in the list.', 'arfDRUIZOiw', 4, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Import a Google Font in the page.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Register the font family in the config.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Apply the font with a utility class.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=arfDRUIZOiw'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Custom Fonts','https://www.youtube.com/results?search_query=Custom+Fonts'),(@lesson,'Tailwind docs: Font family','https://tailwindcss.com/docs/font-family');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Custom Fonts','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where do you register a new font family so Tailwind can generate a class?','The config generates the font-* utility.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In fontFamily inside the theme config',1,0),(@q,'In the HTML head only',0,1),(@q,'In a CSS comment',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A loaded web font still needs a fallback family.','Fallbacks keep text readable if the font fails to load.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Custom Fonts','Practise: Load and use web fonts such as Poppins in a Tailwind project','Load two Google Fonts, register both in the config and build a page where headings use one font and body text uses the other. Screenshot the difference.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Custom Fonts: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 3: Layout and Responsive Design =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Layout and Responsive Design','Flexbox, grids, breakpoints and reusable component styles.',2);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Layout and Responsive Design',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Layout and Responsive Design');

-- Lesson 7: Using Flexbox
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Using Flexbox', 'Lay out rows and columns with flex utilities.', 'Create a flex container.
Align and justify items.
Control direction, wrapping and gaps.', '## What this lesson covers

Lay out rows and columns with flex utilities.

- flex turns an element into a flex container; inline-flex stays inline.
- items-* aligns on the cross axis and justify-* aligns on the main axis.
- gap-* adds spacing between flex children without margins.

## Key code
```html
<div class="flex flex-col md:flex-row items-center justify-between gap-6">
  <div class="p-4 border rounded-lg">Plan A</div>
  <div class="p-4 border rounded-lg">Plan B</div>
</div>
```

## Practice
Build a pricing row with three flex children that sit side by side on desktop, wrap on small screens and use gap-6. Centre the content of each card with flex flex-col items-center.', 'flex turns an element into a flex container; inline-flex stays inline.
items-* aligns on the cross axis and justify-* aligns on the main axis.
gap-* adds spacing between flex children without margins.', 'WK6u8YDYqak', 7, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a flex container.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Align and justify items.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Control direction, wrapping and gaps.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=WK6u8YDYqak'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Using Flexbox','https://www.youtube.com/results?search_query=Using+Flexbox'),(@lesson,'Tailwind docs: Flexbox','https://tailwindcss.com/docs/flex');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Using Flexbox','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class centres flex children horizontally on the main axis?','justify-* works along the main axis; items-* works across it.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'justify-center',1,0),(@q,'items-center',0,1),(@q,'text-center',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class adds space between flex children?','gap utilities are designed for flex and grid containers.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'gap-4',1,0),(@q,'space-4',0,1),(@q,'between-4',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Using Flexbox','Practise: Lay out rows and columns with flex utilities','Build a pricing row with three flex children that sit side by side on desktop, wrap on small screens and use gap-6. Centre the content of each card with flex flex-col items-center.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Using Flexbox: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 8: Responsive Classes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Responsive Classes', 'Change styles at different screen sizes with breakpoint prefixes.', 'Apply sm, md and lg prefixes.
Stack columns on mobile and place them side by side on desktop.
Check the result by resizing the window.', '## What this lesson covers

Change styles at different screen sizes with breakpoint prefixes.

- Tailwind breakpoints are mobile first: unprefixed classes apply everywhere and prefixes apply from that width up.
- Common breakpoints are sm 640px, md 768px, lg 1024px and xl 1280px.
- Hidden classes such as hidden md:block switch content between screen sizes.

## Key code
```html
<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
  <div>Left column</div>
  <div>Right column</div>
</div>
<p class="block md:hidden">You are on a small screen.</p>
```

## Practice
Create a two-column section that stacks on phones and sits side by side from the md breakpoint. Add a mobile-only note and a desktop-only note using hidden and md:block.', 'Tailwind breakpoints are mobile first: unprefixed classes apply everywhere and prefixes apply from that width up.
Common breakpoints are sm 640px, md 768px, lg 1024px and xl 1280px.
Hidden classes such as hidden md:block switch content between screen sizes.', 'VYFjvMfVv2o', 6, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Apply sm, md and lg prefixes.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Stack columns on mobile and place them side by side on desktop.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Check the result by resizing the window.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=VYFjvMfVv2o'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Responsive Classes','https://www.youtube.com/results?search_query=Responsive+Classes'),(@lesson,'Tailwind docs: Responsive design','https://tailwindcss.com/docs/responsive-design');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Responsive Classes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which width does the md prefix start at by default?','md starts at 768px in the default theme.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'768px',1,0),(@q,'640px',0,1),(@q,'1024px',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Tailwind responsive classes are mobile first.','Unprefixed styles apply everywhere, then prefixes override from that width up.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Responsive Classes','Practise: Change styles at different screen sizes with breakpoint prefixes','Create a two-column section that stacks on phones and sits side by side from the md breakpoint. Add a mobile-only note and a desktop-only note using hidden and md:block.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Responsive Classes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 9: Cards
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Cards', 'Build reusable cards with images, text and actions.', 'Create a card with image, title, text and link.
Use rounded, shadow and overflow utilities.
Make cards equal height inside a grid.', '## What this lesson covers

Build reusable cards with images, text and actions.

- overflow-hidden clips an image to the card corners.
- h-full makes cards in a grid share the same height.
- group and group-hover let a child react when the whole card is hovered.

## Key code
```html
<article class="group bg-white rounded-xl shadow-sm overflow-hidden">
  <img src="dish.jpg" alt="Jollof rice" class="h-48 w-full object-cover group-hover:scale-105 transition">
  <div class="p-5 space-y-2">
    <span class="text-xs font-bold uppercase text-amber-600">Rice</span>
    <h3 class="text-lg font-semibold">Jollof rice</h3>
    <p class="text-sm text-gray-600">A one-pot classic.</p>
  </div>
</article>
```

## Practice
Build three recipe cards in a responsive grid with images, a category label, a title, a short description and a "Read more" link. Add a group-hover effect that scales the image slightly.', 'overflow-hidden clips an image to the card corners.
h-full makes cards in a grid share the same height.
group and group-hover let a child react when the whole card is hovered.', 'vqKie-xmcFs', 7, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a card with image, title, text and link.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use rounded, shadow and overflow utilities.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Make cards equal height inside a grid.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=vqKie-xmcFs'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Cards','https://www.youtube.com/results?search_query=Cards'),(@lesson,'Tailwind docs: Object fit','https://tailwindcss.com/docs/object-fit');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Cards','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class keeps an image inside the rounded corners of a card?','overflow-hidden clips the child image to the card radius.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'overflow-hidden',1,0),(@q,'clip-image',0,1),(@q,'rounded-img',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class lets a child element respond to hovering the whole card?','Mark the card as group, then use group-hover on the child.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'group with group-hover on the child',1,0),(@q,'hover on the child only',0,1),(@q,'peer with active',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Cards','Practise: Build reusable cards with images, text and actions','Build three recipe cards in a responsive grid with images, a category label, a title, a short description and a "Read more" link. Add a group-hover effect that scales the image slightly.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Cards: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 10: Badges
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Badges', 'Add small status labels to cards and tables.', 'Create a badge with padding, rounding and small text.
Use colour variants for different statuses.
Place badges inline next to headings.', '## What this lesson covers

Add small status labels to cards and tables.

- A badge is a span with px, py, rounded-full and a small text size.
- Colour combinations such as bg-green-100 text-green-800 read well for status.
- Badges are inline-flex so they align with neighbouring text.

## Key code
```html
<span class="inline-flex px-2.5 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">Completed</span>
<span class="inline-flex px-2.5 py-1 rounded-full text-xs font-medium bg-amber-100 text-amber-800">In progress</span>
```

## Practice
Add four badges to a table row or card list: New, In progress, Completed and Cancelled, each with a different colour pair. Screenshot the set.', 'A badge is a span with px, py, rounded-full and a small text size.
Colour combinations such as bg-green-100 text-green-800 read well for status.
Badges are inline-flex so they align with neighbouring text.', 'cY0XJY98d3w', 4, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a badge with padding, rounding and small text.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use colour variants for different statuses.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Place badges inline next to headings.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=cY0XJY98d3w'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Badges','https://www.youtube.com/results?search_query=Badges'),(@lesson,'Tailwind docs: Border radius','https://tailwindcss.com/docs/border-radius');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Badges','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which combination makes a soft pill-shaped label?','Small text, tight padding and full rounding create a pill badge.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'px-2 py-1 rounded-full text-xs with light background',1,0),(@q,'p-4 rounded-none text-lg',0,1),(@q,'m-2 border-4 text-2xl',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A light background with dark text gives a badge good contrast.','Contrast keeps small labels readable.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Badges','Practise: Add small status labels to cards and tables','Add four badges to a table row or card list: New, In progress, Completed and Cancelled, each with a different colour pair. Screenshot the set.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Badges: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 11: @apply Directive
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'@apply Directive', 'Reuse utility sets with the @apply directive.', 'Write a component class with @apply.
Use the class in your markup.
Keep markup short without losing the design.', '## What this lesson covers

Reuse utility sets with the @apply directive.

- @apply copies utilities into a CSS class so repeated styles stay in one place.
- It suits buttons and cards that appear many times.
- Prefer utilities for one-off styling and @apply for repeated patterns.

## Key code
```css
.btn-primary {
  @apply px-4 py-2 rounded-lg bg-indigo-600 text-white font-medium hover:bg-indigo-700;
}
```

## Practice
Create a stylesheet with .btn-primary and .card classes built with @apply, then rebuild the previous card and button using those two classes.', '@apply copies utilities into a CSS class so repeated styles stay in one place.
It suits buttons and cards that appear many times.
Prefer utilities for one-off styling and @apply for repeated patterns.', 'somWrB-wumY', 4, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write a component class with @apply.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the class in your markup.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep markup short without losing the design.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=somWrB-wumY'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: @apply Directive','https://www.youtube.com/results?search_query=@apply+Directive'),(@lesson,'Tailwind docs: Using @apply','https://tailwindcss.com/docs/functions-and-directives#apply');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: @apply Directive','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does @apply do?','@apply inserts the utility rules into your own class.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It copies utility classes into a custom CSS class',1,0),(@q,'It applies a Tailwind component library',0,1),(@q,'It installs Tailwind',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','You should move every utility class into @apply classes.','Use @apply for repeated patterns; utilities stay readable for one-offs.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: @apply Directive','Practise: Reuse utility sets with the @apply directive','Create a stylesheet with .btn-primary and .card classes built with @apply, then rebuild the previous card and button using those two classes.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','@apply Directive: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 12: Grids
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Grids', 'Build page sections with CSS grid utilities.', 'Create a grid with grid-cols utilities.
Span items across columns.
Change the grid at breakpoints.', '## What this lesson covers

Build page sections with CSS grid utilities.

- grid with grid-cols-1 md:grid-cols-3 sets a responsive column count.
- col-span-2 lets one item take two columns.
- gap-* works the same way in grids and flexbox.

## Key code
```html
<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
  <article class="md:col-span-2">Lead story</article>
  <article>Second story</article>
  <article>Third story</article>
  <article>Fourth story</article>
</div>
```

## Practice
Build a magazine layout with a grid where the lead story spans two columns and three smaller stories fill the rest. Collapse to one column on mobile.', 'grid with grid-cols-1 md:grid-cols-3 sets a responsive column count.
col-span-2 lets one item take two columns.
gap-* works the same way in grids and flexbox.', '_r2qB44o_Fs', 7, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a grid with grid-cols utilities.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Span items across columns.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Change the grid at breakpoints.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=_r2qB44o_Fs'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Grids','https://www.youtube.com/results?search_query=Grids'),(@lesson,'Tailwind docs: Grid template columns','https://tailwindcss.com/docs/grid-template-columns');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Grids','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class makes an item span two grid columns?','col-span-* widens a grid item.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'col-span-2',1,0),(@q,'span-2',0,1),(@q,'grid-2',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pair creates three equal columns on desktop and one on mobile?','Mobile first: start with one column and add three from md.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'grid-cols-1 md:grid-cols-3',1,0),(@q,'grid-cols-3 md:grid-cols-1',0,1),(@q,'grid-3',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Grids','Practise: Build page sections with CSS grid utilities','Build a magazine layout with a grid where the lead story spans two columns and three smaller stories fill the rest. Collapse to one column on mobile.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Grids: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 4: Components and Interfaces =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Components and Interfaces','Buttons, icons, hover states, a responsive navbar and transitions.',3);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Components and Interfaces',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Components and Interfaces');

-- Lesson 13: Buttons
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Buttons', 'Style buttons and links consistently.', 'Create primary and secondary button styles.
Add sizes, rounding and disabled states.
Style an anchor as a button.', '## What this lesson covers

Style buttons and links consistently.

- A button style is usually px, py, rounded, font-medium plus a colour pair.
- Use inline-flex items-center gap-2 when a button holds an icon.
- disabled:opacity-50 and disabled:cursor-not-allowed handle disabled buttons.

## Key code
```html
<button class="px-4 py-2 rounded-lg bg-indigo-600 text-white font-medium hover:bg-indigo-700">Save</button>
<button class="px-4 py-2 rounded-lg border border-gray-300 font-medium hover:bg-gray-50">Cancel</button>
<button class="px-4 py-2 rounded-lg bg-gray-800 text-white" disabled>Disabled</button>
```

## Practice
Build four button variants: solid, outline, ghost and icon-only. Add one disabled example and screenshot all of them.', 'A button style is usually px, py, rounded, font-medium plus a colour pair.
Use inline-flex items-center gap-2 when a button holds an icon.
disabled:opacity-50 and disabled:cursor-not-allowed handle disabled buttons.', 'kMiMlB5PZRM', 5, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create primary and secondary button styles.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add sizes, rounding and disabled states.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Style an anchor as a button.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=kMiMlB5PZRM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Buttons','https://www.youtube.com/results?search_query=Buttons'),(@lesson,'Tailwind docs: Cursor','https://tailwindcss.com/docs/cursor');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Buttons','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which utilities make an anchor look like a button?','Padding, rounding, background and text colour create the button look.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'px-4 py-2 rounded-lg bg-indigo-600 text-white',1,0),(@q,'text-blue underline',0,1),(@q,'m-4 p-0',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','You can style an anchor element to look like a button.','Anchors navigate; buttons act. Both can share the same visual style.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Buttons','Practise: Style buttons and links consistently','Build four button variants: solid, outline, ghost and icon-only. Add one disabled example and screenshot all of them.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Buttons: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 14: Icons
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Icons', 'Add icons next to text with inline SVG or an icon set.', 'Place an icon inside a button or link.
Size an icon with the size utilities.
Align icon and text.', '## What this lesson covers

Add icons next to text with inline SVG or an icon set.

- Inline SVG inherits the current text colour, so text utilities control icon colour.
- Icons are sized with h-* and w-* or size-* classes.
- inline-flex items-center gap-2 keeps icon and label aligned.

## Key code
```html
<button class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-indigo-600 text-white">
  <svg class="size-4" aria-hidden="true"><!-- path --></svg>
  Search
</button>
```

## Practice
Add icons to a navbar, a button and a list of features. Use at least four different icons and match each icon size to the text.', 'Inline SVG inherits the current text colour, so text utilities control icon colour.
Icons are sized with h-* and w-* or size-* classes.
inline-flex items-center gap-2 keeps icon and label aligned.', 'aNmBiqK2uQ0', 5, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Place an icon inside a button or link.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Size an icon with the size utilities.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Align icon and text.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=aNmBiqK2uQ0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Icons','https://www.youtube.com/results?search_query=Icons'),(@lesson,'Tailwind docs: Width','https://tailwindcss.com/docs/width');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Icons','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why do inline SVG icons change colour with text classes?','SVG fill set to currentColor follows the text colour.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'They inherit currentColor from the text colour',1,0),(@q,'They have a fixed colour attribute',0,1),(@q,'They load a colour file',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which utility sets both width and height of an icon at once?','size-* sets width and height together.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'size-5',1,0),(@q,'icon-5',0,1),(@q,'w-5 only',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Icons','Practise: Add icons next to text with inline SVG or an icon set','Add icons to a navbar, a button and a list of features. Use at least four different icons and match each icon size to the text.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Icons: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 15: Hover Effects
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Hover Effects', 'Add hover, focus and active states with variant prefixes.', 'Change colour, shadow and scale on hover.
Style focus states for keyboard users.
Chain variants such as md:hover.', '## What this lesson covers

Add hover, focus and active states with variant prefixes.

- A variant prefix such as hover: applies a utility only in that state.
- focus-visible: gives keyboard users a clear outline without affecting mouse clicks.
- Variants combine, for example md:hover:bg-indigo-700.

## Key code
```html
<a href="#" class="px-3 py-2 rounded-md hover:bg-gray-100 focus-visible:ring-2 focus-visible:ring-indigo-500">Docs</a>
```

## Practice
Add hover, focus-visible and active styles to your buttons and links. Include one combined md:hover style and screenshot the states.', 'A variant prefix such as hover: applies a utility only in that state.
focus-visible: gives keyboard users a clear outline without affecting mouse clicks.
Variants combine, for example md:hover:bg-indigo-700.', 't19h2Ki_DUw', 4, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Change colour, shadow and scale on hover.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Style focus states for keyboard users.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Chain variants such as md:hover.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=t19h2Ki_DUw'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Hover Effects','https://www.youtube.com/results?search_query=Hover+Effects'),(@lesson,'Tailwind docs: Hover, focus and other states','https://tailwindcss.com/docs/hover-focus-and-other-states');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Hover Effects','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class changes the background only while the pointer is over the element?','The hover prefix applies the utility in the hover state.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'hover:bg-gray-100',1,0),(@q,'bg-hover-gray',0,1),(@q,'focus:bg-gray-100',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which variant gives keyboard users a visible ring?','focus-visible targets keyboard focus.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'focus-visible:ring-2',1,0),(@q,'hover:ring-2',0,1),(@q,'active:ring-2',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Hover Effects','Practise: Add hover, focus and active states with variant prefixes','Add hover, focus-visible and active styles to your buttons and links. Include one combined md:hover style and screenshot the states.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Hover Effects: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 16: Responsive Nav (part 1)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Responsive Nav (part 1)', 'Build the desktop version of a responsive navigation bar.', 'Create a navbar with a logo and links.
Space items with flex utilities.
Add hover styles to each link.', '## What this lesson covers

Build the desktop version of a responsive navigation bar.

- A navbar is usually a flex container with justify-between and items-center.
- Hidden links collapse into a mobile menu below a breakpoint.
- Padding and gap utilities keep the bar readable at every size.

## Key code
```html
<nav class="flex items-center justify-between px-4 py-3 border-b">
  <a href="#" class="font-bold">Learnow</a>
  <ul class="hidden md:flex items-center gap-6">
    <li><a class="hover:text-indigo-600" href="#">Courses</a></li>
    <li><a class="hover:text-indigo-600" href="#">Pricing</a></li>
  </ul>
  <a href="#" class="px-4 py-2 rounded-lg bg-indigo-600 text-white">Sign in</a>
</nav>
```

## Practice
Build the desktop navbar with a logo, four links and a sign-in button. Include hover styles and a bottom border, then screenshot it at desktop width.', 'A navbar is usually a flex container with justify-between and items-center.
Hidden links collapse into a mobile menu below a breakpoint.
Padding and gap utilities keep the bar readable at every size.', 'Yn7C8MI6ymo', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a navbar with a logo and links.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Space items with flex utilities.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add hover styles to each link.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Yn7C8MI6ymo'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Responsive Nav (part 1)','https://www.youtube.com/results?search_query=Responsive+Nav+(part+1)'),(@lesson,'Tailwind docs: Justify content','https://tailwindcss.com/docs/justify-content');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Responsive Nav (part 1)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pair spreads a logo and links to the two ends of a navbar?','justify-between pushes content to both ends.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'flex justify-between items-center',1,0),(@q,'block text-center',0,1),(@q,'grid gap-0',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A responsive navbar needs a separate mobile menu.','Links usually collapse into a toggleable menu on small screens.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Responsive Nav (part 1)','Practise: Build the desktop version of a responsive navigation bar','Build the desktop navbar with a logo, four links and a sign-in button. Include hover styles and a bottom border, then screenshot it at desktop width.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Responsive Nav (part 1): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 17: Responsive Nav (part 2)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Responsive Nav (part 2)', 'Add the mobile menu and toggle behaviour.', 'Add a menu button for small screens.
Show and hide the mobile menu.
Close the menu after a link is chosen.', '## What this lesson covers

Add the mobile menu and toggle behaviour.

- The toggle button is visible only below the breakpoint with md:hidden.
- A small script can add or remove a hidden class on the menu.
- Writing the menu state in the markup keeps the behaviour easy to read.

## Key code
```html
<button id="navToggle" class="md:hidden p-2 rounded-md hover:bg-gray-100">Menu</button>
<div id="navMobile" class="hidden flex-col gap-2 p-4 md:hidden">Mobile links</div>
<script>
  const toggle = document.getElementById(''navToggle'');
  const menu = document.getElementById(''navMobile'');
  toggle.addEventListener(''click'', () => menu.classList.toggle(''hidden''));
</script>
```

## Practice
Finish the navbar: add a hamburger button that appears on small screens and toggles a stacked mobile menu, and close the menu when a link is clicked. Test on a narrow window.', 'The toggle button is visible only below the breakpoint with md:hidden.
A small script can add or remove a hidden class on the menu.
Writing the menu state in the markup keeps the behaviour easy to read.', 'kdF-OVtBtHU', 7, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a menu button for small screens.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Show and hide the mobile menu.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Close the menu after a link is chosen.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=kdF-OVtBtHU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Responsive Nav (part 2)','https://www.youtube.com/results?search_query=Responsive+Nav+(part+2)'),(@lesson,'Tailwind docs: Display','https://tailwindcss.com/docs/display');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Responsive Nav (part 2)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class hides the menu button on larger screens?','md:hidden hides the element from the md breakpoint up.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'md:hidden',1,0),(@q,'hidden:md',0,1),(@q,'md:block',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A mobile menu normally closes after a link is tapped.','Closing avoids covering the page the visitor just navigated to.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Responsive Nav (part 2)','Practise: Add the mobile menu and toggle behaviour','Finish the navbar: add a hamburger button that appears on small screens and toggles a stacked mobile menu, and close the menu when a link is clicked. Test on a narrow window.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Responsive Nav (part 2): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 18: Transitions
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Transitions', 'Make state changes smooth with transition utilities.', 'Add transition utilities to interactive elements.
Set duration and easing.
Animate transform and colour changes.', '## What this lesson covers

Make state changes smooth with transition utilities.

- transition collects common animated properties; transition-all includes everything.
- duration-* sets the time and ease-* the curve.
- Transforms such as scale, translate and rotate animate smoothly when a transition is present.

## Key code
```html
<button class="px-4 py-2 rounded-lg bg-indigo-600 text-white transition duration-200 ease-out hover:bg-indigo-700 hover:-translate-y-0.5">Save</button>
```

## Practice
Add transitions to your buttons, cards and navbar links, using duration-200 and an appropriate easing. Compare the page before and after and describe the difference.', 'transition collects common animated properties; transition-all includes everything.
duration-* sets the time and ease-* the curve.
Transforms such as scale, translate and rotate animate smoothly when a transition is present.', '0zA6GZa2ZKc', 4, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add transition utilities to interactive elements.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set duration and easing.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Animate transform and colour changes.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=0zA6GZa2ZKc'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Transitions','https://www.youtube.com/results?search_query=Transitions'),(@lesson,'Tailwind docs: Transition property','https://tailwindcss.com/docs/transition-property');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Transitions','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which class sets a 200 millisecond transition time?','duration-* controls how long the transition takes.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'duration-200',1,0),(@q,'time-200',0,1),(@q,'delay-200',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A transform can animate smoothly only when a transition utility is set.','Transition utilities opt the element into animation.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Transitions','Practise: Make state changes smooth with transition utilities','Add transitions to your buttons, cards and navbar links, using duration-200 and an appropriate easing. Compare the page before and after and describe the difference.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Transitions: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 5: Wrap Up and Final Projects =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Wrap Up and Final Projects','Review the course, then build a complete responsive page.',4);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Wrap Up and Final Projects',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Wrap Up and Final Projects');

-- Lesson 19: Wrap Up
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Wrap Up', 'Review what you covered and plan the next steps.', 'Recap the main Tailwind concepts.
Plan your final project.
Note the next topics to study.', '## What this lesson covers

Review what you covered and plan the next steps.

- Tailwind is a utility layer; component libraries such as Tailwind UI build on it.
- Custom themes live in the config file, not in the framework files.
- Modern setups compile Tailwind so unused classes are removed from production CSS.

## Practice
Write a short recap of five Tailwind concepts you used most, plus three topics you want to learn next such as animations, dark mode or a component library.', 'Tailwind is a utility layer; component libraries such as Tailwind UI build on it.
Custom themes live in the config file, not in the framework files.
Modern setups compile Tailwind so unused classes are removed from production CSS.', 'LqSOFdSupks', 2, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recap the main Tailwind concepts.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Plan your final project.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Note the next topics to study.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=LqSOFdSupks'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw'),(@lesson,'Search YouTube: Wrap Up','https://www.youtube.com/results?search_query=Wrap+Up');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Wrap Up','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which file holds your theme customisations?','The config file defines the theme values Tailwind generates classes from.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The Tailwind config file',1,0),(@q,'The HTML page only',0,1),(@q,'The CDN script',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Production builds remove Tailwind classes you never used.','A compiled build only includes the classes found in your files.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which topics continue naturally after this course?','Dark mode, themed design systems and reusable component patterns are the natural next steps.',2,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Dark mode with the dark variant',1,0),(@q,'Building a design system in the config',1,1),(@q,'Deleting all utility classes',0,2),(@q,'Component patterns such as navigation and dialogs',1,3);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 1: Responsive marketing page','Build and publish a complete responsive page with Tailwind CSS.','Build a one-page marketing site for a product or service of your choice with Tailwind CSS.
Requirements: a responsive navbar with a working mobile menu, a hero section with a call to action, a three-card feature grid that stacks on mobile, a pricing section with three plans and one highlighted plan, a testimonial card with a badge, a FAQ built with details and summary elements, a contact form styled with utilities, and a footer with icons.
Use a custom config with at least one brand colour and one custom font, hover states on every interactive element, and a consistent spacing rhythm.

Submit a live URL (GitHub Pages, Netlify or your host) or a repository link, plus a short note on one layout problem you solved.','Build a complete responsive page with utility classes',100,60,1,1,1,1,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Responsive layout works on phone, tablet and desktop',30),(@assign,'All required sections and interactive states present',30),(@assign,'Consistent spacing, colour and typography',20),(@assign,'Clean markup, alt text and accessible states',10),(@assign,'Live link and reflection note',10);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 2: Dashboard with @apply components (optional challenge)','Create a small design system with @apply and reuse it in a dashboard.','Build a dashboard page with Tailwind CSS and a small reusable component layer.
Create CSS classes with @apply for at least four components: a primary button, a card, a badge and a stat tile. Use them throughout a dashboard with a sidebar, four stat tiles, a table with status badges and a tabbed panel.
Keep the markup short by using your component classes, and document each class in a short comment.

Submit a live URL or repository link and a note explaining when you chose @apply over inline utilities.','Reuse styles with @apply and document the component layer',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Component classes created and used consistently',30),(@assign,'Dashboard sections render correctly at all sizes',30),(@assign,'Markup is short and readable',20),(@assign,'Comments explain each component class',10),(@assign,'Live link and note',10);
SET @prev_stage=@stage;

COMMIT;
SELECT 'Tailwind CSS for Beginners installed' AS result,(SELECT COUNT(*) FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=@path) AS lessons,(SELECT COUNT(*) FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE s.path_id=@path) AS quizzes,(SELECT COUNT(*) FROM assignments a JOIN stages s ON s.id=a.stage_id WHERE s.path_id=@path) AS assignments;
