-- HTML for Beginners: 23 lessons, 23 quizzes and 23 practice assignments built from the YouTube playlist.
-- Run in phpMyAdmin with YOUR database selected. Run it once.
-- Step 1 removes the earlier demo course (slug html-web-development) if it exists.
-- To reinstall this course later, first run:  DELETE FROM learning_paths WHERE slug='html-for-beginners';  (this also deletes enrolments and progress for the course)
START TRANSACTION;
DELETE FROM learning_paths WHERE slug='html-web-development';
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Web Development','web-development','Build useful things for the web.','code','orange',1);
SET @cat=(SELECT id FROM categories WHERE slug='web-development');
INSERT INTO learning_paths(category_id,title,slug,description,objectives,difficulty,status,certificate_enabled,certificate_min_score) VALUES(@cat,'HTML for Beginners','html-for-beginners','Learn HTML from the very beginning. Follow 23 short video lessons, check your understanding with a quiz after every lesson and practise with a hands-on assignment, from your first page to forms and common mistakes.','Write valid HTML pages with the correct structure
Use headings, paragraphs, lists, links, images and tables
Style pages with inline, internal and external CSS
Build forms and embed content
Spot and fix common HTML mistakes','beginner','published',1,60);
SET @path=LAST_INSERT_ID();
SET @prev_stage=NULL;

-- ===== STAGE 1: Getting Started =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Getting Started','Learn what HTML is, set up your tools and understand elements and attributes.',0);
SET @stage=LAST_INSERT_ID();
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Getting Started',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Getting Started');

-- Lesson 1: HTML Introduction
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Introduction','Learn what HTML is and read your first complete HTML document.','Write the structure of a simple page from memory.
Explain what HTML does in one sentence.
Name the purpose of head and body.','## What is HTML?
HTML stands for HyperText Markup Language. It is the standard language for creating web pages. HTML describes the structure of a page with elements, and the browser reads those elements and displays the result. The browser shows your content, not the tags themselves.

## A simple HTML document
```html
<!DOCTYPE html>
<html>
<head>
  <title>My First Page</title>
</head>
<body>
  <h1>My First Heading</h1>
  <p>My first paragraph.</p>
</body>
</html>
```

## Reading the example
The doctype declaration tells the browser this is an HTML5 document. The html element is the root of the page. The head holds information about the page, such as its title. The body holds everything visitors can see.','HTML is the markup language that structures web pages.
Browsers display the content, not the tags.
Every page has html, head and body elements.','it1rTvBcfRg',12,1,1,0,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write the structure of a simple page from memory.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what HTML does in one sentence.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name the purpose of head and body.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=it1rTvBcfRg'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML introduction for beginners','https://www.youtube.com/results?search_query=HTML+introduction+for+beginners'),(@lesson,'W3Schools reference: HTML Introduction','https://www.w3schools.com/html/html_intro.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Introduction','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does HTML stand for?','HTML stands for HyperText Markup Language.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'HyperText Markup Language',1,0),(@q,'High Tech Modern Language',0,1),(@q,'Hyperlinks and Text Making Language',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element holds the content visitors see on the page?','The body element contains the visible content of the page.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<body>',1,0),(@q,'<head>',0,1),(@q,'<title>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A browser displays the HTML tags on the screen so visitors can read them.','Browsers read the tags to understand structure but do not display them.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does <!DOCTYPE html> declare?','The doctype tells the browser which HTML version to use.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'That the document is HTML5',1,0),(@q,'That the page has a title',0,1),(@q,'That the page uses JavaScript',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Create your first web page','Build a small HTML page about yourself using the basic page structure.','Create a file named index.html with a doctype, html, head, title and body.
Inside the body add one h1 with your name and two paragraphs about you.
Open it in a browser and confirm it displays correctly.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Understand and use the HTML structure',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Correct page structure',50),(@assign,'Content matches the brief',30),(@assign,'Short reflection on what you learned',20);

-- Lesson 2: HTML Editors
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Editors','Set up an editor and learn the create, save and refresh workflow.','Install a code editor.
Create and save index.html in a new folder.
Open the page in a browser and refresh after an edit.','## You only need a text editor
Web pages are plain text files. Professional editors such as Visual Studio Code, Sublime Text or Notepad++ are free and help you with colour, indentation and suggestions. Avoid word processors such as Microsoft Word because they add hidden formatting that breaks web pages.

## The workflow
1. Open your editor and create a new file.
2. Write your HTML.
3. Save it with the .html extension, for example index.html.
4. Open the file in a browser.
5. After every change, save and refresh the browser.

## Helpful extras
Install a live-preview extension such as Live Server so the browser refreshes by itself each time you save. Keep all your files for one website in the same folder.','Use a code editor, not a word processor.
Save files with the .html extension.
Save and refresh to see every change.','bBP0ckEln4Y',10,1,1,1,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Install a code editor.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create and save index.html in a new folder.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Open the page in a browser and refresh after an edit.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=bBP0ckEln4Y'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML editors VS Code setup beginners','https://www.youtube.com/results?search_query=HTML+editors+VS+Code+setup+beginners'),(@lesson,'W3Schools reference: HTML Editors','https://www.w3schools.com/html/html_editors.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Editors','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which tool is suitable for writing HTML?','Code editors save plain text without hidden formatting.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A code editor such as VS Code',1,0),(@q,'Microsoft Word',0,1),(@q,'A spreadsheet program',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which file extension should an HTML page use?','HTML pages are saved with .html (or .htm).',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'.html',1,0),(@q,'.txt',0,1),(@q,'.doc',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','After editing a file you should save it and refresh the browser to see the change.','The browser shows the last saved version until you refresh.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which are good practices when working on a website?','Tidy names and folders prevent broken links later.',2,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Keep a site''s files in one folder',1,0),(@q,'Use lowercase file names',1,1),(@q,'Put spaces and capitals everywhere in file names',0,2),(@q,'Save pages as Word documents',0,3);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Set up your workspace','Prepare your editor and create a practice folder with a first page.','Install a code editor and create a folder named html-practice.
Create index.html inside it containing a heading that says Hello, world.
In the text box, list the editor you chose and the steps you followed to preview the page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Set up a basic HTML workflow',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Folder and file set up correctly',40),(@assign,'Page displays in the browser',40),(@assign,'Clear list of steps',20);

-- Lesson 3: HTML Elements
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Elements','Understand start tags, end tags, content and nesting.','Identify the start tag, content and end tag in an example.
Name two empty elements.
Nest one element inside another correctly.','## Elements and tags
An HTML element is made of a start tag, some content and an end tag.

```html
<h1>My Heading</h1>
<p>My paragraph.</p>
<br>
```

The first two have content and an end tag. The br element is an empty element: it has no content and no end tag.

## Nested elements
Elements can sit inside other elements. The html element contains head and body, and the body contains headings, paragraphs and more. Close inner elements before outer ones.

```html
<body>
  <p>This is <strong>important</strong>.</p>
</body>
```

## Good habits
Write tags in lowercase, close every element that needs closing and indent nested elements so the structure is easy to read.','An element is a start tag, content and an end tag.
Some elements are empty, such as br and hr.
Close inner elements before outer elements.','vIoO52MdZFE',12,1,1,2,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Identify the start tag, content and end tag in an example.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name two empty elements.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Nest one element inside another correctly.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=vIoO52MdZFE'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML elements tags beginners tutorial','https://www.youtube.com/results?search_query=HTML+elements+tags+beginners+tutorial'),(@lesson,'W3Schools reference: HTML Elements','https://www.w3schools.com/html/html_elements.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Elements','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What are the three parts of a typical HTML element?','Most elements have a start tag, content and an end tag.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Start tag, content and end tag',1,0),(@q,'Heading, body and footer',0,1),(@q,'Name, value and type',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which of these is an empty element?','The br element has no content and no end tag.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<br>',1,0),(@q,'<p>',0,1),(@q,'<h1>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Nested elements should be closed in the reverse order they were opened.','Close the innermost element first.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is the best practice for writing tags?','Consistent lowercase and indentation keep code readable.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Use lowercase and close elements properly',1,0),(@q,'Use random capitals',0,1),(@q,'Never indent code',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Mark up a short profile','Use paragraphs, nested elements and an empty element in a short profile.','Create a page with a heading and two paragraphs.
Use strong inside one paragraph to emphasise a word.
Add an empty br element inside a paragraph to break a line.
Indent nested elements.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use elements and nesting correctly',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Elements and nesting correct',50),(@assign,'Indented, readable code',30),(@assign,'Short reflection',20);

-- Lesson 4: HTML Attributes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Attributes','Add extra information to elements with name and value pairs.','Add an href to a link.
Add src and alt to an image.
Set the lang attribute on the html element.','## What attributes do
Attributes provide extra information about an element. They go inside the start tag as name="value" pairs.

```html
<a href="https://www.example.com">Visit example</a>
<img src="photo.jpg" alt="A student reading" width="300">
<html lang="en">
```

## Common attributes
href sets a link destination. src sets the file an image loads. alt gives alternative text. width and height set size. lang declares the page language. title adds a tooltip. style adds inline CSS.

## Quotes and tips
Always wrap values in double quotes. Use lowercase attribute names. Setting lang on the html element helps search engines and screen readers pronounce your content correctly.','Attributes sit in the start tag as name="value".
href, src, alt and lang are essential.
Always quote attribute values.','yMX901oVtn8',12,1,1,3,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add an href to a link.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add src and alt to an image.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set the lang attribute on the html element.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=yMX901oVtn8'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML attributes href src alt lang tutorial','https://www.youtube.com/results?search_query=HTML+attributes+href+src+alt+lang+tutorial'),(@lesson,'W3Schools reference: HTML Attributes','https://www.w3schools.com/html/html_attributes.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Attributes','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute sets the destination of a link?','The href attribute on an a element sets its destination.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'href',1,0),(@q,'src',0,1),(@q,'alt',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is the alt attribute for?','Alt text describes the image when it cannot be seen.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Alternative text for an image',1,0),(@q,'The image width',0,1),(@q,'The image file name',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Attribute values should be written inside quotes.','Quoting values avoids errors, especially with spaces.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where is the lang attribute usually placed?','Declaring the language on html applies to the whole page.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'On the html element',1,0),(@q,'On the title element',0,1),(@q,'On every paragraph',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Attribute practice page','Use at least four different attributes on one page.','Create a page that includes a link with href and title, an image with src, alt, width and height, and an html element with lang.
If you do not have an image, use any picture from your computer in the same folder.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use common attributes',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Four or more attributes used correctly',50),(@assign,'Page works in the browser',30),(@assign,'Short reflection',20);
SET @prev_stage=@stage;

-- ===== STAGE 2: Text, Style and Colour =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Text, Style and Colour','Structure text with headings and paragraphs, then add style, formatting, comments and colour.',1);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Text, Style and Colour',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Text, Style and Colour');

-- Lesson 5: HTML Headings
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Headings','Use heading levels to give your page a clear outline.','Create a page with an h1 and two h2 sections.
Add an h3 under one h2.
Read only your headings and confirm they form a sensible outline.','## Six levels
HTML has six heading levels, from h1 (most important) to h6 (least important).

```html
<h1>Page title</h1>
<h2>Main section</h2>
<h3>Sub-section</h3>
```

## Use headings for structure
Search engines and screen readers use headings to understand and navigate a page. Use one h1 for the main title, then h2 for sections and h3 for sub-sections. Do not skip levels and do not choose a heading just because it looks bigger or smaller; CSS can change size later.

## Horizontal rule
The hr element draws a line that separates content. Use it when there is a real change of topic.','h1 is the main title and h6 is the least important heading.
Headings build the page outline.
Choose levels for meaning, not for size.','9gHPpwq6IaY',10,1,1,0,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a page with an h1 and two h2 sections.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add an h3 under one h2.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read only your headings and confirm they form a sensible outline.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=9gHPpwq6IaY'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML headings h1 h6 tutorial','https://www.youtube.com/results?search_query=HTML+headings+h1+h6+tutorial'),(@lesson,'W3Schools reference: HTML Headings','https://www.w3schools.com/html/html_headings.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Headings','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is the most important heading level?','h1 is the highest level.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<h1>',1,0),(@q,'<h6>',0,1),(@q,'<head>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','You should pick a heading level because of its default size.','Choose levels for structure and change size with CSS.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element draws a horizontal dividing line?','The hr element creates a thematic break.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<hr>',1,0),(@q,'<br>',0,1),(@q,'<line>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How many h1 elements does a typical page have?','Use one main h1 to name the page.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'One main h1',1,0),(@q,'Six',0,1),(@q,'None',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Page outline','Create a page whose headings form a clear outline.','Write a page about a hobby with one h1, three h2 sections and at least one h3.
Add one sentence under each heading.
Do not skip heading levels.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use headings for structure',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Heading levels correct and in order',50),(@assign,'Content under each heading',30),(@assign,'Short reflection',20);

-- Lesson 6: HTML Paragraphs
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Paragraphs','Write paragraphs, line breaks and preformatted text.','Write three paragraphs.
Use br inside a paragraph.
Show text with pre so spaces are preserved.','## The p element
A paragraph is created with the p element. Browsers add space before and after each paragraph.

```html
<p>This is a paragraph.</p>
<p>This is another paragraph.</p>
```

## Extra spaces collapse
Browsers ignore extra spaces and line breaks in your code. Many spaces are shown as one. To force a line break, use the br element.

```html
<p>First line<br>Second line</p>
```

## Preformatted text
The pre element keeps spaces and line breaks exactly as typed. It is useful for code and poetry.

```html
<pre>
  Spaces and
  lines stay.
</pre>
```','Use p for paragraphs.
Browsers collapse extra spaces.
Use br for a line break and pre for preformatted text.','qis4kAOThLw',10,1,1,1,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write three paragraphs.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use br inside a paragraph.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Show text with pre so spaces are preserved.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=qis4kAOThLw'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML paragraphs br pre tutorial','https://www.youtube.com/results?search_query=HTML+paragraphs+br+pre+tutorial'),(@lesson,'W3Schools reference: HTML Paragraphs','https://www.w3schools.com/html/html_paragraphs.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Paragraphs','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element defines a paragraph?','The p element defines a paragraph.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<p>',1,0),(@q,'<para>',0,1),(@q,'<pg>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How does a browser treat many spaces in your HTML?','Extra whitespace is collapsed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It shows them as a single space',1,0),(@q,'It shows every space',0,1),(@q,'It shows an error',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element inserts a line break?','br inserts a line break.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<br>',1,0),(@q,'<lb>',0,1),(@q,'<break>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element keeps spacing exactly as typed?','pre preserves whitespace and line breaks.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<pre>',1,0),(@q,'<p>',0,1),(@q,'<span>',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: A short poem or recipe','Practise paragraphs, line breaks and preformatted text.','Create a page with a short poem, a recipe or a set of directions.
Use paragraphs for normal text, br where a line must break and pre for one block that must keep its spacing.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Format text with paragraphs',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Correct paragraphs, br and pre',50),(@assign,'Readable result in the browser',30),(@assign,'Short reflection',20);

-- Lesson 7: HTML Styles
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Styles','Change how elements look with the style attribute.','Change a heading''s colour.
Give a paragraph a background colour.
Centre a heading with text-align.','## The style attribute
You can add styling to any element with the style attribute. It holds CSS properties and values.

```html
<h1 style="color:blue;">A blue heading</h1>
<p style="background-color:lightgray;">A grey paragraph.</p>
```

## Common properties
- color sets text colour.
- background-color sets the background.
- font-family sets the typeface.
- font-size sets the text size.
- text-align sets alignment, such as center.

```html
<p style="font-size:20px; text-align:center;">Centred text</p>
```

## A note
Inline styles are quick for learning and tests, but larger sites keep styles in a separate CSS file, which you will meet in HTML and CSS.','The style attribute applies CSS to one element.
Use property:value; pairs.
Inline styles are for quick changes.','twdNPJfbj_8',12,1,1,2,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Change a heading''s colour.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Give a paragraph a background colour.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Centre a heading with text-align.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=twdNPJfbj_8'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML style attribute inline CSS tutorial','https://www.youtube.com/results?search_query=HTML+style+attribute+inline+CSS+tutorial'),(@lesson,'W3Schools reference: HTML Styles','https://www.w3schools.com/html/html_styles.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Styles','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute adds CSS directly to an element?','The style attribute holds inline CSS.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'style',1,0),(@q,'class',0,1),(@q,'css',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which property changes the text colour?','The CSS property is color.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'color',1,0),(@q,'font-color',0,1),(@q,'text-style',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which property centres text?','Use text-align:center.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'text-align:center',1,0),(@q,'align:middle',0,1),(@q,'center:text',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Inline styles apply only to the element that contains them.','An inline style affects just that element.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Style a page with inline CSS','Use the style attribute to change several elements.','Create a page with a heading, two paragraphs and a divider.
Give the heading a colour, one paragraph a background colour and one paragraph a larger font size.
Centre the heading.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use inline styles',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'At least four style changes',50),(@assign,'Valid property syntax',30),(@assign,'Short reflection',20);

-- Lesson 8: HTML Formatting
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Formatting','Use formatting elements to give text meaning.','Use strong and em in a sentence.
Write H2O with a subscript.
Show a deleted and an inserted word.','## Formatting elements
HTML has elements that mark text with special meaning.

```html
<p><strong>Important</strong> and <em>emphasised</em> text.</p>
<p>The <mark>highlighted</mark> word.</p>
<p><small>Small print</small>, <del>deleted</del> and <ins>inserted</ins>.</p>
<p>H<sub>2</sub>O and x<sup>2</sup></p>
```

## Meaning matters
strong marks important text and em marks stressed text. They are usually shown bold and italic, but they carry meaning for screen readers and search engines. The b and i elements only change appearance.

## Other useful elements
mark highlights, small shrinks side text, del shows removed text, ins shows added text, sub is a subscript and sup is a superscript.','strong means important and em means emphasised.
mark highlights text.
sub and sup create subscripts and superscripts.','7FqQLqNIEY8',12,1,1,3,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use strong and em in a sentence.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write H2O with a subscript.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Show a deleted and an inserted word.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7FqQLqNIEY8'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML text formatting strong em mark tutorial','https://www.youtube.com/results?search_query=HTML+text+formatting+strong+em+mark+tutorial'),(@lesson,'W3Schools reference: HTML Formatting','https://www.w3schools.com/html/html_formatting.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Formatting','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element marks important text?','strong marks text of strong importance.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<strong>',1,0),(@q,'<small>',0,1),(@q,'<sub>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element creates a superscript?','sup raises text, as in x2.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<sup>',1,0),(@q,'<sub>',0,1),(@q,'<mark>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element highlights text?','mark highlights text like a marker pen.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<mark>',1,0),(@q,'<ins>',0,1),(@q,'<em>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The strong element carries meaning, not just bold appearance.','It tells assistive technology the text is important.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Formatting practice','Write a short note that uses several formatting elements.','Write a short message or recipe note using strong, em, mark, small, del, ins, sub and sup at least once each.
Explain in one line why you chose strong instead of b.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use formatting elements meaningfully',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Elements used correctly',50),(@assign,'Sensible choices of meaning',30),(@assign,'Explanation of strong vs b',20);

-- Lesson 9: HTML Comments
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Comments','Leave notes in your code and temporarily hide parts of a page.','Add a comment that labels a section.
Comment out one paragraph and check it disappears.
Explain why secrets do not belong in comments.','## Writing a comment
Comments are notes in your code that browsers do not display.

```html
<!-- This is a comment -->
<p>This paragraph is visible.</p>
```

## Why use comments
Comments explain why code exists, mark sections and help you or a teammate return to the code later.

## Hide code temporarily
You can comment out code to hide it without deleting it.

```html
<!--
<p>This paragraph is hidden for now.</p>
-->
```

## A caution
Comments can still be read by anyone who views the page source. Never put passwords, private notes or secrets in HTML comments.','Comments use <!-- and -->.
Browsers do not display comments.
Comments are public in page source.','229HYq40vaA',8,1,1,4,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a comment that labels a section.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Comment out one paragraph and check it disappears.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why secrets do not belong in comments.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=229HYq40vaA'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML comments tutorial','https://www.youtube.com/results?search_query=HTML+comments+tutorial'),(@lesson,'W3Schools reference: HTML Comments','https://www.w3schools.com/html/html_comments.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Comments','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which syntax starts and ends an HTML comment?','HTML comments use <!-- and -->.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<!-- comment -->',1,0),(@q,'// comment',0,1),(@q,'/* comment */',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Visitors can see comments by viewing the page source.','Comments are hidden on the page but visible in the source.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What happens to commented-out code?','Browsers ignore commented-out HTML.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The browser does not display it',1,0),(@q,'It runs twice',0,1),(@q,'It becomes bold',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should you never put in an HTML comment?','Comments are public.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A password',1,0),(@q,'A section label',0,1),(@q,'A reminder about a layout',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Comment and hide','Practise commenting and hiding code.','Take one of your earlier pages and add comments that label each major section.
Hide one paragraph using a comment and confirm it disappears in the browser.
Write two sentences about why you should not store secrets in comments.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use comments safely',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Comments added correctly',40),(@assign,'Hidden content works',40),(@assign,'Security explanation',20);

-- Lesson 10: HTML Colors
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Colors','Use colour names, HEX, RGB and HSL values.','Write one colour four different ways.
Set a background and text colour.
Check that text is easy to read.','## Ways to write a colour
```html
<p style="color:tomato;">Colour name</p>
<p style="color:#ff6347;">HEX value</p>
<p style="color:rgb(255,99,71);">RGB value</p>
<p style="color:hsl(9,100%,64%);">HSL value</p>
```

## What each means
Colour names such as red and blue are easy to remember. A HEX value starts with # and uses red, green and blue pairs of digits. RGB uses three numbers from 0 to 255. HSL uses hue, saturation and lightness.

## Where colours apply
Use color for text, background-color for backgrounds and border for borders.

```html
<h2 style="border:2px solid blue;">Bordered heading</h2>
```

## Readable colours
Pick text and background colours with strong contrast so everyone can read your page.','Colours can be names, HEX, RGB or HSL.
HEX starts with # and RGB uses 0 to 255.
Choose colours with strong contrast.','zCrolmdqmF8',12,1,1,5,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write one colour four different ways.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set a background and text colour.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Check that text is easy to read.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=zCrolmdqmF8'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML colors hex rgb hsl tutorial','https://www.youtube.com/results?search_query=HTML+colors+hex+rgb+hsl+tutorial'),(@lesson,'W3Schools reference: HTML Colors','https://www.w3schools.com/html/html_colors.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Colors','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is a valid HEX colour?','HEX values start with # followed by six hexadecimal digits.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'#ff0000',1,0),(@q,'ff0000#',0,1),(@q,'#gg0000',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What range does each RGB number use?','Red, green and blue each range from 0 to 255.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'0 to 255',1,0),(@q,'0 to 100',0,1),(@q,'1 to 10',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which property sets a background colour?','Use background-color.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'background-color',1,0),(@q,'bg',0,1),(@q,'color-back',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Good contrast between text and background helps readability.','High contrast makes text easier to read.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Colour palette page','Create a page that shows colours in different formats.','Create a page with four boxes (use div with a style attribute).
Colour them with a name, a HEX value, an RGB value and an HSL value, and label each box with the value used.
Keep the text readable.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use colour formats',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'All four formats used correctly',50),(@assign,'Readable contrast',30),(@assign,'Short reflection',20);

-- Lesson 11: HTML and CSS
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML and CSS','Learn the three ways to add CSS to a page.','Add an internal style element to a page.
Create styles.css and link it.
Explain why external CSS is best for larger sites.','## Three ways to add CSS
Inline CSS uses the style attribute on one element. Internal CSS uses a style element in the head. External CSS uses a separate file linked from the head.

```html
<head>
  <style>
    body { background-color: #fff8f0; }
    h1 { color: darkorange; }
  </style>
</head>
```

## External CSS
```html
<link rel="stylesheet" href="styles.css">
```

Put your rules in styles.css and the same file can style every page on your site.

## Which should you use?
External CSS is best for real websites because one file controls many pages. Internal CSS suits a single page. Inline CSS is for quick changes. When rules conflict, inline beats internal and external, and later rules beat earlier ones.','CSS can be inline, internal or external.
External CSS styles many pages from one file.
Inline styles take priority over other rules.','cZHp-Oozg6I',15,1,1,6,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add an internal style element to a page.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create styles.css and link it.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why external CSS is best for larger sites.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=cZHp-Oozg6I'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML and CSS inline internal external tutorial','https://www.youtube.com/results?search_query=HTML+and+CSS+inline+internal+external+tutorial'),(@lesson,'W3Schools reference: HTML and CSS','https://www.w3schools.com/html/html_css.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML and CSS','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element links an external stylesheet?','A link element in the head connects an external CSS file.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<link>',1,0),(@q,'<style>',0,1),(@q,'<css>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where does internal CSS go?','Internal CSS lives in a style element in the head.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Inside a style element in the head',1,0),(@q,'Inside the body only',0,1),(@q,'In the title',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','One external stylesheet can style several pages.','This is the main advantage of external CSS.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which CSS takes priority when rules conflict?','Inline styles override other normal rules.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Inline CSS',1,0),(@q,'Browser defaults',0,1),(@q,'External CSS',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Three ways to style','Apply CSS in all three ways and compare.','Create a page and style it with an external stylesheet (styles.css) for body colours, an internal style element for the headings and an inline style for one paragraph.
Write two sentences explaining which method you would use for a full website and why.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use inline, internal and external CSS',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'All three methods used correctly',50),(@assign,'Files linked and working',30),(@assign,'Explanation of choice',20);
SET @prev_stage=@stage;

-- ===== STAGE 3: Links, Images, Tables and Lists =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Links, Images, Tables and Lists','Connect pages and present images, data and lists.',2);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Links, Images, Tables and Lists',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Links, Images, Tables and Lists');

-- Lesson 12: HTML Links
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Links','Create links between pages and to other sites.','Link two of your own pages together.
Add one external link that opens in a new tab.
Create a link that jumps to a heading with an id.','## The a element
Links are made with the a (anchor) element and the href attribute.

```html
<a href="https://www.example.com">Visit Example</a>
<a href="about.html">About me</a>
<a href="mailto:you@example.com">Email me</a>
```

## Absolute and relative addresses
An absolute address contains the full URL, including https. A relative address points to a file in your own site, such as about.html.

## Opening in a new tab
```html
<a href="https://www.example.com" target="_blank" rel="noopener">Open in a new tab</a>
```

## Links inside a page
Give an element an id, then link to it with a hash.

```html
<h2 id="contact">Contact</h2>
<a href="#contact">Jump to contact</a>
```

Write link text that makes sense by itself, such as Read the guide, not Click here.','Use a with href to create a link.
Relative links point to your own files.
Use descriptive link text.','HA6bByKdAQM',15,1,1,0,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Link two of your own pages together.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add one external link that opens in a new tab.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a link that jumps to a heading with an id.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=HA6bByKdAQM'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML links anchor tag href target tutorial','https://www.youtube.com/results?search_query=HTML+links+anchor+tag+href+target+tutorial'),(@lesson,'W3Schools reference: HTML Links','https://www.w3schools.com/html/html_links.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Links','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute holds a link''s destination?','The href attribute holds the destination.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'href',1,0),(@q,'src',0,1),(@q,'link',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute opens a link in a new tab?','target=_blank opens a new browsing context.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'target="_blank"',1,0),(@q,'open="new"',0,1),(@q,'tab="true"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which are good link text?','Descriptive text makes sense out of context.',2,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Read the HTML guide',1,0),(@q,'View my portfolio',1,1),(@q,'Click here',0,2),(@q,'Read more',0,3);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What links to a heading with id="contact" on the same page?','A hash followed by the id jumps to that element.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<a href="#contact">',1,0),(@q,'<a href="contact#">',0,1),(@q,'<a src="#contact">',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: A small linked website','Build three pages that link to each other.','Create index.html, about.html and contact.html.
Add a navigation list of links on every page, one external link that opens in a new tab and one in-page link that jumps to a section.
Use descriptive link text.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Create working links',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'All pages link correctly',50),(@assign,'External and in-page links work',30),(@assign,'Descriptive link text',20);

-- Lesson 13: HTML Images
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Images','Add images with alt text and sensible sizing.','Add an image with meaningful alt text.
Put an image in an images folder and link it correctly.
Turn an image into a link.','## The img element
```html
<img src="images/campus.jpg" alt="Students outside a library" width="600" height="400">
```

The src attribute is the file location. The alt attribute describes the image. Width and height reserve space so the page does not jump while loading.

## Describe the image
Alt text helps people who cannot see the image and appears if it fails to load. Describe the image''s purpose. For purely decorative images use alt="".

## Paths
A file in the same folder is written as photo.jpg. A file in a sub-folder is images/photo.jpg. A wrong path shows a broken image.

## Image as a link
```html
<a href="gallery.html"><img src="thumb.jpg" alt="Open the gallery"></a>
```

Only use images you made or have permission to use, and compress large photos so the page loads quickly.','img needs src and alt.
Paths must match your folders.
Compress images and use only ones you may use.','FmoYRiepmOE',15,1,1,1,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add an image with meaningful alt text.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Put an image in an images folder and link it correctly.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Turn an image into a link.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=FmoYRiepmOE'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML images img src alt width height tutorial','https://www.youtube.com/results?search_query=HTML+images+img+src+alt+width+height+tutorial'),(@lesson,'W3Schools reference: HTML Images','https://www.w3schools.com/html/html_images.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Images','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute provides alternative text?','alt provides text for the image.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'alt',1,0),(@q,'title',0,1),(@q,'text',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does src specify on an image?','src is the path or URL of the file.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The location of the image file',1,0),(@q,'The caption',0,1),(@q,'The image colour',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A decorative image can use an empty alt attribute.','alt="" tells screen readers to skip it.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What usually causes a broken image?','The browser cannot find the file.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A wrong file path or file name',1,0),(@q,'Using lowercase letters',0,1),(@q,'Adding alt text',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Photo page with alt text','Create a small gallery page with described images.','Create a page with three images stored in an images folder.
Every image needs useful alt text and a width and height.
Make one image a link to another page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use images accessibly',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Images load with correct paths',40),(@assign,'Alt text and sizes set',40),(@assign,'One linked image',20);

-- Lesson 14: HTML Tables
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Tables','Present data in rows and columns.','Build a table with a caption and header row.
Use colspan once.
Add a border with CSS.','## Table structure
```html
<table>
  <caption>Study plan</caption>
  <tr><th>Day</th><th>Topic</th></tr>
  <tr><td>Monday</td><td>HTML</td></tr>
  <tr><td>Tuesday</td><td>CSS</td></tr>
</table>
```

table is the container, tr is a row, th is a header cell and td is a data cell. The caption gives the table a title.

## Spanning cells
colspan makes a cell span several columns and rowspan makes it span several rows.

```html
<td colspan="2">Wide cell</td>
```

## Grouping and style
thead, tbody and tfoot group rows. Tables have no border by default, so add one with CSS.

```html
<style>table, th, td { border: 1px solid black; border-collapse: collapse; }</style>
```

Use tables for data, not for page layout.','Use table, tr, th and td.
colspan and rowspan merge cells.
Tables are for data, not layout.','e62D-aayveY',18,1,1,2,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build a table with a caption and header row.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use colspan once.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a border with CSS.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=e62D-aayveY'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML tables tr th td tutorial','https://www.youtube.com/results?search_query=HTML+tables+tr+th+td+tutorial'),(@lesson,'W3Schools reference: HTML Tables','https://www.w3schools.com/html/html_tables.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Tables','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element defines a table row?','tr defines a row.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<tr>',1,0),(@q,'<td>',0,1),(@q,'<th>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element defines a header cell?','th is a header cell.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<th>',1,0),(@q,'<td>',0,1),(@q,'<caption>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute makes a cell span two columns?','colspan merges cells across columns.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'colspan="2"',1,0),(@q,'rowspan="2"',0,1),(@q,'span="2"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Tables should be used to lay out whole pages.','Use tables for data and CSS for layout.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Timetable table','Create a weekly timetable as an HTML table.','Create a table with a caption, a header row and at least four data rows.
Use colspan or rowspan once.
Add borders with CSS.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Build a data table',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Correct table structure',50),(@assign,'Colspan or rowspan used',30),(@assign,'Borders and readability',20);

-- Lesson 15: HTML Lists
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Lists','Create unordered, ordered and description lists.','Create one ul and one ol.
Make a nested list.
Create a description list with two terms.','## Unordered and ordered lists
```html
<ul>
  <li>HTML</li>
  <li>CSS</li>
</ul>
<ol>
  <li>Plan</li>
  <li>Build</li>
</ol>
```

Use ul when order does not matter and ol when it does. Every item goes inside li.

## Ordered list options
```html
<ol type="A" start="3">
  <li>Third item shown as C</li>
</ol>
```

## Description lists
```html
<dl>
  <dt>HTML</dt>
  <dd>The language that structures web pages.</dd>
</dl>
```

## Nested lists
You can place a list inside an li to make sub-items. Lists are also the standard way to build navigation menus.','ul is unordered and ol is ordered.
Every item goes in li.
dl, dt and dd make description lists.','-QuK8taGLCs',12,1,1,3,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create one ul and one ol.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Make a nested list.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a description list with two terms.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=-QuK8taGLCs'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML lists ul ol dl tutorial','https://www.youtube.com/results?search_query=HTML+lists+ul+ol+dl+tutorial'),(@lesson,'W3Schools reference: HTML Lists','https://www.w3schools.com/html/html_lists.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Lists','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element creates a numbered list?','ol is an ordered list.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<ol>',1,0),(@q,'<ul>',0,1),(@q,'<dl>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element holds a single list item?','li holds one list item.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<li>',1,0),(@q,'<item>',0,1),(@q,'<dd>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which elements make a description list?','dl wraps terms (dt) and descriptions (dd).',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<dl>, <dt> and <dd>',1,0),(@q,'<ul> and <li>',0,1),(@q,'<table> and <tr>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Lists can be nested inside list items.','Place a new list inside an li for sub-items.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Lists page','Create a page that uses all three list types.','Make a page with a shopping list (ul), a set of steps (ol) and a glossary of three terms (dl).
Nest at least one list inside another.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use HTML lists',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'All three list types',50),(@assign,'A nested list',30),(@assign,'Correct list structure',20);
SET @prev_stage=@stage;

-- ===== STAGE 4: Structure, Identity and Embedding =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Structure, Identity and Embedding','Understand block and inline elements, classes, ids, iframes, scripts and the head element.',3);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Structure, Identity and Embedding',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Structure, Identity and Embedding');

-- Lesson 16: HTML Block and Inline Elements
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Block and Inline Elements','Know which elements take a full line and which stay inline.','List three block and three inline elements.
Wrap content in a div.
Style part of a sentence with span.','## Block elements
A block element starts on a new line and takes the full width available. Examples are div, p, h1 to h6, ul, ol, li, table and form.

## Inline elements
An inline element does not start a new line and takes only the width it needs. Examples are span, a, strong, em, img and button.

## div and span
div is a generic block container and span is a generic inline container. They have no meaning of their own, but they are useful for grouping content and styling it.

```html
<div style="border:1px solid gray;">
  <p>A paragraph with a <span style="color:red;">red word</span>.</p>
</div>
```

## Tip
You can change how an element behaves with CSS display, but choose the element that matches the meaning of your content first.','Block elements take a new line and full width.
Inline elements flow within text.
div is a block container and span is an inline container.','M4n-WSkehmI',12,1,1,0,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List three block and three inline elements.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap content in a div.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Style part of a sentence with span.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=M4n-WSkehmI'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML block and inline elements div span','https://www.youtube.com/results?search_query=HTML+block+and+inline+elements+div+span'),(@lesson,'W3Schools reference: HTML Block and Inline Elements','https://www.w3schools.com/html/html_blocks.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Block and Inline Elements','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is a block-level element?','div is a block-level container.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<div>',1,0),(@q,'<span>',0,1),(@q,'<strong>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is an inline element?','span is inline.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<span>',1,0),(@q,'<p>',0,1),(@q,'<h1>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A block element normally starts on a new line.','Block elements start on a new line and fill the width.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which are inline elements?','a and em are inline; ul and table are block.',2,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<a>',1,0),(@q,'<em>',1,1),(@q,'<ul>',0,2),(@q,'<table>',0,3);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Block versus inline','Show the difference between block and inline elements.','Create a page with two div blocks, each with a border and a paragraph.
Inside the paragraphs use span to colour some words and use a, strong and em inline.
Write two sentences on how block and inline behaved differently.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use block and inline elements',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Blocks and inlines used correctly',50),(@assign,'Visible styling differences',30),(@assign,'Clear explanation',20);

-- Lesson 17: HTML Class Attribute
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Class Attribute','Group elements with classes so they can share styles.','Give three elements the same class.
Style that class with one CSS rule.
Give one element two classes.','## Giving elements a class
The class attribute names a group. Many elements can share the same class, and one element can have several classes.

```html
<h2 class="city">London</h2>
<p class="city note">Large and busy.</p>
```

## Styling a class
In CSS, a class selector starts with a dot.

```html
<style>
  .city { background-color: lightyellow; padding: 8px; }
  .note { font-style: italic; }
</style>
```

## Naming classes
Use lowercase names that describe purpose, such as card or warning, rather than appearance, such as red-text. JavaScript can also find every element with a class.','class groups elements that share styling.
A class selector starts with a dot.
Name classes by purpose.','tWIkDOJo0Ts',12,1,1,1,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Give three elements the same class.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Style that class with one CSS rule.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Give one element two classes.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=tWIkDOJo0Ts'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML class attribute CSS selector tutorial','https://www.youtube.com/results?search_query=HTML+class+attribute+CSS+selector+tutorial'),(@lesson,'W3Schools reference: HTML Class Attribute','https://www.w3schools.com/html/html_classes.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Class Attribute','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you select a class named note in CSS?','Class selectors start with a dot.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'.note',1,0),(@q,'#note',0,1),(@q,'note()',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Several elements can share the same class.','That is the purpose of a class.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An element can have more than one class.','Separate class names with a space.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is the better class name?','Describe purpose so you can restyle later.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'warning',1,0),(@q,'big-red-text',0,1),(@q,'thing1',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Cards with classes','Style a set of cards using shared classes.','Create three card-like div elements with the class card.
Give one of them a second class called featured.
Write CSS rules for .card and .featured in a style element.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use class selectors',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Shared class applied',40),(@assign,'Two classes on one element',30),(@assign,'CSS rules work',30);

-- Lesson 18: HTML Id Attribute
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Id Attribute','Use ids for unique elements and in-page links.','Give a heading an id.
Create a link that jumps to it.
Explain when to choose class or id.','## A unique name
The id attribute gives one element a unique name. No two elements on a page may share an id.

```html
<h1 id="top">My page</h1>
```

## Styling with an id
In CSS, an id selector starts with a hash.

```html
<style>#top { color: darkorange; }</style>
```

## Bookmarks
You can link to an element with an id.

```html
<a href="#top">Back to the top</a>
```

## Class versus id
Use a class for styling many elements. Use an id for one unique element, a bookmark target or something JavaScript needs to find. Ids are case sensitive and should not contain spaces.','An id must be unique on a page.
CSS selects an id with #.
Link to an id with a hash.','rZ0k516qZmc',12,1,1,2,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Give a heading an id.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a link that jumps to it.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when to choose class or id.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=rZ0k516qZmc'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML id attribute unique bookmark tutorial','https://www.youtube.com/results?search_query=HTML+id+attribute+unique+bookmark+tutorial'),(@lesson,'W3Schools reference: HTML Id Attribute','https://www.w3schools.com/html/html_id.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Id Attribute','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you select an id named top in CSS?','Id selectors start with #.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'#top',1,0),(@q,'.top',0,1),(@q,'top()',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Two elements on one page can safely share the same id.','Ids must be unique.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which link jumps to the element with id="footer"?','A hash plus the id jumps there.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<a href="#footer">',1,0),(@q,'<a href="footer">',0,1),(@q,'<a id="#footer">',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When is an id the better choice?','Ids identify a single element.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'For one unique element or a bookmark',1,0),(@q,'For styling many items',0,1),(@q,'For comments',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Long page with jump links','Build a long page with an in-page menu.','Create a page with four sections, each with a heading that has a unique id.
Add a menu at the top that jumps to each section and a Back to top link at the end of each.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use id and bookmarks',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Unique ids on all sections',40),(@assign,'Working jump links',40),(@assign,'Back to top links',20);

-- Lesson 19: HTML Iframes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Iframes','Embed another web page or video inside your page.','Embed a page with an iframe.
Add title and size attributes.
Use loading="lazy".','## What is an iframe?
An iframe displays another web page inside your page.

```html
<iframe src="https://www.example.com" title="Example website" width="600" height="400"></iframe>
```

## Always add a title
The title attribute describes the frame for screen readers. Every iframe needs one.

## Lazy loading and limits
```html
<iframe src="page.html" title="Info" loading="lazy"></iframe>
```
Adding loading="lazy" delays loading until the frame is near the screen. Some sites refuse to be embedded, and the frame stays blank in that case.

## Embedding a video
Video sites provide an embed code, which is an iframe. Only embed sources you trust and remember the embedded page controls its own content and privacy.','iframe embeds another page.
Always add a title attribute.
Some sites do not allow embedding.','qP23O70ve7k',12,1,1,3,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Embed a page with an iframe.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add title and size attributes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use loading="lazy".',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=qP23O70ve7k'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML iframe embed tutorial','https://www.youtube.com/results?search_query=HTML+iframe+embed+tutorial'),(@lesson,'W3Schools reference: HTML Iframes','https://www.w3schools.com/html/html_iframe.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Iframes','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element embeds another web page?','iframe embeds a web page inside another.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<iframe>',1,0),(@q,'<embed-page>',0,1),(@q,'<frame-set>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute should every iframe have?','title describes the frame for assistive technology.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'title',1,0),(@q,'alt',0,1),(@q,'href',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Every website allows itself to be embedded in an iframe.','Many sites block embedding.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does loading="lazy" do?','It improves initial page speed.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Delays loading until it is near the screen',1,0),(@q,'Hides the iframe',0,1),(@q,'Blocks scripts',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Embed a page','Practise embedding content with iframes.','Create a page with an iframe that shows another page from your own site and a second iframe that embeds a video from a video site using its embed code.
Give both a title and a size.
Write one sentence about why you should only embed sources you trust.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use iframes responsibly',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Both iframes work',50),(@assign,'Title and size set',30),(@assign,'Trust explanation',20);

-- Lesson 20: HTML and JavaScript
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML and JavaScript','Add simple behaviour to a page with the script element.','Add a button that changes some text.
Move the code into an external file.
Add a noscript message.','## The script element
JavaScript makes pages interactive. Add it with a script element.

```html
<p id="demo">Hello!</p>
<button onclick="changeText()">Click me</button>
<script>
  function changeText() {
    document.getElementById("demo").innerHTML = "You clicked the button.";
  }
</script>
```

## External scripts
```html
<script src="app.js"></script>
```
Keeping code in an external file lets many pages share it.

## Finding elements
document.getElementById finds an element with a matching id, and you can then change its content or style.

## No scripts?
```html
<noscript>Please enable JavaScript.</noscript>
```
The noscript content shows only when scripts are off. Place scripts at the end of the body so the page content loads first.','script adds JavaScript.
External scripts use src.
getElementById finds an element by its id.','uSgcWDkwc3U',15,1,1,4,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a button that changes some text.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Move the code into an external file.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a noscript message.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=uSgcWDkwc3U'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML and JavaScript script tag tutorial','https://www.youtube.com/results?search_query=HTML+and+JavaScript+script+tag+tutorial'),(@lesson,'W3Schools reference: HTML and JavaScript','https://www.w3schools.com/html/html_scripts.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML and JavaScript','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element contains JavaScript code?','The script element holds or links JavaScript.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<script>',1,0),(@q,'<js>',0,1),(@q,'<code-run>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute links an external script file?','Use src on the script element.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'src',1,0),(@q,'href',0,1),(@q,'link',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does document.getElementById do?','It returns the element with that id.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Finds an element by its id',1,0),(@q,'Creates a new page',0,1),(@q,'Deletes the head',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Content inside noscript shows only when scripts are disabled.','It is a fallback message.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: A clickable page','Add a small interaction to a page.','Create a page with a heading with an id and a button.
When the button is clicked, change the heading text using JavaScript.
Move the JavaScript to an external file called app.js and add a noscript message.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Add JavaScript to HTML',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Button changes the text',50),(@assign,'External script linked',30),(@assign,'Noscript message',20);

-- Lesson 21: HTML Head Element
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Head Element','Learn what belongs in the head of a page.','Add charset and viewport meta tags.
Write a unique title and description.
Link a stylesheet from the head.','## The head holds information about the page
The head is not displayed on the page. It holds metadata and links to files the page needs.

```html
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="A page about HTML.">
  <title>HTML Basics</title>
  <link rel="stylesheet" href="styles.css">
  <style>p { color: #333; }</style>
  <script src="app.js" defer></script>
</head>
```

## What each does
title appears in the tab and in search results. meta charset makes characters display correctly. The viewport meta makes pages fit phones. The description summarises the page for search results. link, style and script connect or add CSS and JavaScript.

## Tip
Give every page its own clear title and description.','Head content is not shown on the page.
title, meta, link, style and script live in head.
Use charset, viewport and description on every page.','WeuVX5x2MJE',15,1,1,5,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add charset and viewport meta tags.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write a unique title and description.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Link a stylesheet from the head.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=WeuVX5x2MJE'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML head element meta title link tutorial','https://www.youtube.com/results?search_query=HTML+head+element+meta+title+link+tutorial'),(@lesson,'W3Schools reference: HTML Head Element','https://www.w3schools.com/html/html_head.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Head Element','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element sets the text shown in the browser tab?','The title element sets the tab text.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<title>',1,0),(@q,'<header>',0,1),(@q,'<meta>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which meta tag helps pages fit mobile screens?','The viewport meta tag controls mobile scaling.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'viewport',1,0),(@q,'charset',0,1),(@q,'robots',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Content inside head is displayed in the page body.','The head holds metadata and is not displayed.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which belong in the head?','title and link belong in head; p and h1 belong in body.',2,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<title>',1,0),(@q,'<link>',1,1),(@q,'<p>',0,2),(@q,'<h1>',0,3);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Complete head section','Build a full, tidy head for a page.','Create a page whose head contains charset, viewport, a unique title, a description, a linked stylesheet and an internal style rule.
Write what each tag is for in comments.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Use the head element',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'All head elements present',50),(@assign,'Comments explain each tag',30),(@assign,'Page works in browser',20);
SET @prev_stage=@stage;

-- ===== STAGE 5: Forms and Fixing Mistakes =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Forms and Fixing Mistakes','Collect information with forms and learn to debug common mistakes.',4);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Forms and Fixing Mistakes',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Forms and Fixing Mistakes');

-- Lesson 22: HTML Forms
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTML Forms','Collect information with inputs, labels and buttons.','Build a form with four labelled fields.
Use at least three different input types.
Mark required fields with required.','## The form element
```html
<form action="/submit" method="post">
  <label for="name">Name</label>
  <input type="text" id="name" name="name" required>

  <label for="email">Email</label>
  <input type="email" id="email" name="email" required>

  <label for="topic">Topic</label>
  <select id="topic" name="topic">
    <option>HTML</option>
    <option>CSS</option>
  </select>

  <label for="msg">Message</label>
  <textarea id="msg" name="msg"></textarea>

  <button type="submit">Send</button>
</form>
```

## Key ideas
Every control needs a visible label connected with for and id. The name attribute is the key sent with the data. Input types include text, email, password, number, checkbox, radio and date. Group related options with fieldset and legend. The required attribute asks the browser to check a field is filled in. Method get puts data in the address and post sends it in the request body.','label, input, select, textarea and button are core form elements.
Use name for data and for/id for labels.
Browser validation helps but servers must check data too.','VLeERv_dR6Q',20,1,1,0,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build a form with four labelled fields.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use at least three different input types.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Mark required fields with required.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=VLeERv_dR6Q'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: HTML forms input label select textarea tutorial','https://www.youtube.com/results?search_query=HTML+forms+input+label+select+textarea+tutorial'),(@lesson,'W3Schools reference: HTML Forms','https://www.w3schools.com/html/html_forms.asp');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTML Forms','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which element connects text to an input so it is clickable?','label with a matching for/id connects them.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'<label>',1,0),(@q,'<legend>',0,1),(@q,'<span>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute names the data sent with a field?','name is the key sent to the server.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'name',1,0),(@q,'id',0,1),(@q,'for',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which input type suits email addresses?','type=email gives suitable validation and keyboard.',1,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'email',1,0),(@q,'text only',0,1),(@q,'date',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Browser validation alone is enough to keep a real website safe.','Always validate again on the server.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Contact form','Build an accessible contact form.','Create a form with name, email, a topic select, a message textarea and a submit button.
Every field needs a connected label, and name and email must be required.
Group two radio buttons using fieldset and legend.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Build a form',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Fields and labels correct',50),(@assign,'Required and grouping used',30),(@assign,'Form displays and tabs well',20);

-- Lesson 23: Bloopers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Bloopers','Spot and fix the most common HTML mistakes.','Name four common HTML mistakes.
Open developer tools on a page.
Validate one page and fix an error.','## Mistakes everyone makes
Every developer makes mistakes. The key is learning to spot them quickly.

## Common bloopers
- Forgetting to close an element, which makes later content behave strangely.
- Closing elements in the wrong order, such as <b><i>text</b></i>.
- Missing quotes or a missing equals sign in an attribute.
- Using the same id on more than one element.
- Missing alt text on images.
- Wrong file paths or capital letters that do not match the file name.
- Using tables for page layout.
- Forgetting the doctype or lang attribute.

## How to debug
Check the page after small changes. Use your browser''s developer tools (right-click and Inspect) to see the structure the browser built. Run your page through the W3C validator, which lists errors with line numbers.

## Be kind to yourself
Read errors slowly, fix one at a time and keep a copy of working code. Mistakes are how you learn.','Most errors are unclosed tags, bad nesting, wrong paths or missing quotes.
Developer tools and a validator reveal problems.
Change a little, test often.','HHxPoYUrSQ0',12,1,1,1,'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name four common HTML mistakes.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Open developer tools on a page.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Validate one page and fix an error.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=HHxPoYUrSQ0'),(@lesson,'Full HTML playlist','https://www.youtube.com/playlist?list=PLP9IO4UYNF0VdAajP_5pYG-jG2JRrG72s'),(@lesson,'Search YouTube: common HTML mistakes beginners bloopers','https://www.youtube.com/results?search_query=common+HTML+mistakes+beginners+bloopers'),(@lesson,'MDN HTML reference','https://developer.mozilla.org/en-US/docs/Web/HTML');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Bloopers','Check what you learned in this lesson. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which tool lists HTML errors with line numbers?','A validator checks markup against the rules.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'An HTML validator',1,0),(@q,'A spell checker',0,1),(@q,'A photo editor',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is wrong with <b><i>text</b></i>?','Inner elements must close first.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The elements are closed in the wrong order',1,0),(@q,'Nothing',0,1),(@q,'The text is too short',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which are common mistakes?','Missing alt and duplicate ids are common errors.',2,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Missing alt text',1,0),(@q,'Duplicate ids',1,1),(@q,'Closing every element',0,2),(@q,'Using lowercase tags',0,3);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Mistakes are a normal part of learning to code.','Debugging is a core skill.',1,3);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Find and fix the bugs','Debug a page that contains deliberate mistakes.','Create a page that contains at least five deliberate mistakes (for example an unclosed tag, bad nesting, a missing alt, a duplicate id and a wrong file path).
Then fix them, using a validator and developer tools.
Submit the fixed page and list each mistake and how you found it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Debug HTML',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Five mistakes identified and fixed',50),(@assign,'Validator and tools used',30),(@assign,'Clear explanation of each fix',20);
SET @prev_stage=@stage;

COMMIT;
SELECT 'HTML for Beginners installed' AS result,(SELECT COUNT(*) FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=@path) AS lessons,(SELECT COUNT(*) FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE s.path_id=@path) AS quizzes,(SELECT COUNT(*) FROM assignments a JOIN stages s ON s.id=a.stage_id WHERE s.path_id=@path) AS assignments;
