-- Next.js 15 for Beginners: 92 video lessons + final project briefing, 93 quizzes, 92 practice assignments and 2 final projects.
-- Built from the Codevolution "Next.js 15 Tutorial" videos you provided.
-- Run in phpMyAdmin with YOUR database selected. Run it once.
-- To reinstall later, first run:  DELETE FROM learning_paths WHERE slug='nextjs-for-beginners';  (this also deletes enrolments and progress for the course)
START TRANSACTION;
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Web Development','web-development','Build useful things for the web.','code','orange',1);
SET @cat=(SELECT id FROM categories WHERE slug='web-development');
INSERT INTO learning_paths(category_id,title,slug,description,objectives,difficulty,status,certificate_enabled,certificate_min_score) VALUES(@cat,'Next.js 15 for Beginners', 'nextjs-for-beginners', 'Learn the Next.js 15 App Router from the ground up. Follow 92 short video lessons covering routing, dynamic and nested routes, layouts, metadata, navigation, loading and error handling, parallel and intercepting routes, route handlers, middleware, rendering strategies, server and client components, data fetching, server actions and forms, Clerk authentication and deployment. Pass a quiz after every lesson, practise with an assignment and finish with a full-stack project.', 'Build routes with the App Router, including dynamic, nested and catch-all segments
Share UI with layouts, templates, loading and error boundaries
Add metadata and navigate with the Link component and the router
Write route handlers and protect routes with middleware
Choose between static, dynamic, streamed, server and client rendering
Fetch and mutate data with server components, server actions and forms
Add authentication and role-based access with Clerk
Deploy a production-ready Next.js application to Vercel', 'intermediate', 'published', 1, 60);
SET @path=LAST_INSERT_ID();
SET @prev_stage=NULL;

-- ===== STAGE 1: Getting Started =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Getting Started','Create your first Next.js 15 application and understand routing basics.',0);
SET @stage=LAST_INSERT_ID();
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Getting Started',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Getting Started');

-- Lesson 1: Introduction
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Introduction', 'Understand what Next.js is and why it is used for React applications.', 'Explain what Next.js adds to React.
Name the main features covered in the course.
Create the project with create-next-app.', '## What this lesson covers

Understand what Next.js is and why it is used for React applications.

- Next.js is a React framework that adds routing, rendering choices and backend features.
- The App Router placed in the app folder is the modern routing system.
- Next.js supports server components, route handlers, middleware and built-in optimisations.

## Key code
```bash
npx create-next-app@latest my-app
cd my-app
npm run dev
```

## Practice
Create a brand new Next.js project with create-next-app using the App Router and TypeScript, run it, and screenshot the default page in the browser.', 'Next.js is a React framework that adds routing, rendering choices and backend features.
The App Router placed in the app folder is the modern routing system.
Next.js supports server components, route handlers, middleware and built-in optimisations.', 'b4ba60j_4o8', 4, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what Next.js adds to React.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name the main features covered in the course.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create the project with create-next-app.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=b4ba60j_4o8'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Introduction','https://www.youtube.com/results?search_query=Introduction'),(@lesson,'Next.js docs: Installation','https://nextjs.org/docs/app/getting-started/installation');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Introduction','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does Next.js add to React?','Next.js is a framework built on top of React.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Routing, rendering options and backend features',1,0),(@q,'A new JavaScript syntax',0,1),(@q,'A database engine',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The app folder belongs to the App Router.','The app directory is the App Router convention in Next.js 13 and later.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Introduction','Practise: Understand what Next.js is and why it is used for React applications','Create a brand new Next.js project with create-next-app using the App Router and TypeScript, run it, and screenshot the default page in the browser.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Introduction: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 2: Hello World
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Hello World', 'Render your first page component in the app router.', 'Create or edit app/page.tsx.
Return JSX from a page component.
See the page update in the browser.', '## What this lesson covers

Render your first page component in the app router.

- Each folder in app can expose a page through a page file.
- app/page.tsx is the page for the root route.
- Editing the file triggers a hot reload in the browser.

## Key code
```tsx
export default function Home() {
  return (
    <main className="p-10">
      <h1 className="text-3xl font-bold">Hello Next.js</h1>
      <p className="mt-2 text-gray-600">My first route.</p>
    </main>
  );
}
```

## Practice
Replace app/page.tsx with a component that returns a heading and a paragraph about yourself. Add a style with Tailwind classes and screenshot the result.', 'Each folder in app can expose a page through a page file.
app/page.tsx is the page for the root route.
Editing the file triggers a hot reload in the browser.', 'xiSuX0f1mEI', 3, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create or edit app/page.tsx.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return JSX from a page component.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'See the page update in the browser.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=xiSuX0f1mEI'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Hello World','https://www.youtube.com/results?search_query=Hello+World'),(@lesson,'Next.js docs: Pages','https://nextjs.org/docs/app/api-reference/file-conventions/page');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Hello World','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which file renders the root route of an App Router project?','page.tsx inside app maps to the root route.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'app/page.tsx',1,0),(@q,'app/index.tsx',0,1),(@q,'pages/home.tsx',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A page component must be the default export.','Next.js imports the default export of page files.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Hello World','Practise: Render your first page component in the app router','Replace app/page.tsx with a component that returns a heading and a paragraph about yourself. Add a style with Tailwind classes and screenshot the result.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Hello World: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 3: Project Structure
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Project Structure', 'Understand the folders and files that create-next-app generates.', 'Identify the app folder and its special files.
Explain what layout.tsx and page.tsx do.
Know where public assets and config files live.', '## What this lesson covers

Understand the folders and files that create-next-app generates.

- app holds routes, layouts, loading and error files.
- public holds static assets served from the root URL.
- next.config and tsconfig control framework and language settings.

## Practice
Explore the generated project and write down what each important file does: layout.tsx, page.tsx, globals.css, next.config, tsconfig.json and the public folder.', 'app holds routes, layouts, loading and error files.
public holds static assets served from the root URL.
next.config and tsconfig control framework and language settings.', 'L0g87N0piT0', 4, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Identify the app folder and its special files.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what layout.tsx and page.tsx do.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know where public assets and config files live.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=L0g87N0piT0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Project Structure','https://www.youtube.com/results?search_query=Project+Structure'),(@lesson,'Next.js docs: Project structure','https://nextjs.org/docs/app/getting-started/project-structure');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Project Structure','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where do static images and files live so they can be served directly?','Files in public are served from the site root.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The public folder',1,0),(@q,'The app folder',0,1),(@q,'The node_modules folder',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which file wraps every page with shared markup?','A layout wraps the pages beneath it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'layout.tsx',1,0),(@q,'page.tsx',0,1),(@q,'template.tsx',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Project Structure','Practise: Understand the folders and files that create-next-app generates','Explore the generated project and write down what each important file does: layout.tsx, page.tsx, globals.css, next.config, tsconfig.json and the public folder.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Project Structure: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 4: Before We Start
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Before We Start', 'Prepare the workspace and remove the default starter content.', 'Delete unused starter code.
Keep a clean layout and globals.css.
Confirm the dev server runs without errors.', '## What this lesson covers

Prepare the workspace and remove the default starter content.

- A clean starting point makes each lesson easier to follow.
- Keep layout.tsx, page.tsx and globals.css; remove demo components you do not need.
- Read terminal errors as they appear; they usually name the file and line.

## Practice
Strip the starter page down to an empty main element, remove unused demo files and confirm the browser shows an empty page with no console errors.', 'A clean starting point makes each lesson easier to follow.
Keep layout.tsx, page.tsx and globals.css; remove demo components you do not need.
Read terminal errors as they appear; they usually name the file and line.', '7DC3ZrxvUUU', 2, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Delete unused starter code.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep a clean layout and globals.css.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Confirm the dev server runs without errors.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7DC3ZrxvUUU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Before We Start','https://www.youtube.com/results?search_query=Before+We+Start'),(@lesson,'Next.js docs: Layouts and pages','https://nextjs.org/docs/app/getting-started/layouts-and-pages');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Before We Start','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why do we clear the starter content?','A clean project avoids confusion when adding routes.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'So each lesson starts from a known, clean state',1,0),(@q,'Because Next.js requires it',0,1),(@q,'To make the build slower',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Unused starter files make the project harder to follow.','Removing them keeps the structure readable.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Before We Start','Practise: Prepare the workspace and remove the default starter content','Strip the starter page down to an empty main element, remove unused demo files and confirm the browser shows an empty page with no console errors.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Before We Start: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 5: Routing
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Routing', 'Create routes by adding folders and page files.', 'Create an about route with a folder and page file.
Visit the route in the browser.
Explain file-system routing.', '## What this lesson covers

Create routes by adding folders and page files.

- A folder inside app becomes a URL segment.
- The folder needs a page file for the segment to be visitable.
- Routes are defined by your files, so there is no route config file.

## Key code
```text
app/
  page.tsx          -> /
  about/page.tsx    -> /about
  contact/page.tsx  -> /contact
```

## Practice
Create routes for /about, /contact and /blog, each with a page file and a heading. Visit all three and screenshot one of them.', 'A folder inside app becomes a URL segment.
The folder needs a page file for the segment to be visitable.
Routes are defined by your files, so there is no route config file.', '9602Yzvd7ik', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create an about route with a folder and page file.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Visit the route in the browser.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain file-system routing.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=9602Yzvd7ik'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Routing','https://www.youtube.com/results?search_query=Routing'),(@lesson,'Next.js docs: Linking and navigating','https://nextjs.org/docs/app/getting-started/linking-and-navigating');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Routing','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What turns a folder inside app into a working route?','Folders without a page file are not routes.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A page file inside it',1,0),(@q,'An index.html file',0,1),(@q,'An entry in a routes array',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Next.js requires you to register routes in a config file.','Routes come from the file system.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Routing','Practise: Create routes by adding folders and page files','Create routes for /about, /contact and /blog, each with a page file and a heading. Visit all three and screenshot one of them.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Routing: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 6: Nested Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Nested Routes', 'Create nested URL segments with folders inside folders.', 'Create a nested route inside a parent segment.
Visit the nested URL directly.
Explain how folder nesting becomes URL nesting.', '## What this lesson covers

Create nested URL segments with folders inside folders.

- Nested folders create nested URL paths.
- Only the leaf folder needs a page file.
- Each segment can add its own layout around its children.

## Practice
Create /blog and /blog/first-post as nested folders with pages, then link from the blog page to the post page.', 'Nested folders create nested URL paths.
Only the leaf folder needs a page file.
Each segment can add its own layout around its children.', 'H7JjKjkC33c', 3, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a nested route inside a parent segment.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Visit the nested URL directly.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain how folder nesting becomes URL nesting.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=H7JjKjkC33c'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Nested Routes','https://www.youtube.com/results?search_query=Nested+Routes'),(@lesson,'Next.js docs: Nested routes','https://nextjs.org/docs/app/getting-started/layouts-and-pages');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Nested Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which URL does app/blog/first-post/page.tsx serve?','Folder nesting mirrors the URL segments.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'/blog/first-post',1,0),(@q,'/first-post',0,1),(@q,'/blog?post=first',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Every folder in a nested path needs its own page file.','Only the folder whose URL you want to visit needs a page file.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Nested Routes','Practise: Create nested URL segments with folders inside folders','Create /blog and /blog/first-post as nested folders with pages, then link from the blog page to the post page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Nested Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 2: Dynamic and Advanced Routing =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Dynamic and Advanced Routing','Dynamic segments, catch-all routes, not found pages and route groups.',1);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Dynamic and Advanced Routing',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Dynamic and Advanced Routing');

-- Lesson 7: Dynamic Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Dynamic Routes', 'Create routes from URL parameters using dynamic segments.', 'Create a dynamic segment with square brackets.
Read the route parameter in the page.
Use params asynchronously in Next.js 15.', '## What this lesson covers

Create routes from URL parameters using dynamic segments.

- A folder named [id] matches any value in that position.
- In Next.js 15 params is a promise, so the page is an async function that awaits it.
- Dynamic routes are ideal for product, post and profile pages.

## Key code
```tsx
export default async function ProductPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  return <h1>Product {id}</h1>;
}
```

## Practice
Create /products/[id] and display the id on the page by awaiting params. Visit three different ids and screenshot one.', 'A folder named [id] matches any value in that position.
In Next.js 15 params is a promise, so the page is an async function that awaits it.
Dynamic routes are ideal for product, post and profile pages.', 'k9g6aVLH3p4', 6, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a dynamic segment with square brackets.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the route parameter in the page.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use params asynchronously in Next.js 15.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=k9g6aVLH3p4'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Dynamic Routes','https://www.youtube.com/results?search_query=Dynamic+Routes'),(@lesson,'Next.js docs: Dynamic segments','https://nextjs.org/docs/app/api-reference/file-conventions/dynamic-routes');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Dynamic Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which folder name creates a dynamic segment?','Square brackets mark a dynamic segment.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'[id]',1,0),(@q,'{id}',0,1),(@q,':id',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','In Next.js 15, params is a promise you await.','Next.js 15 made params and searchParams asynchronous.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Dynamic Routes','Practise: Create routes from URL parameters using dynamic segments','Create /products/[id] and display the id on the page by awaiting params. Visit three different ids and screenshot one.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Dynamic Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 8: Nested Dynamic Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Nested Dynamic Routes', 'Combine several dynamic segments in one path.', 'Create two dynamic segments in a path.
Read both parameters.
Handle a wrong combination gracefully.', '## What this lesson covers

Combine several dynamic segments in one path.

- A path can contain more than one dynamic segment, such as [category]/[productId].
- Every segment appears as a key in the params object.
- Validate the values and call notFound when they do not exist.

## Key code
```tsx
export default async function Page({ params }: { params: Promise<{ category: string; product: string }> }) {
  const { category, product } = await params;
  return <p>{category} / {product}</p>;
}
```

## Practice
Create /shop/[category]/[product] and show both values. Add a check that calls notFound when the category is not one of three allowed values.', 'A path can contain more than one dynamic segment, such as [category]/[productId].
Every segment appears as a key in the params object.
Validate the values and call notFound when they do not exist.', 'edrJf0GKfAI', 4, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create two dynamic segments in a path.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read both parameters.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Handle a wrong combination gracefully.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=edrJf0GKfAI'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Nested Dynamic Routes','https://www.youtube.com/results?search_query=Nested+Dynamic+Routes'),(@lesson,'Next.js docs: Dynamic routes','https://nextjs.org/docs/app/api-reference/file-conventions/dynamic-routes');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Nested Dynamic Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you read the second dynamic segment?','Each dynamic folder name becomes a key in params.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'From the params object by its folder name',1,0),(@q,'From window.location only',0,1),(@q,'From a global variable',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A path may contain more than one dynamic segment.','Multiple bracket folders can appear in one route.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Nested Dynamic Routes','Practise: Combine several dynamic segments in one path','Create /shop/[category]/[product] and show both values. Add a check that calls notFound when the category is not one of three allowed values.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Nested Dynamic Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 9: Catch all Segments
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Catch all Segments', 'Match any number of segments with catch-all and optional catch-all routes.', 'Create a catch-all segment with [...slug].
Read the slug array.
Compare catch-all with optional catch-all.', '## What this lesson covers

Match any number of segments with catch-all and optional catch-all routes.

- [...slug] matches one or more segments and returns an array.
- [[...slug]] also matches the parent path with no extra segments.
- Catch-all routes suit documentation and category paths of unknown depth.

## Key code
```tsx
export default async function Docs({ params }: { params: Promise<{ slug: string[] }> }) {
  const { slug } = await params;
  return <p>Path: {slug.join(" / ")}</p>;
}
```

## Practice
Build /docs/[...slug] that shows the full path from the slug array. Test /docs/a, /docs/a/b and compare with an optional catch-all version.', '[...slug] matches one or more segments and returns an array.
[[...slug]] also matches the parent path with no extra segments.
Catch-all routes suit documentation and category paths of unknown depth.', 'd46hLIg1B3Q', 6, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a catch-all segment with [...slug].',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the slug array.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Compare catch-all with optional catch-all.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=d46hLIg1B3Q'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Catch all Segments','https://www.youtube.com/results?search_query=Catch+all+Segments'),(@lesson,'Next.js docs: Catch-all segments','https://nextjs.org/docs/app/api-reference/file-conventions/dynamic-routes');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Catch all Segments','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What type is the slug value in a catch-all route?','Catch-all segments collect the remaining path into an array.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'An array of path segments',1,0),(@q,'A single string',0,1),(@q,'A number',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which name also matches the parent path with no extra segments?','Double brackets make the catch-all optional.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'[[...slug]]',1,0),(@q,'[...slug]',0,1),(@q,'[slug]',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Catch all Segments','Practise: Match any number of segments with catch-all and optional catch-all routes','Build /docs/[...slug] that shows the full path from the slug array. Test /docs/a, /docs/a/b and compare with an optional catch-all version.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Catch all Segments: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 10: Not Found Page
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Not Found Page', 'Handle missing content with the not-found file and the notFound function.', 'Create a custom not-found page.
Trigger it with the notFound function.
Style the page with helpful links.', '## What this lesson covers

Handle missing content with the not-found file and the notFound function.

- A not-found.tsx file provides the UI for unresolved routes.
- Calling notFound() from a page or data function renders that UI.
- The page should tell the visitor what happened and offer a way back.

## Practice
Create app/not-found.tsx with a heading, a short explanation and a link home. Trigger it from a product page when the id is not in your list.', 'A not-found.tsx file provides the UI for unresolved routes.
Calling notFound() from a page or data function renders that UI.
The page should tell the visitor what happened and offer a way back.', 'GCipVDqBD3k', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a custom not-found page.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Trigger it with the notFound function.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Style the page with helpful links.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=GCipVDqBD3k'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Not Found Page','https://www.youtube.com/results?search_query=Not+Found+Page'),(@lesson,'Next.js docs: not-found file','https://nextjs.org/docs/app/api-reference/file-conventions/not-found');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Not Found Page','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which function renders the nearest not-found page?','notFound throws the not-found boundary.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'notFound()',1,0),(@q,'error()',0,1),(@q,'redirect()',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A custom not-found page can include links back to useful pages.','Good empty states guide the visitor onward.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Not Found Page','Practise: Handle missing content with the not-found file and the notFound function','Create app/not-found.tsx with a heading, a short explanation and a link home. Trigger it from a product page when the id is not in your list.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Not Found Page: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 11: File Colocation
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'File Colocation', 'Understand which files become routes and which are just colocated code.', 'Place helper files safely inside route folders.
Explain why colocation is safe.
Use a components folder for shared UI.', '## What this lesson covers

Understand which files become routes and which are just colocated code.

- Only special file names such as page and layout are routable.
- Other files in a route folder are colocated code and cannot be visited.
- Colocation keeps related code together without leaking routes.

## Practice
Create a route folder that contains a page file plus a helper component and a data file. Import them into the page and confirm neither extra file is a route.', 'Only special file names such as page and layout are routable.
Other files in a route folder are colocated code and cannot be visited.
Colocation keeps related code together without leaking routes.', 'fpOinVG85Pk', 3, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Place helper files safely inside route folders.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why colocation is safe.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use a components folder for shared UI.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=fpOinVG85Pk'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: File Colocation','https://www.youtube.com/results?search_query=File+Colocation'),(@lesson,'Next.js docs: Colocation','https://nextjs.org/docs/app/getting-started/project-structure');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: File Colocation','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why is it safe to add extra files inside a route folder?','Routing only reacts to reserved file names.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Only special file names become routes',1,0),(@q,'Next.js ignores all folders',0,1),(@q,'Extra files are deleted at build',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A file named utils.ts inside a route folder creates the /utils route.','Only reserved names such as page.tsx create routes.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: File Colocation','Practise: Understand which files become routes and which are just colocated code','Create a route folder that contains a page file plus a helper component and a data file. Import them into the page and confirm neither extra file is a route.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','File Colocation: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 12: Private Folders
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Private Folders', 'Exclude folders from routing with a leading underscore.', 'Name a folder with a leading underscore.
Confirm it creates no route.
Use private folders for internal structure.', '## What this lesson covers

Exclude folders from routing with a leading underscore.

- A folder named _components is excluded from the router.
- Private folders keep UI and helpers out of the URL space.
- They are useful for organising route-specific sections.

## Practice
Create app/_components with a Button component, use it in a page and confirm that visiting /_components returns a not-found page.', 'A folder named _components is excluded from the router.
Private folders keep UI and helpers out of the URL space.
They are useful for organising route-specific sections.', 'nJjs3wrji5s', 3, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name a folder with a leading underscore.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Confirm it creates no route.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use private folders for internal structure.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=nJjs3wrji5s'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Private Folders','https://www.youtube.com/results?search_query=Private+Folders'),(@lesson,'Next.js docs: Private folders','https://nextjs.org/docs/app/getting-started/project-structure#private-folders');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Private Folders','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which folder name is excluded from routing?','A leading underscore makes a folder private.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'_components',1,0),(@q,'components',0,1),(@q,'(components)',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Route groups and private folders do the same job.','Route groups keep the route but drop the URL segment; private folders create no route at all.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Private Folders','Practise: Exclude folders from routing with a leading underscore','Create app/_components with a Button component, use it in a page and confirm that visiting /_components returns a not-found page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Private Folders: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 13: Route Groups
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Route Groups', 'Organise routes without adding a URL segment.', 'Wrap folders in a route group.
Confirm the URL does not change.
Give a section its own layout through a group.', '## What this lesson covers

Organise routes without adding a URL segment.

- A folder in brackets such as (marketing) is a route group.
- Route groups do not appear in the URL.
- Route groups let different sections use different layouts.

## Practice
Create (marketing) and (shop) groups with one page each, then confirm the URLs are / and /shop with no group name in the address bar.', 'A folder in brackets such as (marketing) is a route group.
Route groups do not appear in the URL.
Route groups let different sections use different layouts.', 'auXXk38rGgk', 4, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap folders in a route group.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Confirm the URL does not change.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Give a section its own layout through a group.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=auXXk38rGgk'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Route Groups','https://www.youtube.com/results?search_query=Route+Groups'),(@lesson,'Next.js docs: Route groups','https://nextjs.org/docs/app/api-reference/file-conventions/route-groups');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Route Groups','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What appears in the URL for app/(marketing)/about/page.tsx?','Route groups are removed from the URL.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'/about',1,0),(@q,'/(marketing)/about',0,1),(@q,'/marketing/about',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Route groups let two sections use different layouts.','Each group can hold its own layout file.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Route Groups','Practise: Organise routes without adding a URL segment','Create (marketing) and (shop) groups with one page each, then confirm the URLs are / and /shop with no group name in the address bar.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Route Groups: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 3: Layouts and Metadata =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Layouts and Metadata','Share UI between pages, add metadata and navigate with links.',2);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Layouts and Metadata',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Layouts and Metadata');

-- Lesson 14: Layouts
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Layouts', 'Wrap pages in shared UI with a layout file.', 'Create a root layout with html and body tags.
Add shared navigation and footer.
Keep the layout around every page.', '## What this lesson covers

Wrap pages in shared UI with a layout file.

- The root layout must render html and body.
- Layouts keep their state and do not re-render on navigation.
- Shared headers and footers belong in the layout.

## Practice
Add a header with two links and a footer to the root layout. Navigate between pages and confirm the header stays in place without a reload.', 'The root layout must render html and body.
Layouts keep their state and do not re-render on navigation.
Shared headers and footers belong in the layout.', 'NK-8a8EzWrU', 5, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a root layout with html and body tags.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add shared navigation and footer.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the layout around every page.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=NK-8a8EzWrU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Layouts','https://www.youtube.com/results?search_query=Layouts'),(@lesson,'Next.js docs: layout file','https://nextjs.org/docs/app/api-reference/file-conventions/layout');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Layouts','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where do the html and body tags belong?','The root layout owns the document shell.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The root layout',1,0),(@q,'Every page',0,1),(@q,'The globals stylesheet',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A layout re-renders from scratch on every navigation.','Layouts persist across navigation, which keeps their state.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Layouts','Practise: Wrap pages in shared UI with a layout file','Add a header with two links and a footer to the root layout. Navigate between pages and confirm the header stays in place without a reload.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Layouts: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 15: Nested Layouts
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Nested Layouts', 'Add layouts for a section of the site.', 'Create a layout inside a nested folder.
Explain how layouts wrap each other.
Share section-only UI.', '## What this lesson covers

Add layouts for a section of the site.

- Layouts nest from the root outward, wrapping the page like layers.
- A layout only wraps the routes in its own folder and below.
- A sidebar for a dashboard is a typical nested layout.

## Key code
```tsx
// app/dashboard/layout.tsx
export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex gap-6">
      <aside className="w-56">Sidebar</aside>
      <section className="flex-1">{children}</section>
    </div>
  );
}
```

## Practice
Create a dashboard section with its own sidebar layout inside app/dashboard, keeping the root header above it.', 'Layouts nest from the root outward, wrapping the page like layers.
A layout only wraps the routes in its own folder and below.
A sidebar for a dashboard is a typical nested layout.', 'TzF2RKFjRyk', 4, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a layout inside a nested folder.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain how layouts wrap each other.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Share section-only UI.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=TzF2RKFjRyk'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Nested Layouts','https://www.youtube.com/results?search_query=Nested+Layouts'),(@lesson,'Next.js docs: Nesting layouts','https://nextjs.org/docs/app/getting-started/layouts-and-pages');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Nested Layouts','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which routes does app/dashboard/layout.tsx wrap?','A layout applies to its folder and everything below.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Only routes inside app/dashboard',1,0),(@q,'Every route in the app',0,1),(@q,'Only the dashboard root page',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Nested layouts render inside the layouts above them.','Layouts stack from root to leaf.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Nested Layouts','Practise: Add layouts for a section of the site','Create a dashboard section with its own sidebar layout inside app/dashboard, keeping the root header above it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Nested Layouts: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 16: Multiple Root Layouts
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Multiple Root Layouts', 'Use route groups to give different areas separate root layouts.', 'Create two route groups.
Give each group its own root layout.
Explain when this pattern helps.', '## What this lesson covers

Use route groups to give different areas separate root layouts.

- Each group can hold its own layout with html and body tags.
- Pages must not sit above the groups, because every page needs one root layout.
- Marketing and admin sections often need completely different shells.

## Practice
Create (marketing) and (app) groups with separate root layouts, one with a public header and one with an app sidebar. Browse both and screenshot each.', 'Each group can hold its own layout with html and body tags.
Pages must not sit above the groups, because every page needs one root layout.
Marketing and admin sections often need completely different shells.', 'KZC6TRG3Mks', 3, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create two route groups.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Give each group its own root layout.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when this pattern helps.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=KZC6TRG3Mks'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Multiple Root Layouts','https://www.youtube.com/results?search_query=Multiple+Root+Layouts'),(@lesson,'Next.js docs: Creating multiple root layouts','https://nextjs.org/docs/app/api-reference/file-conventions/route-groups#creating-multiple-root-layouts');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Multiple Root Layouts','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why must groups with their own root layouts sit at the top of app?','Pages outside the groups would have no root layout.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Every page needs exactly one root layout above it',1,0),(@q,'Because folders in brackets must be first',0,1),(@q,'Because the compiler requires it',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Two root layouts can exist in one project when they live in separate route groups.','Route groups make multiple root layouts possible.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Multiple Root Layouts','Practise: Use route groups to give different areas separate root layouts','Create (marketing) and (app) groups with separate root layouts, one with a public header and one with an app sidebar. Browse both and screenshot each.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Multiple Root Layouts: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 17: Routing Metadata
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Routing Metadata', 'Describe pages to browsers and search engines with the metadata export.', 'Export a metadata object from a layout or page.
Add title and description.
Understand the replace and merge behaviour.', '## What this lesson covers

Describe pages to browsers and search engines with the metadata export.

- A static metadata export sets the page title, description and social data.
- Child segments override or inherit fields depending on the object they export.
- Good metadata improves search listings and shared link previews.

## Key code
```tsx
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: { default: "Learnow", template: "%s | Learnow" },
  description: "Learn web development step by step.",
};
```

## Practice
Add a metadata export to the root layout with a title template and description, then add page-level metadata that fills in the template.', 'A static metadata export sets the page title, description and social data.
Child segments override or inherit fields depending on the object they export.
Good metadata improves search listings and shared link previews.', 'OldUurB0Wx8', 8, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Export a metadata object from a layout or page.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add title and description.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand the replace and merge behaviour.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=OldUurB0Wx8'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Routing Metadata','https://www.youtube.com/results?search_query=Routing+Metadata'),(@lesson,'Next.js docs: Metadata','https://nextjs.org/docs/app/getting-started/metadata-and-og-images');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Routing Metadata','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which export adds page metadata?','The metadata export is read by Next.js.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'export const metadata = { ... }',1,0),(@q,'export const meta = { ... }',0,1),(@q,'export function Head() {}',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Metadata from a layout is inherited by pages below it.','Child segments inherit metadata they do not override.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Routing Metadata','Practise: Describe pages to browsers and search engines with the metadata export','Add a metadata export to the root layout with a title template and description, then add page-level metadata that fills in the template.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Routing Metadata: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 18: title Metadata
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'title Metadata', 'Set titles per page, including dynamic titles.', 'Export a title on a page.
Use the template from the layout.
Create a dynamic title with generateMetadata.', '## What this lesson covers

Set titles per page, including dynamic titles.

- A page title replaces the segment title while keeping the template.
- Dynamic routes need generateMetadata because the title depends on data.
- Consistent titles help users understand where they are.

## Key code
```tsx
export async function generateMetadata({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  return { title: `Product ${id}` };
}
```

## Practice
Give three pages their own titles, then add generateMetadata to a dynamic product page so the title contains the product id.', 'A page title replaces the segment title while keeping the template.
Dynamic routes need generateMetadata because the title depends on data.
Consistent titles help users understand where they are.', 'dckNsCjnV9A', 3, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Export a title on a page.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the template from the layout.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a dynamic title with generateMetadata.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=dckNsCjnV9A'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: title Metadata','https://www.youtube.com/results?search_query=title+Metadata'),(@lesson,'Next.js docs: generateMetadata','https://nextjs.org/docs/app/api-reference/functions/generate-metadata');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: title Metadata','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which function produces metadata that depends on route data?','generateMetadata can be async and read params.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'generateMetadata',1,0),(@q,'getMetadata',0,1),(@q,'useMetadata',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A title template can wrap every page title in your app name.','Templates keep titles consistent across the site.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: title Metadata','Practise: Set titles per page, including dynamic titles','Give three pages their own titles, then add generateMetadata to a dynamic product page so the title contains the product id.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','title Metadata: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 19: Link Component
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Link Component', 'Navigate between pages with the Link component.', 'Import and use Link.
Navigate without a full page reload.
Prefetch a destination.', '## What this lesson covers

Navigate between pages with the Link component.

- The next/link component navigates on the client and avoids a full reload.
- Links are prefetched in view, which makes navigation feel instant.
- Use Link for internal routes and plain anchors for external sites.

## Key code
```tsx
import Link from "next/link";

<Link href="/about" className="hover:underline">About</Link>
```

## Practice
Replace every internal anchor in your header with Link and confirm the navigation no longer reloads the whole page.', 'The next/link component navigates on the client and avoids a full reload.
Links are prefetched in view, which makes navigation feel instant.
Use Link for internal routes and plain anchors for external sites.', '9y7E44zHiGM', 5, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Import and use Link.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Navigate without a full page reload.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Prefetch a destination.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=9y7E44zHiGM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Link Component','https://www.youtube.com/results?search_query=Link+Component'),(@lesson,'Next.js docs: Link component','https://nextjs.org/docs/app/api-reference/components/link');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Link Component','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why use Link instead of an anchor for internal routes?','Link keeps client state and prefetches the target.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It navigates on the client and prefetches',1,0),(@q,'It opens a new tab',0,1),(@q,'It disables JavaScript',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A plain anchor tag causes a full page reload for internal navigation.','Anchors ask the browser for a new document.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Link Component','Practise: Navigate between pages with the Link component','Replace every internal anchor in your header with Link and confirm the navigation no longer reloads the whole page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Link Component: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 20: Active Links
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Active Links', 'Highlight the link for the current page.', 'Detect the active route in a client component.
Style the active link differently.
Keep the logic in one navigation component.', '## What this lesson covers

Highlight the link for the current page.

- usePathname from next/navigation returns the current path in a client component.
- Client components need "use client" at the top of the file.
- Comparing the pathname with the href gives you the active state.

## Key code
```tsx
"use client";
import Link from "next/link";
import { usePathname } from "next/navigation";

export function NavLink({ href, children }: { href: string; children: React.ReactNode }) {
  const path = usePathname();
  const active = path === href;
  return <Link href={href} className={active ? "font-bold text-indigo-600" : "text-gray-600"}>{children}</Link>;
}
```

## Practice
Build a Navigation client component that adds a highlighted style to the link matching usePathname. Test on three pages.', 'usePathname from next/navigation returns the current path in a client component.
Client components need "use client" at the top of the file.
Comparing the pathname with the href gives you the active state.', 'aJjMeCUvZ0E', 4, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Detect the active route in a client component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Style the active link differently.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the logic in one navigation component.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=aJjMeCUvZ0E'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Active Links','https://www.youtube.com/results?search_query=Active+Links'),(@lesson,'Next.js docs: usePathname','https://nextjs.org/docs/app/api-reference/functions/use-pathname');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Active Links','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which hook returns the current path in a client component?','usePathname reads the current URL path.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'usePathname',1,0),(@q,'useRouter',0,1),(@q,'useParams',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','usePathname works in a server component.','It is a client hook and needs "use client".',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Active Links','Practise: Highlight the link for the current page','Build a Navigation client component that adds a highlighted style to the link matching usePathname. Test on three pages.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Active Links: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 21: params and searchParams
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'params and searchParams', 'Read route parameters and query strings in server components.', 'Read params in a dynamic page.
Read searchParams for filters and sorting.
Know that both are promises in Next.js 15.', '## What this lesson covers

Read route parameters and query strings in server components.

- params holds dynamic segment values; searchParams holds the query string.
- Both are promises in Next.js 15 and must be awaited.
- searchParams values may be a string or an array of strings.

## Key code
```tsx
export default async function Page({ searchParams }: { searchParams: Promise<{ sort?: string }> }) {
  const { sort } = await searchParams;
  return <p>Sorting by {sort ?? "name"}</p>;
}
```

## Practice
Build a products page that reads a sort query and a search query, then displays both values and the current category parameter.', 'params holds dynamic segment values; searchParams holds the query string.
Both are promises in Next.js 15 and must be awaited.
searchParams values may be a string or an array of strings.', 'qPsY4AKFlnM', 6, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read params in a dynamic page.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read searchParams for filters and sorting.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know that both are promises in Next.js 15.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=qPsY4AKFlnM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: params and searchParams','https://www.youtube.com/results?search_query=params+and+searchParams'),(@lesson,'Next.js docs: Page props','https://nextjs.org/docs/app/api-reference/file-conventions/page');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: params and searchParams','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which value comes from the URL query string?','The query string is exposed through searchParams.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'searchParams',1,0),(@q,'params',0,1),(@q,'metadata',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','searchParams must be awaited in Next.js 15.','Both params and searchParams are promises in Next.js 15.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: params and searchParams','Practise: Read route parameters and query strings in server components','Build a products page that reads a sort query and a search query, then displays both values and the current category parameter.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','params and searchParams: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 4: Navigation, Loading and Errors =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Navigation, Loading and Errors','Programmatic navigation, templates, loading states and error boundaries.',3);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Navigation, Loading and Errors',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Navigation, Loading and Errors');

-- Lesson 22: Navigating Programmatically
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Navigating Programmatically', 'Move between pages from code with the router.', 'Import useRouter in a client component.
Call push or replace after an action.
Choose between push and replace.', '## What this lesson covers

Move between pages from code with the router.

- useRouter from next/navigation gives push, replace, back and refresh.
- push adds a history entry; replace swaps the current one.
- Redirecting after a form submit is a common use.

## Key code
```tsx
"use client";
import { useRouter } from "next/navigation";

const router = useRouter();
router.push(`/products?q=${encodeURIComponent(query)}`);
```

## Practice
Add a search form that navigates to /products?q=... with router.push when submitted, and a cancel button that uses router.back().', 'useRouter from next/navigation gives push, replace, back and refresh.
push adds a history entry; replace swaps the current one.
Redirecting after a form submit is a common use.', 'Z9P6UveWGKc', 4, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Import useRouter in a client component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call push or replace after an action.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose between push and replace.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Z9P6UveWGKc'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Navigating Programmatically','https://www.youtube.com/results?search_query=Navigating+Programmatically'),(@lesson,'Next.js docs: useRouter','https://nextjs.org/docs/app/api-reference/functions/use-router');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Navigating Programmatically','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which method adds a new history entry?','push adds an entry; replace overwrites the current one.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'router.push',1,0),(@q,'router.replace',0,1),(@q,'router.back',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','useRouter can be used in a server component.','useRouter is a client hook.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Navigating Programmatically','Practise: Move between pages from code with the router','Add a search form that navigates to /products?q=... with router.push when submitted, and a cancel button that uses router.back().

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Navigating Programmatically: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 23: Templates
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Templates', 'Use template files when a layout must remount.', 'Create a template file.
Explain how templates differ from layouts.
Use a template for enter animations.', '## What this lesson covers

Use template files when a layout must remount.

- A template wraps children like a layout but remounts on navigation.
- Layouts keep state; templates reset it.
- Templates are useful for page-transition effects that must restart.

## Practice
Add app/template.tsx that logs a message on mount and shows an animation wrapper. Navigate between pages and compare with the layout behaviour.', 'A template wraps children like a layout but remounts on navigation.
Layouts keep state; templates reset it.
Templates are useful for page-transition effects that must restart.', 'yfww2kplO-k', 4, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a template file.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain how templates differ from layouts.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use a template for enter animations.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=yfww2kplO-k'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Templates','https://www.youtube.com/results?search_query=Templates'),(@lesson,'Next.js docs: template file','https://nextjs.org/docs/app/api-reference/file-conventions/template');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Templates','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is the key difference between a template and a layout?','Templates create a new instance for each navigation.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A template remounts on navigation',1,0),(@q,'A template cannot hold children',0,1),(@q,'A layout remounts on navigation',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A template can be nested inside folders just like a layout.','Both follow the folder structure.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Templates','Practise: Use template files when a layout must remount','Add app/template.tsx that logs a message on mount and shows an animation wrapper. Navigate between pages and compare with the layout behaviour.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Templates: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 24: Loading UI
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Loading UI', 'Show instant loading states with a loading file.', 'Create a loading file for a route.
Explain when Next.js shows it.
Design a skeleton screen.', '## What this lesson covers

Show instant loading states with a loading file.

- A loading.tsx file is shown automatically while its segment loads.
- It creates a Suspense boundary around the page.
- Skeletons keep the layout stable while content arrives.

## Key code
```tsx
// app/products/loading.tsx
export default function Loading() {
  return <div className="p-6 animate-pulse">Loading products...</div>;
}
```

## Practice
Add a loading file with three skeleton cards for a products route that waits a second before rendering. Screenshot the loading state.', 'A loading.tsx file is shown automatically while its segment loads.
It creates a Suspense boundary around the page.
Skeletons keep the layout stable while content arrives.', '0OVg4ikUaz0', 3, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a loading file for a route.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when Next.js shows it.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Design a skeleton screen.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=0OVg4ikUaz0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Loading UI','https://www.youtube.com/results?search_query=Loading+UI'),(@lesson,'Next.js docs: loading file','https://nextjs.org/docs/app/api-reference/file-conventions/loading');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Loading UI','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When is a loading file displayed?','Next.js swaps in the loading UI while the segment resolves.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'While its route segment is loading',1,0),(@q,'Only after an error',0,1),(@q,'On the first build only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A loading file creates a Suspense boundary.','The loading UI is the fallback for that boundary.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Loading UI','Practise: Show instant loading states with a loading file','Add a loading file with three skeleton cards for a products route that waits a second before rendering. Screenshot the loading state.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Loading UI: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 25: Error Handling
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Error Handling', 'Catch runtime errors with an error boundary file.', 'Create an error file for a route.
Use the error and reset props.
Understand that error files must be client components.', '## What this lesson covers

Catch runtime errors with an error boundary file.

- error.tsx catches errors thrown while rendering its segment.
- The component receives error and reset, which retries the segment.
- The root layout stays usable because the error boundary sits below it.

## Key code
```tsx
"use client";
export default function Error({ error, reset }: { error: Error; reset: () => void }) {
  return (
    <div className="p-6">
      <h2 className="text-lg font-semibold">Something went wrong</h2>
      <p className="text-sm text-gray-600">{error.message}</p>
      <button className="mt-3 px-3 py-2 rounded bg-indigo-600 text-white" onClick={reset}>Try again</button>
    </div>
  );
}
```

## Practice
Create a page with a button that throws an error, and an error file that shows the message and a Try again button calling reset().', 'error.tsx catches errors thrown while rendering its segment.
The component receives error and reset, which retries the segment.
The root layout stays usable because the error boundary sits below it.', 'fWV5WPSbgdg', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create an error file for a route.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the error and reset props.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand that error files must be client components.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=fWV5WPSbgdg'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Error Handling','https://www.youtube.com/results?search_query=Error+Handling'),(@lesson,'Next.js docs: error file','https://nextjs.org/docs/app/api-reference/file-conventions/error');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Error Handling','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which props does an error boundary component receive?','The component gets the error object and a reset function.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'error and reset',1,0),(@q,'err and reload',0,1),(@q,'message and retry',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An error file must be a client component.','Error boundaries need "use client".',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Error Handling','Practise: Catch runtime errors with an error boundary file','Create a page with a button that throws an error, and an error file that shows the message and a Try again button calling reset().

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Error Handling: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 26: Recovering from Errors
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Recovering from Errors', 'Let users retry after an error instead of reloading the page.', 'Call reset to retry rendering.
Understand why reset may not fix every error.
Offer a link back as a fallback.', '## What this lesson covers

Let users retry after an error instead of reloading the page.

- reset re-renders the failed segment and keeps client state where possible.
- If the cause is outside the segment, only navigation or a reload helps.
- Give users both a retry action and a way to leave the page.

## Practice
Add a retry button and a back link to your error boundary, then trigger the same error twice to see both paths.', 'reset re-renders the failed segment and keeps client state where possible.
If the cause is outside the segment, only navigation or a reload helps.
Give users both a retry action and a way to leave the page.', '15beQR0DFMQ', 3, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call reset to retry rendering.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand why reset may not fix every error.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Offer a link back as a fallback.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=15beQR0DFMQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Recovering from Errors','https://www.youtube.com/results?search_query=Recovering+from+Errors'),(@lesson,'Next.js docs: Error handling','https://nextjs.org/docs/app/getting-started/error-handling');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Recovering from Errors','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does calling reset do?','reset clears the error boundary and re-renders.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Retries rendering the failed segment',1,0),(@q,'Reloads the browser',0,1),(@q,'Restarts the server',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','reset always fixes the underlying cause of an error.','If the cause remains, the error appears again.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Recovering from Errors','Practise: Let users retry after an error instead of reloading the page','Add a retry button and a back link to your error boundary, then trigger the same error twice to see both paths.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Recovering from Errors: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 27: Handling Errors in Nested Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Handling Errors in Nested Routes', 'Place error files so they cover the right part of the app.', 'Add an error file to a nested folder.
Explain which routes it protects.
Keep the rest of the page usable.', '## What this lesson covers

Place error files so they cover the right part of the app.

- The nearest error boundary above the failing route renders.
- A nested error file keeps the rest of the layout interactive.
- Boundaries do not catch errors from layouts above them.

## Practice
Add an error file inside app/dashboard so only dashboard pages show the error UI while the sidebar keeps working.', 'The nearest error boundary above the failing route renders.
A nested error file keeps the rest of the layout interactive.
Boundaries do not catch errors from layouts above them.', 'ZPpNu0ybNZM', 2, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add an error file to a nested folder.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain which routes it protects.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the rest of the page usable.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=ZPpNu0ybNZM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Handling Errors in Nested Routes','https://www.youtube.com/results?search_query=Handling+Errors+in+Nested+Routes'),(@lesson,'Next.js docs: Nested error boundaries','https://nextjs.org/docs/app/getting-started/error-handling');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Handling Errors in Nested Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which error boundary is used when an error is thrown?','Next.js uses the closest boundary up the tree.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The nearest one above the failing route',1,0),(@q,'The root layout always',0,1),(@q,'The one in the same folder as layout',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A nested error boundary keeps the surrounding layout usable.','Only the wrapped segment is replaced.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Handling Errors in Nested Routes','Practise: Place error files so they cover the right part of the app','Add an error file inside app/dashboard so only dashboard pages show the error UI while the sidebar keeps working.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Handling Errors in Nested Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 28: Handling Errors in Layouts
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Handling Errors in Layouts', 'Understand why an error file cannot catch errors from its own layout.', 'Explain the boundary limitation.
Move the error file up a level.
Verify the fix in the browser.', '## What this lesson covers

Understand why an error file cannot catch errors from its own layout.

- An error file wraps the page below its layout, not the layout itself.
- To catch layout errors, place the error file in the parent folder.
- This is why a layout error can replace a whole section.

## Practice
Create a layout that throws an error and an error file beside it. Observe the result, then move the error file to the parent folder and observe the difference.', 'An error file wraps the page below its layout, not the layout itself.
To catch layout errors, place the error file in the parent folder.
This is why a layout error can replace a whole section.', '-OAVelXX5sE', 2, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the boundary limitation.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Move the error file up a level.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Verify the fix in the browser.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=-OAVelXX5sE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Handling Errors in Layouts','https://www.youtube.com/results?search_query=Handling+Errors+in+Layouts'),(@lesson,'Next.js docs: Error boundaries and layouts','https://nextjs.org/docs/app/getting-started/error-handling');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Handling Errors in Layouts','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where must the error file live to catch errors thrown inside a layout?','A boundary does not catch errors from its own layout.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In the parent folder',1,0),(@q,'In the same folder as the layout',0,1),(@q,'In the app root only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An error file can catch errors thrown in its own layout file.','The boundary sits inside the layout, so the layout is above it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Handling Errors in Layouts','Practise: Understand why an error file cannot catch errors from its own layout','Create a layout that throws an error and an error file beside it. Observe the result, then move the error file to the parent folder and observe the difference.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Handling Errors in Layouts: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 29: Handling Global Errors
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Handling Global Errors', 'Catch errors in the root layout with a global error file.', 'Create a global-error file.
Include html and body tags.
Understand that it replaces the root layout.', '## What this lesson covers

Catch errors in the root layout with a global error file.

- global-error.tsx catches errors thrown in the root layout itself.
- It must render its own html and body tags because it replaces the root layout.
- It only runs in production, so test the production build.

## Key code
```tsx
"use client";
export default function GlobalError({ error, reset }: { error: Error; reset: () => void }) {
  return (
    <html><body className="p-8">
      <h1 className="text-xl font-bold">Application error</h1>
      <button className="mt-4 underline" onClick={reset}>Reload</button>
    </body></html>
  );
}
```

## Practice
Create a global error file with its own document shell and a reset button, then run a production build to see it.', 'global-error.tsx catches errors thrown in the root layout itself.
It must render its own html and body tags because it replaces the root layout.
It only runs in production, so test the production build.', 'ywUDMEVR3Mg', 6, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a global-error file.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Include html and body tags.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand that it replaces the root layout.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=ywUDMEVR3Mg'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Handling Global Errors','https://www.youtube.com/results?search_query=Handling+Global+Errors'),(@lesson,'Next.js docs: global-error file','https://nextjs.org/docs/app/api-reference/file-conventions/global-error');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Handling Global Errors','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why does a global error file render html and body tags?','The root layout is unavailable when the global boundary renders.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It replaces the root layout',1,0),(@q,'Next.js requires them in every file',0,1),(@q,'For styling only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The global error boundary also runs in development.','It is intended for production; development shows the overlay.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Handling Global Errors','Practise: Catch errors in the root layout with a global error file','Create a global error file with its own document shell and a reset button, then run a production build to see it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Handling Global Errors: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 5: Parallel and Intercepting Routes =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Parallel and Intercepting Routes','Build dashboards with slots and modals with intercepted URLs.',4);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Parallel and Intercepting Routes',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Parallel and Intercepting Routes');

-- Lesson 30: Parallel Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Parallel Routes', 'Render several pages side by side with named slots.', 'Create a slot with an @folder name.
Render the slot in a layout.
Give each slot its own loading and error files.', '## What this lesson covers

Render several pages side by side with named slots.

- A folder named @team is a slot, not a URL segment.
- The layout receives each slot as a prop and decides where to render it.
- Each slot can define its own loading and error boundaries.

## Key code
```tsx
// app/dashboard/layout.tsx
export default function Layout({ children, analytics, notifications }: {
  children: React.ReactNode; analytics: React.ReactNode; notifications: React.ReactNode;
}) {
  return (
    <div className="grid gap-4">
      {children}
      {analytics}
      {notifications}
    </div>
  );
}
```

## Practice
Build a dashboard layout with @analytics and @notifications slots, each with its own page, and render them beside the main children.', 'A folder named @team is a slot, not a URL segment.
The layout receives each slot as a prop and decides where to render it.
Each slot can define its own loading and error boundaries.', '697kNwfU-4M', 9, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a slot with an @folder name.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render the slot in a layout.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Give each slot its own loading and error files.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=697kNwfU-4M'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Parallel Routes','https://www.youtube.com/results?search_query=Parallel+Routes'),(@lesson,'Next.js docs: Parallel routes','https://nextjs.org/docs/app/api-reference/file-conventions/parallel-routes');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Parallel Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which folder name creates a slot called team?','The @ prefix marks a parallel route slot.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'@team',1,0),(@q,'(team)',0,1),(@q,'[team]',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A slot appears as a segment in the URL.','Slots are props in the layout, not URL segments.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Parallel Routes','Practise: Render several pages side by side with named slots','Build a dashboard layout with @analytics and @notifications slots, each with its own page, and render them beside the main children.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Parallel Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 31: Unmatched Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Unmatched Routes', 'Control what a slot shows when the visitor navigates elsewhere.', 'Add a default file to a slot.
Understand hard and soft navigation behaviour.', '## What this lesson covers

Control what a slot shows when the visitor navigates elsewhere.

- default.tsx is the fallback a slot renders when no matching page exists.
- Soft navigation keeps the previous state; a full reload needs the default file.
- Without a default file, a hard navigation can show a 404 in that slot.

## Practice
Add a default file to each slot in the dashboard, then reload a nested dashboard URL directly and confirm both slots still render something sensible.', 'default.tsx is the fallback a slot renders when no matching page exists.
Soft navigation keeps the previous state; a full reload needs the default file.
Without a default file, a hard navigation can show a 404 in that slot.', 'N2Hjwj5ibjQ', 6, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a default file to a slot.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand hard and soft navigation behaviour.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=N2Hjwj5ibjQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Unmatched Routes','https://www.youtube.com/results?search_query=Unmatched+Routes'),(@lesson,'Next.js docs: default file for unmatched slots','https://nextjs.org/docs/app/api-reference/file-conventions/parallel-routes#defaultjs');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Unmatched Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which file provides fallback UI for an unmatched slot?','default.tsx is rendered when the slot has no match.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'default.tsx',1,0),(@q,'loading.tsx',0,1),(@q,'page.tsx',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A hard reload of a nested route can leave a slot unmatched.','The slot needs a default file to handle that case.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Unmatched Routes','Practise: Control what a slot shows when the visitor navigates elsewhere','Add a default file to each slot in the dashboard, then reload a nested dashboard URL directly and confirm both slots still render something sensible.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Unmatched Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 32: Conditional Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Conditional Routes', 'Show a slot only for signed-in users.', 'Read session information on the server.
Render a slot conditionally.
Keep the layout logic simple.', '## What this lesson covers

Show a slot only for signed-in users.

- A layout is a server component, so it can await session data.
- Conditional JSX decides whether a slot appears.
- Protected sections read better than silently empty panels.

## Practice
Update the dashboard layout so the notifications slot only renders when a signed-in flag is true, and show a sign-in prompt otherwise.', 'A layout is a server component, so it can await session data.
Conditional JSX decides whether a slot appears.
Protected sections read better than silently empty panels.', 'P-_P3J11_bE', 3, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read session information on the server.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render a slot conditionally.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the layout logic simple.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=P-_P3J11_bE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Conditional Routes','https://www.youtube.com/results?search_query=Conditional+Routes'),(@lesson,'Next.js docs: Conditional routes','https://nextjs.org/docs/app/api-reference/file-conventions/parallel-routes#conditional-routes');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Conditional Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why can a layout decide which slots to render?','The layout is a component and can branch on data.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It is a server component and can read server data',1,0),(@q,'Slots decide for themselves',0,1),(@q,'Routing requires it',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Conditional slots can be used to hide admin panels from normal users.','Only render what the current user may see, and check again on the server.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Conditional Routes','Practise: Show a slot only for signed-in users','Update the dashboard layout so the notifications slot only renders when a signed-in flag is true, and show a sign-in prompt otherwise.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Conditional Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 33: Intercepting Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Intercepting Routes', 'Show a route as a modal while keeping a real URL.', 'Create a route group with interception.
Render a photo or post in a modal.
Keep the direct URL working as a full page.', '## What this lesson covers

Show a route as a modal while keeping a real URL.

- A folder such as (.)photo intercepts the photo route at the same level.
- The intercepting route renders inside the current layout, which enables a modal.
- A hard reload still shows the original full page, so the URL stays shareable.

## Key code
```text
app/photos/[id]/page.tsx          full page
app/photos/(.)[id]/page.tsx       intercepted inside the current layout
```

## Practice
Build a gallery where clicking a photo opens a modal using an intercepting route, and visiting the photo URL directly shows the full page.', 'A folder such as (.)photo intercepts the photo route at the same level.
The intercepting route renders inside the current layout, which enables a modal.
A hard reload still shows the original full page, so the URL stays shareable.', 'FTiwIVxWC00', 13, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a route group with interception.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render a photo or post in a modal.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the direct URL working as a full page.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=FTiwIVxWC00'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Intercepting Routes','https://www.youtube.com/results?search_query=Intercepting+Routes'),(@lesson,'Next.js docs: Intercepting routes','https://nextjs.org/docs/app/api-reference/file-conventions/intercepting-routes');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Intercepting Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does the (.) prefix mean in an intercepting route?','The dots describe how far up the tree to look.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Intercept the route at the same level',1,0),(@q,'Create a route group',0,1),(@q,'Make the segment dynamic',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An intercepted route breaks the direct URL for that page.','The direct URL still renders the original page on reload.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Intercepting Routes','Practise: Show a route as a modal while keeping a real URL','Build a gallery where clicking a photo opens a modal using an intercepting route, and visiting the photo URL directly shows the full page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Intercepting Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 34: Parallel Intercepting Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Parallel Intercepting Routes', 'Combine slots and interception for real modal patterns.', 'Add an intercepting route inside a slot.
Close the modal with a router action.', '## What this lesson covers

Combine slots and interception for real modal patterns.

- A slot can hold its own intercepting route, which suits login modals and photo viewers.
- Closing the modal usually means router.back() or pushing the previous path.
- The slot renders a default file when the modal is closed.

## Practice
Add a @modal slot with an intercepting photo route and a default file that renders nothing, so the modal closes when the URL changes back.', 'A slot can hold its own intercepting route, which suits login modals and photo viewers.
Closing the modal usually means router.back() or pushing the previous path.
The slot renders a default file when the modal is closed.', 'U6aRqv7rzQ8', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add an intercepting route inside a slot.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Close the modal with a router action.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=U6aRqv7rzQ8'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Parallel Intercepting Routes','https://www.youtube.com/results?search_query=Parallel+Intercepting+Routes'),(@lesson,'Next.js docs: Parallel intercepting routes','https://nextjs.org/docs/app/api-reference/file-conventions/intercepting-routes');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Parallel Intercepting Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How is a slot modal closed?','The default file makes an empty state for the closed modal.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Navigate back or to a path with no match, so the default file renders',1,0),(@q,'By reloading the page',0,1),(@q,'By unmounting the layout',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A slot can contain an intercepting route.','Combining the two patterns is a common modal approach.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Parallel Intercepting Routes','Practise: Combine slots and interception for real modal patterns','Add a @modal slot with an intercepting photo route and a default file that renders nothing, so the modal closes when the URL changes back.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Parallel Intercepting Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 6: Route Handlers =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Route Handlers','Build API endpoints with route handlers.',5);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Route Handlers',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Route Handlers');

-- Lesson 35: Route Handlers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Route Handlers', 'Create API endpoints with a route file.', 'Create app/api/hello/route.ts.
Export a GET function.
Return a JSON response.', '## What this lesson covers

Create API endpoints with a route file.

- A route.ts file exports functions named after HTTP methods.
- Route handlers live in app/api and do not render UI.
- Return NextResponse.json or a plain Response.

## Key code
```ts
import { NextResponse } from "next/server";

export async function GET() {
  return NextResponse.json({ message: "Hello", time: Date.now() });
}
```

## Practice
Create an API route /api/hello that returns a JSON object with a message and a timestamp. Test it in the browser.', 'A route.ts file exports functions named after HTTP methods.
Route handlers live in app/api and do not render UI.
Return NextResponse.json or a plain Response.', '27Uj6BeIDV0', 6, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create app/api/hello/route.ts.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Export a GET function.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return a JSON response.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=27Uj6BeIDV0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Route Handlers','https://www.youtube.com/results?search_query=Route+Handlers'),(@lesson,'Next.js docs: Route handlers','https://nextjs.org/docs/app/api-reference/file-conventions/route');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Route Handlers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which file name creates an API endpoint?','route.ts is the route handler convention.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'route.ts',1,0),(@q,'page.ts',0,1),(@q,'api.ts',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A route handler can export a function named GET.','Each exported HTTP method name becomes a handler.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Route Handlers','Practise: Create API endpoints with a route file','Create an API route /api/hello that returns a JSON object with a message and a timestamp. Test it in the browser.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Route Handlers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 36: Handling GET Requests
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Handling GET Requests', 'Return data from a GET handler.', 'Return a list of records.
Set a status code.
Shape a consistent response.', '## What this lesson covers

Return data from a GET handler.

- GET handlers should be safe and have no side effects.
- Return the data in a predictable shape such as a data key.
- Set an explicit status when the result is not a plain success.

## Practice
Create /api/products returning an array of five products, and a second endpoint that returns 404 with an error message when the list is empty.', 'GET handlers should be safe and have no side effects.
Return the data in a predictable shape such as a data key.
Set an explicit status when the result is not a plain success.', 'bD_Be8WiFvg', 3, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return a list of records.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set a status code.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Shape a consistent response.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=bD_Be8WiFvg'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Handling GET Requests','https://www.youtube.com/results?search_query=Handling+GET+Requests'),(@lesson,'Next.js docs: HTTP methods','https://nextjs.org/docs/app/api-reference/file-conventions/route#http-methods');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Handling GET Requests','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which HTTP method should return data without changing anything?','GET is a safe read-only method.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'GET',1,0),(@q,'POST',0,1),(@q,'DELETE',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which call returns JSON with a status code?','The second argument sets response options.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'NextResponse.json(data, { status: 404 })',1,0),(@q,'return data',0,1),(@q,'res.json = 404',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Handling GET Requests','Practise: Return data from a GET handler','Create /api/products returning an array of five products, and a second endpoint that returns 404 with an error message when the list is empty.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Handling GET Requests: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 37: Handling POST Requests
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Handling POST Requests', 'Accept data in a POST handler.', 'Read the JSON body.
Validate the input.
Return the created record with 201.', '## What this lesson covers

Accept data in a POST handler.

- Read the body with await request.json().
- Validate before writing anything; never trust client input.
- A successful creation returns 201 with the new record.

## Key code
```ts
export async function POST(request: Request) {
  const body = await request.json();
  if (!body?.name) {
    return NextResponse.json({ error: "Name is required" }, { status: 400 });
  }
  return NextResponse.json({ data: body }, { status: 201 });
}
```

## Practice
Create /api/products with a POST handler that validates a name and a price, then returns the new product with status 201.', 'Read the body with await request.json().
Validate before writing anything; never trust client input.
A successful creation returns 201 with the new record.', 'jkJ7JtQ2x5Y', 4, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the JSON body.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Validate the input.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return the created record with 201.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=jkJ7JtQ2x5Y'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Handling POST Requests','https://www.youtube.com/results?search_query=Handling+POST+Requests'),(@lesson,'Next.js docs: Route handler request','https://nextjs.org/docs/app/api-reference/file-conventions/route');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Handling POST Requests','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you read a JSON request body in a route handler?','The request object exposes json().',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'await request.json()',1,0),(@q,'request.body.json',0,1),(@q,'JSON.parse(request)',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Status 201 means a resource was created.','201 Created is the conventional success status for creation.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Handling POST Requests','Practise: Accept data in a POST handler','Create /api/products with a POST handler that validates a name and a price, then returns the new product with status 201.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Handling POST Requests: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 38: Dynamic Route Handlers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Dynamic Route Handlers', 'Read route parameters inside an API handler.', 'Create a dynamic API folder.
Read and await params.
Return a single record.', '## What this lesson covers

Read route parameters inside an API handler.

- A folder named [id] inside app/api creates a dynamic endpoint.
- The second argument of the handler holds params, which is a promise.
- Return 404 when the record does not exist.

## Key code
```ts
export async function GET(_request: Request, { params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  return NextResponse.json({ id });
}
```

## Practice
Create /api/products/[id] that returns one product by id and a 404 response for an unknown id.', 'A folder named [id] inside app/api creates a dynamic endpoint.
The second argument of the handler holds params, which is a promise.
Return 404 when the record does not exist.', 'EBkKNzJURJM', 4, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a dynamic API folder.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read and await params.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return a single record.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=EBkKNzJURJM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Dynamic Route Handlers','https://www.youtube.com/results?search_query=Dynamic+Route+Handlers'),(@lesson,'Next.js docs: Dynamic route segments in handlers','https://nextjs.org/docs/app/api-reference/file-conventions/route#dynamic-route-segments');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Dynamic Route Handlers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which signature reads a dynamic API parameter correctly?','The second argument carries params, which must be awaited.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'(request, { params }) with params awaited',1,0),(@q,'(request) reading request.params',0,1),(@q,'(request, id)',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A dynamic API route can return 404 for an unknown id.','Return an explicit 404 when nothing matches.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Dynamic Route Handlers','Practise: Read route parameters inside an API handler','Create /api/products/[id] that returns one product by id and a 404 response for an unknown id.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Dynamic Route Handlers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 39: Handling PATCH Requests
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Handling PATCH Requests', 'Update part of a record with PATCH.', 'Read the id and the partial body.
Validate the fields you allow.
Return the updated record.', '## What this lesson covers

Update part of a record with PATCH.

- PATCH updates only the supplied fields; PUT replaces the whole record.
- Whitelist the fields a client may change.
- Return 404 when the record is missing.

## Practice
Add a PATCH handler to /api/products/[id] that updates only the supplied fields and returns the merged record.', 'PATCH updates only the supplied fields; PUT replaces the whole record.
Whitelist the fields a client may change.
Return 404 when the record is missing.', 'rlHkm-Rbo74', 3, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the id and the partial body.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Validate the fields you allow.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return the updated record.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=rlHkm-Rbo74'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Handling PATCH Requests','https://www.youtube.com/results?search_query=Handling+PATCH+Requests'),(@lesson,'Next.js docs: Route handlers','https://nextjs.org/docs/app/api-reference/file-conventions/route');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Handling PATCH Requests','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does PATCH usually change?','PATCH applies a partial update.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Only the supplied fields',1,0),(@q,'The whole record',0,1),(@q,'Nothing until a reload',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','You should allow a client to update any field it sends.','Whitelist the fields that may change.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Handling PATCH Requests','Practise: Update part of a record with PATCH','Add a PATCH handler to /api/products/[id] that updates only the supplied fields and returns the merged record.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Handling PATCH Requests: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 40: Handling DELETE Requests
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Handling DELETE Requests', 'Remove a record with DELETE.', 'Delete by id.
Return a suitable status.
Handle a missing record.', '## What this lesson covers

Remove a record with DELETE.

- DELETE should be idempotent: repeating it must not corrupt anything.
- Return 204 with no body, or 200 with a confirmation.
- Return 404 when the record does not exist.

## Practice
Add a DELETE handler to /api/products/[id] and test it twice: the first call succeeds, the second returns 404.', 'DELETE should be idempotent: repeating it must not corrupt anything.
Return 204 with no body, or 200 with a confirmation.
Return 404 when the record does not exist.', 'Rv92ysl9tOQ', 3, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Delete by id.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return a suitable status.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Handle a missing record.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Rv92ysl9tOQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Handling DELETE Requests','https://www.youtube.com/results?search_query=Handling+DELETE+Requests'),(@lesson,'Next.js docs: HTTP methods','https://nextjs.org/docs/app/api-reference/file-conventions/route#http-methods');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Handling DELETE Requests','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which status fits a successful delete with no body?','204 No Content signals success without a body.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'204',1,0),(@q,'201',0,1),(@q,'301',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Deleting the same record twice should always return success.','A missing record can return 404; the operation is still idempotent in effect.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Handling DELETE Requests','Practise: Remove a record with DELETE','Add a DELETE handler to /api/products/[id] and test it twice: the first call succeeds, the second returns 404.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Handling DELETE Requests: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 41: URL Query Parameters
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'URL Query Parameters', 'Read query strings in an API handler.', 'Read filters from the request URL.
Apply defaults.
Return the filtered result.', '## What this lesson covers

Read query strings in an API handler.

- new URL(request.url).searchParams gives you the query values.
- Always apply sensible defaults and limits.
- Validate numeric filters before using them.

## Key code
```ts
const { searchParams } = new URL(request.url);
const limit = Math.min(Number(searchParams.get("limit") ?? 20), 100);
```

## Practice
Add a search and limit filter to /api/products using searchParams and return the filtered list with sensible defaults.', 'new URL(request.url).searchParams gives you the query values.
Always apply sensible defaults and limits.
Validate numeric filters before using them.', 'LvRLbeBYkuo', 3, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read filters from the request URL.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Apply defaults.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return the filtered result.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=LvRLbeBYkuo'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: URL Query Parameters','https://www.youtube.com/results?search_query=URL+Query+Parameters'),(@lesson,'Next.js docs: Query parameters','https://nextjs.org/docs/app/api-reference/file-conventions/route');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: URL Query Parameters','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you read a query value in a route handler?','Parse the request URL and read searchParams.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'new URL(request.url).searchParams',1,0),(@q,'request.query',0,1),(@q,'request.params',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A limit parameter from the URL should be validated before use.','Client input is untrusted and unbounded.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: URL Query Parameters','Practise: Read query strings in an API handler','Add a search and limit filter to /api/products using searchParams and return the filtered list with sensible defaults.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','URL Query Parameters: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 42: Headers in Route Handlers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Headers in Route Handlers', 'Read request headers and set response headers.', 'Read an incoming header.
Set a response header.
Check an authorisation header.', '## What this lesson covers

Read request headers and set response headers.

- request.headers is a read-only Headers object with get().
- Pass headers in the response options or use NextResponse headers.
- Headers carry tokens, content types and caching instructions.

## Key code
```ts
const key = request.headers.get("x-api-key");
if (key !== process.env.API_KEY) {
  return NextResponse.json({ error: "Unauthorised" }, { status: 401 });
}
```

## Practice
Add a check for an x-api-key header on one endpoint and return 401 when it is missing, then set a custom x-powered-by style header on the response.', 'request.headers is a read-only Headers object with get().
Pass headers in the response options or use NextResponse headers.
Headers carry tokens, content types and caching instructions.', 'xshMFZRXDPM', 6, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read an incoming header.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set a response header.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Check an authorisation header.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=xshMFZRXDPM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Headers in Route Handlers','https://www.youtube.com/results?search_query=Headers+in+Route+Handlers'),(@lesson,'Next.js docs: Headers','https://nextjs.org/docs/app/api-reference/functions/headers');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Headers in Route Handlers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you read the authorization header?','Headers use the get method.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'request.headers.get("authorization")',1,0),(@q,'request.auth',0,1),(@q,'request.headers.authorization',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Headers can carry an API token.','Authorisation headers are a common token location.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Headers in Route Handlers','Practise: Read request headers and set response headers','Add a check for an x-api-key header on one endpoint and return 401 when it is missing, then set a custom x-powered-by style header on the response.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Headers in Route Handlers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 43: Cookies in Route Handlers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Cookies in Route Handlers', 'Read and set cookies from an endpoint.', 'Read a cookie from the request.
Set a cookie on the response.
Use secure cookie options.', '## What this lesson covers

Read and set cookies from an endpoint.

- Read cookies from the request Headers with the cookie header.
- Set cookies on the response with response.cookies.set.
- Mark cookies httpOnly and secure where possible.

## Key code
```ts
const response = NextResponse.json({ ok: true });
response.cookies.set("session", token, { httpOnly: true, secure: true, sameSite: "lax", path: "/" });
return response;
```

## Practice
Create a login endpoint that sets a session cookie and a profile endpoint that reads it back and reports whether the visitor is signed in.', 'Read cookies from the request Headers with the cookie header.
Set cookies on the response with response.cookies.set.
Mark cookies httpOnly and secure where possible.', '7KEwSiD7VxY', 3, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read a cookie from the request.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set a cookie on the response.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use secure cookie options.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7KEwSiD7VxY'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Cookies in Route Handlers','https://www.youtube.com/results?search_query=Cookies+in+Route+Handlers'),(@lesson,'Next.js docs: cookies','https://nextjs.org/docs/app/api-reference/functions/cookies');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Cookies in Route Handlers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which option keeps a cookie unavailable to JavaScript?','httpOnly hides the cookie from document.cookie.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'httpOnly',1,0),(@q,'secret',0,1),(@q,'readonly',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A session cookie should be marked secure in production.','Secure cookies are only sent over HTTPS.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Cookies in Route Handlers','Practise: Read and set cookies from an endpoint','Create a login endpoint that sets a session cookie and a profile endpoint that reads it back and reports whether the visitor is signed in.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Cookies in Route Handlers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 44: Redirects in Route Handlers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Redirects in Route Handlers', 'Send visitors to another URL from an endpoint.', 'Return a redirect response.
Choose a permanent or temporary redirect.
Test the redirect in the browser.', '## What this lesson covers

Send visitors to another URL from an endpoint.

- NextResponse.redirect creates a redirect response.
- A 307 or 308 keeps the method; 301 and 302 are the classic choices.
- Redirect after a successful action such as sign out.

## Practice
Add a sign-out endpoint that clears the session cookie and redirects to the home page, and confirm the redirect in the browser.', 'NextResponse.redirect creates a redirect response.
A 307 or 308 keeps the method; 301 and 302 are the classic choices.
Redirect after a successful action such as sign out.', 'L0iIzarEQ6Q', 2, 1, 1, 9, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return a redirect response.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose a permanent or temporary redirect.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Test the redirect in the browser.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=L0iIzarEQ6Q'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Redirects in Route Handlers','https://www.youtube.com/results?search_query=Redirects+in+Route+Handlers'),(@lesson,'Next.js docs: redirect','https://nextjs.org/docs/app/api-reference/functions/redirect');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Redirects in Route Handlers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which call returns a redirect from a route handler?','Build an absolute URL and return a redirect response.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'NextResponse.redirect(new URL("/", request.url))',1,0),(@q,'return "/"',0,1),(@q,'location = "/"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A redirect response can be returned from an API endpoint.','Route handlers may return redirects.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Redirects in Route Handlers','Practise: Send visitors to another URL from an endpoint','Add a sign-out endpoint that clears the session cookie and redirects to the home page, and confirm the redirect in the browser.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Redirects in Route Handlers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 45: Caching in Route Handlers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Caching in Route Handlers', 'Control how API responses are cached.', 'Understand default caching.
Opt out with dynamic rendering.
Set cache headers.', '## What this lesson covers

Control how API responses are cached.

- Route handlers that read the request are dynamic; those that do not may be cached statically.
- export const dynamic = "force-dynamic" opts a handler out of caching.
- Cache-Control headers tell browsers and proxies how to store a response.

## Practice
Make one endpoint cacheable with a Cache-Control header and another forced dynamic that returns the current time. Compare repeated requests.', 'Route handlers that read the request are dynamic; those that do not may be cached statically.
export const dynamic = "force-dynamic" opts a handler out of caching.
Cache-Control headers tell browsers and proxies how to store a response.', '1afNuqtb7q8', 4, 1, 1, 10, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand default caching.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Opt out with dynamic rendering.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set cache headers.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=1afNuqtb7q8'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Caching in Route Handlers','https://www.youtube.com/results?search_query=Caching+in+Route+Handlers'),(@lesson,'Next.js docs: Route segment config','https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Caching in Route Handlers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which setting forces a handler to run on every request?','The dynamic export controls caching.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'export const dynamic = "force-dynamic"',1,0),(@q,'export const cache = false',0,1),(@q,'export const GET = dynamic',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A handler that reads search parameters from the request is dynamic.','Reading request data prevents static caching.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Caching in Route Handlers','Practise: Control how API responses are cached','Make one endpoint cacheable with a Cache-Control header and another forced dynamic that returns the current time. Compare repeated requests.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Caching in Route Handlers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 7: Middleware =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Middleware','Run code before a request reaches a route.',6);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Middleware',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Middleware');

-- Lesson 46: Middleware
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Middleware', 'Intercept requests with middleware.', 'Create a middleware file at the project root.
Match only the routes that need it.
Redirect or rewrite a request.', '## What this lesson covers

Intercept requests with middleware.

- middleware.ts runs before a request is completed.
- A matcher limits which paths run the middleware.
- Common uses are authentication checks, redirects and header changes.

## Key code
```ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  if (!request.cookies.get("session")) {
    return NextResponse.redirect(new URL("/login", request.url));
  }
  return NextResponse.next();
}

export const config = { matcher: ["/admin/:path*"] };
```

## Practice
Create middleware that redirects /admin requests without a session cookie to /login, and limit it with a matcher.', 'middleware.ts runs before a request is completed.
A matcher limits which paths run the middleware.
Common uses are authentication checks, redirects and header changes.', 't1KTTZbqCm0', 6, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a middleware file at the project root.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Match only the routes that need it.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Redirect or rewrite a request.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=t1KTTZbqCm0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Middleware','https://www.youtube.com/results?search_query=Middleware'),(@lesson,'Next.js docs: Middleware','https://nextjs.org/docs/app/api-reference/file-conventions/middleware');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Middleware','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where does the middleware file live?','Next.js looks for middleware.ts at the root of the project or src folder.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'At the project root beside app',1,0),(@q,'Inside every route folder',0,1),(@q,'In the public folder',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A matcher can limit middleware to specific paths.','The matcher avoids running middleware on every request.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Middleware','Practise: Intercept requests with middleware','Create middleware that redirects /admin requests without a session cookie to /login, and limit it with a matcher.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Middleware: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 8: Rendering =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Rendering','Understand when and how Next.js renders your pages.',7);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Rendering',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Rendering');

-- Lesson 47: Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Rendering', 'Meet the rendering options Next.js offers.', 'Name client-side, server-side and static rendering.
Explain where server components fit.
Choose a starting strategy for a page.', '## What this lesson covers

Meet the rendering options Next.js offers.

- Rendering decides where HTML is produced: on the client, on the server or ahead of time.
- Next.js supports static rendering, dynamic rendering, streaming and client rendering.
- The right choice depends on how often data changes and who may see it.

## Practice
Write a short note comparing static, dynamic and client rendering with one example page for each.', 'Rendering decides where HTML is produced: on the client, on the server or ahead of time.
Next.js supports static rendering, dynamic rendering, streaming and client rendering.
The right choice depends on how often data changes and who may see it.', '6-qMfLcPhOw', 1, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name client-side, server-side and static rendering.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain where server components fit.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose a starting strategy for a page.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=6-qMfLcPhOw'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Rendering','https://www.youtube.com/results?search_query=Rendering'),(@lesson,'Next.js docs: Rendering','https://nextjs.org/docs/app/building-your-application/rendering');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does rendering describe?','Rendering is about producing the UI the visitor receives.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Where and when HTML is produced',1,0),(@q,'How CSS is compiled',0,1),(@q,'How routes are named',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Next.js supports more than one rendering strategy.','Different routes can use different strategies.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Rendering','Practise: Meet the rendering options Next.js offers','Write a short note comparing static, dynamic and client rendering with one example page for each.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 48: Client-side Rendering (CSR)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Client-side Rendering (CSR)', 'Render in the browser with client components.', 'Mark a component as a client component.
Fetch data in the browser.
Recognise the trade-offs.', '## What this lesson covers

Render in the browser with client components.

- A "use client" component ships JavaScript and runs in the browser.
- CSR shows a loading state while the browser fetches data.
- CSR suits highly interactive widgets rather than first-paint content.

## Key code
```tsx
"use client";
import { useEffect, useState } from "react";

export default function Products() {
  const [items, setItems] = useState<unknown[]>([]);
  useEffect(() => {
    fetch("/api/products").then(r => r.json()).then(d => setItems(d.data ?? []));
  }, []);
  return <ul>{items.map((item, i) => <li key={i}>{String(item)}</li>)}</ul>;
}
```

## Practice
Build a client component that fetches a list from an API on mount and shows a loading state, then note what the visitor sees before the data arrives.', 'A "use client" component ships JavaScript and runs in the browser.
CSR shows a loading state while the browser fetches data.
CSR suits highly interactive widgets rather than first-paint content.', '-FIUWaYXmTU', 3, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Mark a component as a client component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Fetch data in the browser.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise the trade-offs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=-FIUWaYXmTU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Client-side Rendering (CSR)','https://www.youtube.com/results?search_query=Client-side+Rendering+(CSR)'),(@lesson,'Next.js docs: Client components','https://nextjs.org/docs/app/api-reference/directives/use-client');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Client-side Rendering (CSR)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which directive marks a client component?','The directive sits at the top of the file.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'"use client"',1,0),(@q,'"client"',0,1),(@q,'"browser only"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Client-side rendering delays content until JavaScript loads.','The browser needs the bundle before it can fetch and render.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Client-side Rendering (CSR)','Practise: Render in the browser with client components','Build a client component that fetches a list from an API on mount and shows a loading state, then note what the visitor sees before the data arrives.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Client-side Rendering (CSR): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 49: Server-side Rendering (SSR)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Server-side Rendering (SSR)', 'Render fresh HTML on every request.', 'Make a page dynamic.
Render on the server per request.
Understand when SSR helps.', '## What this lesson covers

Render fresh HTML on every request.

- Server rendering produces HTML per request, so data can be current.
- Dynamic APIs such as cookies or search parameters prevent static caching.
- SSR suits personalised or rapidly changing pages.

## Practice
Create a page that shows the current time and a cookie value, forcing dynamic rendering, then reload to confirm the time changes.', 'Server rendering produces HTML per request, so data can be current.
Dynamic APIs such as cookies or search parameters prevent static caching.
SSR suits personalised or rapidly changing pages.', 'R8ZwbehCGP0', 5, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Make a page dynamic.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render on the server per request.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand when SSR helps.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=R8ZwbehCGP0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Server-side Rendering (SSR)','https://www.youtube.com/results?search_query=Server-side+Rendering+(SSR)'),(@lesson,'Next.js docs: Server rendering','https://nextjs.org/docs/app/building-your-application/rendering/server-components');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Server-side Rendering (SSR)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does server-side rendering produce HTML?','SSR renders per request.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'On each request',1,0),(@q,'Once at build time',0,1),(@q,'Only in the browser',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Reading cookies makes a page dynamic.','Request-specific data prevents static caching.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Server-side Rendering (SSR)','Practise: Render fresh HTML on every request','Create a page that shows the current time and a cookie value, forcing dynamic rendering, then reload to confirm the time changes.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Server-side Rendering (SSR): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 50: Suspense SSR
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Suspense SSR', 'Stream server-rendered HTML with Suspense boundaries.', 'Wrap a slow section in Suspense.
Provide a fallback.
Explain streaming to the browser.', '## What this lesson covers

Stream server-rendered HTML with Suspense boundaries.

- Suspense lets the server send finished parts of the page first.
- The fallback shows while the wrapped section resolves.
- Streaming improves perceived performance for slow data.

## Practice
Wrap a slow product list in a Suspense boundary with skeleton fallback while the page header renders immediately, then throttle the network to see it.', 'Suspense lets the server send finished parts of the page first.
The fallback shows while the wrapped section resolves.
Streaming improves perceived performance for slow data.', 'cwjsoOZVK34', 7, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap a slow section in Suspense.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Provide a fallback.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain streaming to the browser.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=cwjsoOZVK34'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Suspense SSR','https://www.youtube.com/results?search_query=Suspense+SSR'),(@lesson,'Next.js docs: Loading UI and streaming','https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Suspense SSR','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a Suspense fallback show?','The fallback fills the gap while content resolves.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Placeholder UI while the wrapped content loads',1,0),(@q,'An error message',0,1),(@q,'The final content',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Streaming sends the page to the browser in parts.','The server flushes ready sections as they complete.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Suspense SSR','Practise: Stream server-rendered HTML with Suspense boundaries','Wrap a slow product list in a Suspense boundary with skeleton fallback while the page header renders immediately, then throttle the network to see it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Suspense SSR: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 51: React Server Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'React Server Components', 'Understand the default component type in the App Router.', 'Explain what runs on the server.
Keep secrets on the server.
Know what a server component cannot do.', '## What this lesson covers

Understand the default component type in the App Router.

- Server components run only on the server and send no component JavaScript to the browser.
- They can read databases and secrets directly.
- They cannot use browser APIs or state hooks.

## Practice
Convert a data-loading component to a server component that reads data directly, and confirm no "use client" is needed.', 'Server components run only on the server and send no component JavaScript to the browser.
They can read databases and secrets directly.
They cannot use browser APIs or state hooks.', 'Nnr6w8vamUo', 7, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what runs on the server.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep secrets on the server.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know what a server component cannot do.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Nnr6w8vamUo'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: React Server Components','https://www.youtube.com/results?search_query=React+Server+Components'),(@lesson,'Next.js docs: React server components','https://nextjs.org/docs/app/building-your-application/rendering/server-components');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: React Server Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which benefit do server components bring?','Server components keep their code on the server.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Less JavaScript sent to the browser',1,0),(@q,'More browser APIs',0,1),(@q,'Automatic offline mode',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A server component can use useState.','State hooks are for client components.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: React Server Components','Practise: Understand the default component type in the App Router','Convert a data-loading component to a server component that reads data directly, and confirm no "use client" is needed.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','React Server Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 52: Server and Client Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Server and Client Components', 'Split a UI into server and client parts.', 'Identify which parts need interactivity.
Pass data from server to client components.
Keep client leaves small.', '## What this lesson covers

Split a UI into server and client parts.

- Server components can render client components and pass serialisable props.
- Client components cannot import server components directly.
- Pushing interactivity to the leaves keeps the bundle small.

## Practice
Take an interactive filter UI and split it: a server page loads the data, a small client filter renders the buttons, and the server passes the options down as props.', 'Server components can render client components and pass serialisable props.
Client components cannot import server components directly.
Pushing interactivity to the leaves keeps the bundle small.', 'dMCSiA5gzkU', 6, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Identify which parts need interactivity.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass data from server to client components.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep client leaves small.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=dMCSiA5gzkU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Server and Client Components','https://www.youtube.com/results?search_query=Server+and+Client+Components'),(@lesson,'Next.js docs: Server and client composition','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Server and Client Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which direction of composition is allowed?','The server tree can render client leaves.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Server component renders a client component',1,0),(@q,'Client component imports a server component directly',0,1),(@q,'Neither',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Props passed to client components must be serialisable.','The boundary sends data, not functions or class instances.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Server and Client Components','Practise: Split a UI into server and client parts','Take an interactive filter UI and split it: a server page loads the data, a small client filter renders the buttons, and the server passes the options down as props.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Server and Client Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 53: RSC Rendering Lifecycle
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'RSC Rendering Lifecycle', 'Trace what happens between a request and a hydrated page.', 'Describe the server render step.
Explain payload serialisation.
Describe hydration of client components.', '## What this lesson covers

Trace what happens between a request and a hydrated page.

- The server renders the component tree and produces a serialised payload.
- The browser paints HTML, then downloads client bundles for interactive islands.
- Hydration attaches event handlers to the already-rendered HTML.

## Practice
Write a step-by-step timeline of a request to an interactive page: server render, payload, HTML, JavaScript, hydration.', 'The server renders the component tree and produces a serialised payload.
The browser paints HTML, then downloads client bundles for interactive islands.
Hydration attaches event handlers to the already-rendered HTML.', 'aZAMP-4Szgg', 4, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe the server render step.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain payload serialisation.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe hydration of client components.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=aZAMP-4Szgg'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: RSC Rendering Lifecycle','https://www.youtube.com/results?search_query=RSC+Rendering+Lifecycle'),(@lesson,'Next.js docs: Rendering lifecycle','https://nextjs.org/docs/app/building-your-application/rendering/server-components');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: RSC Rendering Lifecycle','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What happens during hydration?','Hydration makes server-rendered markup interactive.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React attaches behaviour to existing HTML',1,0),(@q,'The server restarts',0,1),(@q,'CSS is downloaded',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Server components send component JavaScript for themselves to the browser.','Their code stays on the server.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: RSC Rendering Lifecycle','Practise: Trace what happens between a request and a hydrated page','Write a step-by-step timeline of a request to an interactive page: server render, payload, HTML, JavaScript, hydration.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','RSC Rendering Lifecycle: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 54: Static Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Static Rendering', 'Render pages ahead of time for the fastest first paint.', 'Explain static rendering.
Build a page that is prerendered.
Know what makes a page dynamic.', '## What this lesson covers

Render pages ahead of time for the fastest first paint.

- Static routes are rendered at build time and reused for every request.
- Static pages are fast and cache well at the edge.
- Using request data such as cookies or search parameters makes a route dynamic.

## Practice
Build a blog page that renders at build time, run a production build and read the output route table to confirm it is marked static.', 'Static routes are rendered at build time and reused for every request.
Static pages are fast and cache well at the edge.
Using request data such as cookies or search parameters makes a route dynamic.', 'O6VFEwHujW0', 11, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain static rendering.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build a page that is prerendered.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know what makes a page dynamic.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=O6VFEwHujW0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Static Rendering','https://www.youtube.com/results?search_query=Static+Rendering'),(@lesson,'Next.js docs: Static rendering','https://nextjs.org/docs/app/building-your-application/rendering/server-components#static-rendering-default');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Static Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When is a statically rendered page produced?','Static pages are prepared ahead of requests.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'At build time',1,0),(@q,'On every request',0,1),(@q,'In the browser only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Static rendering is usually faster than per-request rendering.','Work is done once rather than on each request.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Static Rendering','Practise: Render pages ahead of time for the fastest first paint','Build a blog page that renders at build time, run a production build and read the output route table to confirm it is marked static.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Static Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 55: Dynamic Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Dynamic Rendering', 'Render pages per request when data must be fresh.', 'Identify what forces dynamic rendering.
Make a page dynamic on purpose.
Compare the trade-offs.', '## What this lesson covers

Render pages per request when data must be fresh.

- Cookies, headers, search parameters and uncached fetches make a route dynamic.
- Dynamic rendering gives fresh data at the cost of per-request work.
- Choose it for dashboards, carts and anything personalised.

## Practice
Make a products page dynamic because it reads a search parameter, then compare the build output with the static page from the previous lesson.', 'Cookies, headers, search parameters and uncached fetches make a route dynamic.
Dynamic rendering gives fresh data at the cost of per-request work.
Choose it for dashboards, carts and anything personalised.', 'Zmi8Ad8TBYY', 5, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Identify what forces dynamic rendering.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Make a page dynamic on purpose.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Compare the trade-offs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Zmi8Ad8TBYY'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Dynamic Rendering','https://www.youtube.com/results?search_query=Dynamic+Rendering'),(@lesson,'Next.js docs: Dynamic rendering','https://nextjs.org/docs/app/building-your-application/rendering/server-components#dynamic-rendering');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Dynamic Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which of these forces dynamic rendering?','Request data cannot be prerendered.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Reading cookies during the render',1,0),(@q,'A static image',0,1),(@q,'A link component',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Dynamic rendering suits personalised dashboards.','Each visitor sees their own data.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Dynamic Rendering','Practise: Render pages per request when data must be fresh','Make a products page dynamic because it reads a search parameter, then compare the build output with the static page from the previous lesson.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Dynamic Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 56: generateStaticParams
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'generateStaticParams', 'Prebuild dynamic routes with known parameter values.', 'Export generateStaticParams.
Return the parameter combinations.
Confirm the pages build statically.', '## What this lesson covers

Prebuild dynamic routes with known parameter values.

- generateStaticParams tells Next.js which dynamic paths to prerender.
- It returns an array of parameter objects.
- The values come from your data source, so keep the query small.

## Key code
```tsx
export async function generateStaticParams() {
  const products = await getProducts();
  return products.map((p) => ({ id: String(p.id) }));
}
```

## Practice
Add generateStaticParams to a products page so all five known ids are prebuilt, then check the build output.', 'generateStaticParams tells Next.js which dynamic paths to prerender.
It returns an array of parameter objects.
The values come from your data source, so keep the query small.', '09aGB_Q6cqE', 5, 1, 1, 9, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Export generateStaticParams.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return the parameter combinations.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Confirm the pages build statically.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=09aGB_Q6cqE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: generateStaticParams','https://www.youtube.com/results?search_query=generateStaticParams'),(@lesson,'Next.js docs: generateStaticParams','https://nextjs.org/docs/app/api-reference/functions/generate-static-params');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: generateStaticParams','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does generateStaticParams return?','Each object describes one path to prerender.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'An array of parameter objects',1,0),(@q,'A single page component',0,1),(@q,'A fetch promise',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','generateStaticParams only works for dynamic segments.','It supplies values for bracket folders.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: generateStaticParams','Practise: Prebuild dynamic routes with known parameter values','Add generateStaticParams to a products page so all five known ids are prebuilt, then check the build output.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','generateStaticParams: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 57: dynamicParams
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'dynamicParams', 'Control what happens for paths that were not prerendered.', 'Export the dynamicParams flag.
Compare true and false behaviour.', '## What this lesson covers

Control what happens for paths that were not prerendered.

- dynamicParams true renders unknown paths on demand.
- dynamicParams false returns a not-found page for unknown paths.
- Choose false when only a fixed set of pages should exist.

## Practice
Set dynamicParams to false on the products route, then visit an unknown id and confirm the not-found page appears.', 'dynamicParams true renders unknown paths on demand.
dynamicParams false returns a not-found page for unknown paths.
Choose false when only a fixed set of pages should exist.', 'oEF3dyNgmcs', 4, 1, 1, 10, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Export the dynamicParams flag.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Compare true and false behaviour.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=oEF3dyNgmcs'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: dynamicParams','https://www.youtube.com/results?search_query=dynamicParams'),(@lesson,'Next.js docs: dynamicParams','https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config#dynamicparams');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: dynamicParams','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What happens with dynamicParams set to false for an unknown value?','Only the prerendered paths are allowed.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A not-found response',1,0),(@q,'A build error',0,1),(@q,'An empty page',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','dynamicParams controls handling of paths that were not prerendered.','It decides between on-demand rendering and 404 responses.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: dynamicParams','Practise: Control what happens for paths that were not prerendered','Set dynamicParams to false on the products route, then visit an unknown id and confirm the not-found page appears.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','dynamicParams: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 58: Streaming
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Streaming', 'Send HTML progressively with streaming.', 'Explain streaming benefits.
Add loading and Suspense boundaries.
Test on a slow connection.', '## What this lesson covers

Send HTML progressively with streaming.

- Streaming allows the server to flush HTML as sections complete.
- Streaming works with loading files and Suspense fallbacks.
- Slow data no longer blocks the whole page.

## Practice
Add a Suspense boundary around two independent slow sections and throttle the network in developer tools to watch each section arrive separately.', 'Streaming allows the server to flush HTML as sections complete.
Streaming works with loading files and Suspense fallbacks.
Slow data no longer blocks the whole page.', 'oSf1gUDGJOA', 3, 1, 1, 11, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain streaming benefits.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add loading and Suspense boundaries.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Test on a slow connection.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=oSf1gUDGJOA'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Streaming','https://www.youtube.com/results?search_query=Streaming'),(@lesson,'Next.js docs: Streaming','https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Streaming','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why is streaming an advantage?','Fast sections are not blocked by slow ones.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Users see content sooner instead of waiting for the slowest part',1,0),(@q,'It removes the need for CSS',0,1),(@q,'It disables caching',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Streaming only works with client components.','The server streams the rendered output of both kinds of components.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Streaming','Practise: Send HTML progressively with streaming','Add a Suspense boundary around two independent slow sections and throttle the network in developer tools to watch each section arrive separately.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Streaming: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 9: Composition Patterns =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Composition Patterns','Combine server and client code safely.',8);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Composition Patterns',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Composition Patterns');

-- Lesson 59: Server and Client Composition Patterns
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Server and Client Composition Patterns', 'Meet the patterns for combining both component types.', 'Name the main composition patterns.
Recognise which components must be client components.
Plan a component boundary before coding.', '## What this lesson covers

Meet the patterns for combining both component types.

- Decide where the client boundary sits before writing components.
- Keep server components for data and client components for interaction.
- Patterns include server-only code, third-party wrapping and context providers.

## Practice
Sketch a page tree and mark each component as server or client, with a reason for each client boundary.', 'Decide where the client boundary sits before writing components.
Keep server components for data and client components for interaction.
Patterns include server-only code, third-party wrapping and context providers.', 'HQcxPCDwTuE', 1, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name the main composition patterns.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise which components must be client components.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Plan a component boundary before coding.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=HQcxPCDwTuE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Server and Client Composition Patterns','https://www.youtube.com/results?search_query=Server+and+Client+Composition+Patterns'),(@lesson,'Next.js docs: Composition patterns','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Server and Client Composition Patterns','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should decide where a client boundary goes?','Client components are for interactivity and browser APIs.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Where interactivity or browser APIs are needed',1,0),(@q,'Alphabetical file order',0,1),(@q,'The size of the file',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Planning component boundaries saves refactoring later.','Boundaries affect bundling and data flow.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Server and Client Composition Patterns','Practise: Meet the patterns for combining both component types','Sketch a page tree and mark each component as server or client, with a reason for each client boundary.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Server and Client Composition Patterns: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 60: Server-only Code
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Server-only Code', 'Protect secrets with the server-only package.', 'Add a server-only import.
Keep secrets out of client bundles.', '## What this lesson covers

Protect secrets with the server-only package.

- Importing server-only makes the build fail if the module reaches a client bundle.
- Environment secrets must only be read on the server.
- Database and API helpers belong behind that guard.

## Key code
```ts
import "server-only";

export async function getSecretData() {
  const token = process.env.DATABASE_TOKEN;
  return token;
}
```

## Practice
Create a data module that reads a secret from the environment and imports server-only, then try importing it into a client component to see the build error.', 'Importing server-only makes the build fail if the module reaches a client bundle.
Environment secrets must only be read on the server.
Database and API helpers belong behind that guard.', 'BmcGheLzzT0', 5, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a server-only import.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep secrets out of client bundles.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=BmcGheLzzT0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Server-only Code','https://www.youtube.com/results?search_query=Server-only+Code'),(@lesson,'Next.js docs: Keeping secrets on the server','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#keeping-server-only-code-out-of-the-client-environment');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Server-only Code','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does importing server-only do?','It is a build-time guard for server code.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Fails the build if the module is imported into a client bundle',1,0),(@q,'Makes the file public',0,1),(@q,'Disables caching',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Secrets read in a server component reach the browser bundle.','Server component code is not shipped to the browser.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Server-only Code','Practise: Protect secrets with the server-only package','Create a data module that reads a secret from the environment and imports server-only, then try importing it into a client component to see the build error.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Server-only Code: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 61: Third Party Packages
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Third Party Packages', 'Wrap client-only third-party components.', 'Identify a package that needs the browser.
Create a thin client wrapper.
Use it from a server component.', '## What this lesson covers

Wrap client-only third-party components.

- Many packages assume a browser and need a client component wrapper.
- Wrapping keeps the third-party dependency out of your server code.
- Only the wrapper needs "use client", not the whole page.

## Practice
Wrap a carousel library from npm in a client component with a small props API, then use it inside a server page.', 'Many packages assume a browser and need a client component wrapper.
Wrapping keeps the third-party dependency out of your server code.
Only the wrapper needs "use client", not the whole page.', 'FJvUhHiihIQ', 5, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Identify a package that needs the browser.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a thin client wrapper.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use it from a server component.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=FJvUhHiihIQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Third Party Packages','https://www.youtube.com/results?search_query=Third+Party+Packages'),(@lesson,'Next.js docs: Using third-party packages','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#using-third-party-packages-and-providers');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Third Party Packages','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why wrap a client-only package?','A thin wrapper keeps interactivity at the leaf.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'To keep the client boundary small and the page on the server',1,0),(@q,'Because npm requires it',0,1),(@q,'To slow the build',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Adding "use client" to a page turns all of its imported modules into client code.','The directive marks the boundary for the module graph below it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Third Party Packages','Practise: Wrap client-only third-party components','Wrap a carousel library from npm in a client component with a small props API, then use it inside a server page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Third Party Packages: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 62: Context Providers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Context Providers', 'Provide React context without turning everything into client code.', 'Create a client provider component.
Wrap children in a server layout.
Pass initial values from the server.', '## What this lesson covers

Provide React context without turning everything into client code.

- Context lives in a client component because providers use hooks.
- The layout stays a server component and renders the provider around children.
- Pass server data into the provider as initial props.

## Key code
```tsx
"use client";
import { createContext, useContext, useState } from "react";
const ThemeContext = createContext("light");

export function ThemeProvider({ initial, children }: { initial: string; children: React.ReactNode }) {
  const [theme] = useState(initial);
  return <ThemeContext.Provider value={theme}>{children}</ThemeContext.Provider>;
}
export const useTheme = () => useContext(ThemeContext);
```

## Practice
Create a ThemeProvider client component that accepts an initial theme from the server and provides it to the tree through a layout.', 'Context lives in a client component because providers use hooks.
The layout stays a server component and renders the provider around children.
Pass server data into the provider as initial props.', 'ebOgXUPG3_k', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a client provider component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap children in a server layout.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass initial values from the server.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=ebOgXUPG3_k'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Context Providers','https://www.youtube.com/results?search_query=Context+Providers'),(@lesson,'Next.js docs: Context providers','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#using-context-providers');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Context Providers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where must a React context provider be defined?','Providers use client-side React features.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In a client component',1,0),(@q,'In a server component',0,1),(@q,'In the middleware',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Wrapping children in a client provider turns those children into client components automatically.','Children passed through from the server stay server components.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Context Providers','Practise: Provide React context without turning everything into client code','Create a ThemeProvider client component that accepts an initial theme from the server and provides it to the tree through a layout.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Context Providers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 63: Client-only Code
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Client-only Code', 'Handle code that only makes sense in the browser.', 'Use useEffect for browser-only work.
Guard against missing browser globals.
Keep client-only code out of the server render.', '## What this lesson covers

Handle code that only makes sense in the browser.

- Browser APIs such as window and localStorage do not exist during server rendering.
- useEffect runs only in the browser after mount.
- Reading browser state during render can cause hydration mismatches.

## Key code
```tsx
"use client";
import { useEffect, useState } from "react";

export function SavedName() {
  const [name, setName] = useState<string | null>(null);
  useEffect(() => { setName(localStorage.getItem("name")); }, []);
  return <span>{name ?? "Guest"}</span>;
}
```

## Practice
Build a component that reads a saved value from localStorage inside useEffect and renders a neutral placeholder before mount.', 'Browser APIs such as window and localStorage do not exist during server rendering.
useEffect runs only in the browser after mount.
Reading browser state during render can cause hydration mismatches.', 'zVRVMTTVHes', 4, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use useEffect for browser-only work.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Guard against missing browser globals.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep client-only code out of the server render.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=zVRVMTTVHes'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Client-only Code','https://www.youtube.com/results?search_query=Client-only+Code'),(@lesson,'Next.js docs: Client-only code','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#client-components');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Client-only Code','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which hook is the right place for localStorage access?','Effects run in the browser after mount.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'useEffect',1,0),(@q,'useState initialiser on the server',0,1),(@q,'render body directly',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Reading window during the server render causes an error.','Browser globals are undefined on the server.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Client-only Code','Practise: Handle code that only makes sense in the browser','Build a component that reads a saved value from localStorage inside useEffect and renders a neutral placeholder before mount.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Client-only Code: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 64: Client Component Placement
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Client Component Placement', 'Place client components low in the tree.', 'Push client components to the leaves.
Pass server-rendered children into a client component.
Measure the effect on the bundle.', '## What this lesson covers

Place client components low in the tree.

- Small client leaves keep most of the page on the server.
- A client component can accept server-rendered children as props.
- Moving interactive parts down reduces shipped JavaScript.

## Practice
Refactor a page so a client layout shell accepts server-rendered content as children instead of importing the content itself.', 'Small client leaves keep most of the page on the server.
A client component can accept server-rendered children as props.
Moving interactive parts down reduces shipped JavaScript.', 'yJNuVay1SHw', 5, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Push client components to the leaves.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass server-rendered children into a client component.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Measure the effect on the bundle.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=yJNuVay1SHw'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Client Component Placement','https://www.youtube.com/results?search_query=Client+Component+Placement'),(@lesson,'Next.js docs: Moving client components down the tree','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#moving-client-components-down-the-tree');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Client Component Placement','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which placement keeps the most code on the server?','Small client leaves keep the tree server-side.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Client components at the leaves of the tree',1,0),(@q,'A client component at the root',0,1),(@q,'Every component as client',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A client component can render server-rendered children passed as props.','Children created on the server can pass through a client wrapper.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Client Component Placement','Practise: Place client components low in the tree','Refactor a page so a client layout shell accepts server-rendered content as children instead of importing the content itself.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Client Component Placement: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 65: Interleaving Server and Client Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Interleaving Server and Client Components', 'Mix both component types in one feature.', 'Build a feature with server data and client interaction.
Pass server content into client wrappers.
Avoid unsupported patterns.', '## What this lesson covers

Mix both component types in one feature.

- Supported patterns pass server output as children or props into client components.
- You cannot import a server component into a client module.
- Data flows down as props; events flow up as callbacks inside client components.

## Practice
Build a filterable product grid: a server component loads products, a client component owns the filter state and renders the server-provided list.', 'Supported patterns pass server output as children or props into client components.
You cannot import a server component into a client module.
Data flows down as props; events flow up as callbacks inside client components.', 'PM_STAq4MSg', 8, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build a feature with server data and client interaction.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass server content into client wrappers.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Avoid unsupported patterns.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=PM_STAq4MSg'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Interleaving Server and Client Components','https://www.youtube.com/results?search_query=Interleaving+Server+and+Client+Components'),(@lesson,'Next.js docs: Interleaving server and client components','https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Interleaving Server and Client Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How can a client component display server-rendered content?','Pass server output into the client component.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'By receiving it as children or props',1,0),(@q,'By importing it',0,1),(@q,'By fetching it again in the browser',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A client component cannot import a server component file.','The server tree renders client components, not the reverse.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Interleaving Server and Client Components','Practise: Mix both component types in one feature','Build a filterable product grid: a server component loads products, a client component owns the filter state and renders the server-provided list.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Interleaving Server and Client Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 10: Data Fetching =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Data Fetching','Load data on the server and in the browser.',9);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Data Fetching',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Data Fetching');

-- Lesson 66: Data Fetching
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Data Fetching', 'Meet the ways to fetch data in the App Router.', 'Name server and client fetching options.
Choose where data should be loaded.
Plan loading and error handling.', '## What this lesson covers

Meet the ways to fetch data in the App Router.

- Server components can await data directly during render.
- Client components fetch in an effect or with a library such as SWR.
- Prefer fetching on the server unless the data depends on browser interaction.

## Practice
List three pages in your practice project and decide, for each, whether the data should load on the server or in the browser, with a reason.', 'Server components can await data directly during render.
Client components fetch in an effect or with a library such as SWR.
Prefer fetching on the server unless the data depends on browser interaction.', 'DRsU93Lde2k', 2, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name server and client fetching options.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose where data should be loaded.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Plan loading and error handling.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=DRsU93Lde2k'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Data Fetching','https://www.youtube.com/results?search_query=Data+Fetching'),(@lesson,'Next.js docs: Fetching data','https://nextjs.org/docs/app/getting-started/fetching-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Data Fetching','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where should most page data be fetched in the App Router?','Server fetching keeps secrets safe and reduces client work.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'On the server',1,0),(@q,'In the browser always',0,1),(@q,'Inside CSS',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A server component can await a database call directly.','Server components are async and run on the server.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Data Fetching','Practise: Meet the ways to fetch data in the App Router','List three pages in your practice project and decide, for each, whether the data should load on the server or in the browser, with a reason.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Data Fetching: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 67: Fetching Data in Client Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching Data in Client Components', 'Fetch data in the browser and handle loading.', 'Fetch inside an effect.
Track loading and error state.
Show a useful empty state.', '## What this lesson covers

Fetch data in the browser and handle loading.

- Client fetching runs after the component mounts.
- You must handle loading, error and empty states yourself.
- Data libraries reduce boilerplate for caching and revalidation.

## Key code
```tsx
"use client";
import { useEffect, useState } from "react";

type Product = { id: number; name: string };

export function ProductList() {
  const [items, setItems] = useState<Product[]>([]);
  const [state, setState] = useState<"loading" | "error" | "done">("loading");

  useEffect(() => {
    fetch("/api/products")
      .then((r) => { if (!r.ok) throw new Error("Request failed"); return r.json(); })
      .then((d) => { setItems(d.data); setState("done"); })
      .catch(() => setState("error"));
  }, []);

  if (state === "loading") return <p>Loading...</p>;
  if (state === "error") return <p className="text-red-600">Could not load products.</p>;
  return <ul>{items.map((p) => <li key={p.id}>{p.name}</li>)}</ul>;
}
```

## Practice
Build a client component that fetches /api/products with loading, error and empty states, then test by stopping the API.', 'Client fetching runs after the component mounts.
You must handle loading, error and empty states yourself.
Data libraries reduce boilerplate for caching and revalidation.', '7Kz4--kCBP0', 4, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Fetch inside an effect.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Track loading and error state.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Show a useful empty state.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7Kz4--kCBP0'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Fetching Data in Client Components','https://www.youtube.com/results?search_query=Fetching+Data+in+Client+Components'),(@lesson,'Next.js docs: Client-side fetching','https://nextjs.org/docs/app/getting-started/fetching-data#client-components');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching Data in Client Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does a client-side fetch start?','The request happens in the browser.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'After the component mounts in the browser',1,0),(@q,'During the server render',0,1),(@q,'At build time',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Client fetching requires handling loading and error states yourself.','The component owns those states.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching Data in Client Components','Practise: Fetch data in the browser and handle loading','Build a client component that fetches /api/products with loading, error and empty states, then test by stopping the API.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching Data in Client Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 68: Fetching Data in Server Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching Data in Server Components', 'Await data directly inside a server component.', 'Make the page async.
Await the data source.
Render the result on the server.', '## What this lesson covers

Await data directly inside a server component.

- An async server component can await any async function.
- The data is available before HTML is sent, so no loading spinner is needed.
- Secrets and database clients stay on the server.

## Key code
```tsx
export default async function Page() {
  const products = await getProducts();
  return <ul>{products.map((p) => <li key={p.id}>{p.name}</li>)}</ul>;
}
```

## Practice
Move the product list fetch into an async server component that awaits a data function and renders the result.', 'An async server component can await any async function.
The data is available before HTML is sent, so no loading spinner is needed.
Secrets and database clients stay on the server.', 'WKfPctdIDek', 4, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Make the page async.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Await the data source.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render the result on the server.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=WKfPctdIDek'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Fetching Data in Server Components','https://www.youtube.com/results?search_query=Fetching+Data+in+Server+Components'),(@lesson,'Next.js docs: Server-side fetching','https://nextjs.org/docs/app/getting-started/fetching-data#server-components');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching Data in Server Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How does a server component obtain data before rendering?','Server components can await during render.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It awaits the data in the async component body',1,0),(@q,'It waits for the browser',0,1),(@q,'It uses window.fetch in render',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Server fetching can remove the need for a loading spinner on first paint.','The HTML arrives with the data already applied.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching Data in Server Components','Practise: Await data directly inside a server component','Move the product list fetch into an async server component that awaits a data function and renders the result.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching Data in Server Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 69: Loading and Error States
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Loading and Error States', 'Add loading and error files to a data-driven route.', 'Create loading and error files.
Match the skeleton to the real layout.
Keep error messages helpful.', '## What this lesson covers

Add loading and error files to a data-driven route.

- loading.tsx and error.tsx wrap the whole segment.
- Skeletons should mirror the final layout to avoid jumps.
- Error text should tell the user what to do next.

## Practice
Add loading and error files to the products route, with a skeleton grid and an error message that includes a retry button.', 'loading.tsx and error.tsx wrap the whole segment.
Skeletons should mirror the final layout to avoid jumps.
Error text should tell the user what to do next.', 'jdLSKIzvKnk', 3, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create loading and error files.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Match the skeleton to the real layout.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep error messages helpful.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=jdLSKIzvKnk'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Loading and Error States','https://www.youtube.com/results?search_query=Loading+and+Error+States'),(@lesson,'Next.js docs: loading and error files','https://nextjs.org/docs/app/api-reference/file-conventions/loading');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Loading and Error States','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pair of files adds loading and error UI to a segment?','The two special files provide those states.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'loading.tsx and error.tsx',1,0),(@q,'wait.tsx and fail.tsx',0,1),(@q,'spinner.tsx and crash.tsx',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A loading skeleton should match the shape of the real content.','Matching shapes reduce layout shift.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Loading and Error States','Practise: Add loading and error files to a data-driven route','Add loading and error files to the products route, with a skeleton grid and an error message that includes a retry button.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Loading and Error States: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 70: Sequential Data Fetching
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Sequential Data Fetching', 'Fetch dependent data in order.', 'Await one request, then another that needs the first result.
Recognise the performance cost.
Identify which calls truly depend on each other.', '## What this lesson covers

Fetch dependent data in order.

- Sequential fetching is required when the second request needs the first result.
- Each await blocks the next, so waterfalls slow the page down.
- Only sequence requests that genuinely depend on each other.

## Key code
```tsx
const product = await getProduct(id);
const reviews = await getReviews(product.id); // depends on the product
```

## Practice
Write a page that fetches a product, then its reviews by product id, and measure the total time with the network throttled.', 'Sequential fetching is required when the second request needs the first result.
Each await blocks the next, so waterfalls slow the page down.
Only sequence requests that genuinely depend on each other.', 'Fo4BZtzV2xQ', 5, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Await one request, then another that needs the first result.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise the performance cost.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Identify which calls truly depend on each other.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Fo4BZtzV2xQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Sequential Data Fetching','https://www.youtube.com/results?search_query=Sequential+Data+Fetching'),(@lesson,'Next.js docs: Sequential data fetching','https://nextjs.org/docs/app/getting-started/fetching-data#sequential');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Sequential Data Fetching','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When is sequential fetching necessary?','Dependencies force ordering.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'When a later request needs data from an earlier one',1,0),(@q,'Always',0,1),(@q,'Only in client components',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Sequential fetching can create slow request waterfalls.','Each request waits for the previous one.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Sequential Data Fetching','Practise: Fetch dependent data in order','Write a page that fetches a product, then its reviews by product id, and measure the total time with the network throttled.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Sequential Data Fetching: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 71: Parallel Data Fetching
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Parallel Data Fetching', 'Load independent data at the same time.', 'Start requests together with Promise.all.
Compare the timing with sequential fetching.
Keep error handling clear.', '## What this lesson covers

Load independent data at the same time.

- Promise.all starts all requests before awaiting any of them.
- Independent requests finish in roughly the slowest single request time.
- If one request fails, treat the whole group as failed or handle each separately.

## Key code
```tsx
const [product, reviews] = await Promise.all([getProduct(id), getReviews(id)]);
```

## Practice
Refactor the product page so the product and its reviews load in parallel where possible, and note the new timing.', 'Promise.all starts all requests before awaiting any of them.
Independent requests finish in roughly the slowest single request time.
If one request fails, treat the whole group as failed or handle each separately.', 'TLcuO9anpPo', 6, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Start requests together with Promise.all.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Compare the timing with sequential fetching.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep error handling clear.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=TLcuO9anpPo'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Parallel Data Fetching','https://www.youtube.com/results?search_query=Parallel+Data+Fetching'),(@lesson,'Next.js docs: Parallel data fetching','https://nextjs.org/docs/app/getting-started/fetching-data#parallel');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Parallel Data Fetching','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which technique starts several independent requests together?','Promise.all runs the promises concurrently.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Promise.all([a, b])',1,0),(@q,'await a; await b;',0,1),(@q,'setTimeout chains',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Parallel fetching helps only when the requests are independent.','Dependent requests must still wait for each other.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Parallel Data Fetching','Practise: Load independent data at the same time','Refactor the product page so the product and its reviews load in parallel where possible, and note the new timing.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Parallel Data Fetching: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 72: Fetching from a Database
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching from a Database', 'Query a database from a server component.', 'Create a small database client.
Query inside a server-only module.
Render the rows.', '## What this lesson covers

Query a database from a server component.

- Database code belongs in a server-only module.
- An async server component can await the query and render rows.
- Keep connection details in environment variables.

## Key code
```ts
import "server-only";
import { sql } from "./db";

export async function getOrders() {
  const rows = await sql`SELECT id, total FROM orders ORDER BY id DESC LIMIT 20`;
  return rows as { id: number; total: number }[];
}
```

## Practice
Add a data module that reads from a database or a JSON file behind a server-only guard, then render a table of records and handle the empty case.', 'Database code belongs in a server-only module.
An async server component can await the query and render rows.
Keep connection details in environment variables.', 'IUeSwzvz9i4', 7, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a small database client.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Query inside a server-only module.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render the rows.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=IUeSwzvz9i4'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Fetching from a Database','https://www.youtube.com/results?search_query=Fetching+from+a+Database'),(@lesson,'Next.js docs: Database access','https://nextjs.org/docs/app/getting-started/fetching-data#with-a-database');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching from a Database','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where should the database client live?','Database access must never reach the browser.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In a server-only module used by server components',1,0),(@q,'In a client component',0,1),(@q,'In the CSS file',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Connection strings belong in environment variables.','Secrets stay out of source control.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching from a Database','Practise: Query a database from a server component','Add a data module that reads from a database or a JSON file behind a server-only guard, then render a table of records and handle the empty case.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching from a Database: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 11: Data Mutations and Forms =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Data Mutations and Forms','Change data with server actions and forms.',10);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Data Mutations and Forms',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Data Mutations and Forms');

-- Lesson 73: Data Mutations
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Data Mutations', 'Understand how to change data safely.', 'Name the ways to mutate data.
Explain why validation happens on the server.
Plan a form submit flow.', '## What this lesson covers

Understand how to change data safely.

- Mutations can go through route handlers or server actions.
- Server actions are functions that run on the server and can be called from forms.
- Always validate and authorise on the server.

## Practice
Write the flow for creating a product from a form: browser submit, server validation, database write, revalidation and the user feedback.', 'Mutations can go through route handlers or server actions.
Server actions are functions that run on the server and can be called from forms.
Always validate and authorise on the server.', 'F8DB4LM1dME', 3, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name the ways to mutate data.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why validation happens on the server.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Plan a form submit flow.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=F8DB4LM1dME'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Data Mutations','https://www.youtube.com/results?search_query=Data+Mutations'),(@lesson,'Next.js docs: Mutating data','https://nextjs.org/docs/app/getting-started/updating-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Data Mutations','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which form of mutation runs on the server and is callable from a form?','Server actions run on the server.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A server action',1,0),(@q,'A client effect',0,1),(@q,'A CSS transition',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Client-side validation replaces the need for server validation.','The server must always validate.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Data Mutations','Practise: Understand how to change data safely','Write the flow for creating a product from a form: browser submit, server validation, database write, revalidation and the user feedback.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Data Mutations: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 74: Forms with Server Actions
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Forms with Server Actions', 'Submit forms without hand-written API endpoints.', 'Declare a server action with "use server".
Pass it to a form action.
Read the submitted form data.', '## What this lesson covers

Submit forms without hand-written API endpoints.

- A server action is an async function marked with "use server".
- A form action can call the action directly.
- Use revalidatePath to refresh the page data after a write.

## Key code
```tsx
// app/products/actions.ts
"use server";
import { revalidatePath } from "next/cache";

export async function createProduct(formData: FormData) {
  const name = String(formData.get("name") ?? "").trim();
  if (!name) return;
  await db.products.create({ name });
  revalidatePath("/products");
}
```

## Practice
Build a form that creates a product through a server action, validates the name, writes the record and revalidates the list page.', 'A server action is an async function marked with "use server".
A form action can call the action directly.
Use revalidatePath to refresh the page data after a write.', 'xWFbnrTap3M', 6, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Declare a server action with "use server".',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass it to a form action.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the submitted form data.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=xWFbnrTap3M'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Forms with Server Actions','https://www.youtube.com/results?search_query=Forms+with+Server+Actions'),(@lesson,'Next.js docs: Server actions','https://nextjs.org/docs/app/api-reference/directives/use-server');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Forms with Server Actions','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which directive marks a function as a server action?','The directive marks server-side functions.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'"use server"',1,0),(@q,'"server action"',0,1),(@q,'"use client"',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','revalidatePath refreshes cached data for a route after a mutation.','Revalidation keeps the UI in step with the database.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Forms with Server Actions','Practise: Submit forms without hand-written API endpoints','Build a form that creates a product through a server action, validates the name, writes the record and revalidates the list page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Forms with Server Actions: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 75: Pending State with useFormStatus
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Pending State with useFormStatus', 'Show a pending state while a form submits.', 'Create a submit button component.
Read pending from useFormStatus.
Disable the button while pending.', '## What this lesson covers

Show a pending state while a form submits.

- useFormStatus must be used inside a child component of the form.
- pending is true while the action runs.
- Disable the submit button to prevent double submits.

## Key code
```tsx
"use client";
import { useFormStatus } from "react-dom";

export function SubmitButton() {
  const { pending } = useFormStatus();
  return <button disabled={pending} className="px-4 py-2 rounded bg-indigo-600 text-white disabled:opacity-60">
    {pending ? "Saving..." : "Save"}
  </button>;
}
```

## Practice
Add a SubmitButton client component that uses useFormStatus to disable itself and show "Saving..." while the action runs.', 'useFormStatus must be used inside a child component of the form.
pending is true while the action runs.
Disable the submit button to prevent double submits.', 'o3M7RmsyiBU', 4, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a submit button component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read pending from useFormStatus.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Disable the button while pending.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=o3M7RmsyiBU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Pending State with useFormStatus','https://www.youtube.com/results?search_query=Pending+State+with+useFormStatus'),(@lesson,'Next.js docs: useFormStatus','https://nextjs.org/docs/app/api-reference/functions/use-form-status');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Pending State with useFormStatus','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where must useFormStatus be called?','The hook reads the status of the nearest form.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Inside a component rendered within the form',1,0),(@q,'In the form action only',0,1),(@q,'In the layout',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Disabling the submit button while pending prevents double submission.','A pending state prevents duplicate writes.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Pending State with useFormStatus','Practise: Show a pending state while a form submits','Add a SubmitButton client component that uses useFormStatus to disable itself and show "Saving..." while the action runs.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Pending State with useFormStatus: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 76: Form Validation with useActionState
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Form Validation with useActionState', 'Return validation errors from a server action.', 'Wrap the action with useActionState.
Return an error state from the action.
Render field errors.', '## What this lesson covers

Return validation errors from a server action.

- useActionState holds the value returned by the action and a pending flag.
- The action returns a plain object describing errors or success.
- Errors must be shown next to the field they belong to.

## Key code
```tsx
"use client";
import { useActionState } from "react";

const [state, formAction] = useActionState(createAccount, { error: "" });
return (
  <form action={formAction}>
    <input name="email" className="border p-2" />
    {state.error && <p className="text-sm text-red-600">{state.error}</p>}
    <button className="mt-2 px-4 py-2 rounded bg-indigo-600 text-white">Create account</button>
  </form>
);
```

## Practice
Build a registration form whose server action returns field errors, display them under each field and reset them on success.', 'useActionState holds the value returned by the action and a pending flag.
The action returns a plain object describing errors or success.
Errors must be shown next to the field they belong to.', '4-3K7SgoVf4', 7, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap the action with useActionState.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return an error state from the action.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render field errors.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=4-3K7SgoVf4'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Form Validation with useActionState','https://www.youtube.com/results?search_query=Form+Validation+with+useActionState'),(@lesson,'Next.js docs: useActionState','https://nextjs.org/docs/app/api-reference/functions/use-action-state');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Form Validation with useActionState','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does useActionState give the form?','The hook returns state and pending.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The action result plus a pending flag',1,0),(@q,'Only the pending flag',0,1),(@q,'A database connection',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Server actions can return validation errors to the form.','Returning a state object is the standard pattern.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Form Validation with useActionState','Practise: Return validation errors from a server action','Build a registration form whose server action returns field errors, display them under each field and reset them on success.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Form Validation with useActionState: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 77: Separating Server Actions
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Separating Server Actions', 'Move server actions into their own files.', 'Create an actions file with "use server".
Import the action into a form.
Keep actions testable and reusable.', '## What this lesson covers

Move server actions into their own files.

- A file that starts with "use server" exports server actions.
- Actions files keep components focused on rendering.
- Actions can be shared between several forms.

## Practice
Move the create action from the page into app/products/actions.ts, import it into the form and confirm it still works.', 'A file that starts with "use server" exports server actions.
Actions files keep components focused on rendering.
Actions can be shared between several forms.', 'UiQpt9b_ei4', 4, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create an actions file with "use server".',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Import the action into a form.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep actions testable and reusable.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=UiQpt9b_ei4'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Separating Server Actions','https://www.youtube.com/results?search_query=Separating+Server+Actions'),(@lesson,'Next.js docs: Server action files','https://nextjs.org/docs/app/api-reference/directives/use-server#server-action-files');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Separating Server Actions','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which directive turns a whole module into server actions?','The first line marks the module.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'"use server" at the top of the file',1,0),(@q,'"use client"',0,1),(@q,'export default',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A shared actions file can be imported by several forms.','Keeping actions separate makes them reusable.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Separating Server Actions','Practise: Move server actions into their own files','Move the create action from the page into app/products/actions.ts, import it into the form and confirm it still works.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Separating Server Actions: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 78: useFormStatus vs useActionState
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useFormStatus vs useActionState', 'Choose the right hook for form feedback.', 'Compare the two hooks.
Pick one for a simple pending state.
Pick one for validation feedback.', '## What this lesson covers

Choose the right hook for form feedback.

- useFormStatus gives pending information for the nearest form.
- useActionState carries the returned state and pending flag for one action.
- Use both together: status for the button, state for messages.

## Practice
Add both hooks to one form: a SubmitButton using useFormStatus and an error summary using useActionState, and describe which does what.', 'useFormStatus gives pending information for the nearest form.
useActionState carries the returned state and pending flag for one action.
Use both together: status for the button, state for messages.', 'qpA-eGxASxo', 2, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Compare the two hooks.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pick one for a simple pending state.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pick one for validation feedback.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=qpA-eGxASxo'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: useFormStatus vs useActionState','https://www.youtube.com/results?search_query=useFormStatus+vs+useActionState'),(@lesson,'Next.js docs: Form handling','https://nextjs.org/docs/app/getting-started/updating-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useFormStatus vs useActionState','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which hook is designed to carry an action result?','useActionState holds the returned value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'useActionState',1,0),(@q,'useFormStatus',0,1),(@q,'useOptimistic',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The two hooks can be used in the same form.','They cover different concerns.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useFormStatus vs useActionState','Practise: Choose the right hook for form feedback','Add both hooks to one form: a SubmitButton using useFormStatus and an error summary using useActionState, and describe which does what.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useFormStatus vs useActionState: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 79: Update Server Action
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Update Server Action', 'Update an existing record with a server action.', 'Load the record for an edit form.
Submit the changes to an update action.
Revalidate the list and detail pages.', '## What this lesson covers

Update an existing record with a server action.

- An edit form is prefilled with the current values from the database.
- The action updates by id and validates the input again.
- Revalidate every route that shows the changed data.

## Key code
```ts
"use server";
export async function updateProduct(id: number, formData: FormData) {
  const name = String(formData.get("name") ?? "").trim();
  if (!name) return { error: "Name is required" };
  await db.products.update(id, { name });
  revalidatePath("/products");
  revalidatePath(`/products/${id}`);
  return { ok: true };
}
```

## Practice
Build an edit page for a product with a prefilled form and an update action that writes the changes, then revalidates both the list and the detail route.', 'An edit form is prefilled with the current values from the database.
The action updates by id and validates the input again.
Revalidate every route that shows the changed data.', 'SbaKEqCRcDE', 9, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Load the record for an edit form.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Submit the changes to an update action.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Revalidate the list and detail pages.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=SbaKEqCRcDE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Update Server Action','https://www.youtube.com/results?search_query=Update+Server+Action'),(@lesson,'Next.js docs: Updating data','https://nextjs.org/docs/app/getting-started/updating-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Update Server Action','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should an update action do after writing?','Revalidation refreshes cached data.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Revalidate the affected routes',1,0),(@q,'Reload the whole page',0,1),(@q,'Nothing',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Update actions must validate input again even if the form did.','Client validation is never enough.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Update Server Action','Practise: Update an existing record with a server action','Build an edit page for a product with a prefilled form and an update action that writes the changes, then revalidates both the list and the detail route.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Update Server Action: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 80: Delete Server Action
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Delete Server Action', 'Delete a record from a form.', 'Add a delete action.
Confirm before deleting.
Revalidate the list.', '## What this lesson covers

Delete a record from a form.

- A delete action receives an id and removes the record.
- Deleting is destructive, so ask for confirmation.
- Revalidation removes the deleted row from cached pages.

## Practice
Add a delete button beside each product that submits a delete action after a confirmation step, then confirm the row disappears.', 'A delete action receives an id and removes the record.
Deleting is destructive, so ask for confirmation.
Revalidation removes the deleted row from cached pages.', 'oi71gLPFQtk', 4, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a delete action.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Confirm before deleting.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Revalidate the list.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=oi71gLPFQtk'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Delete Server Action','https://www.youtube.com/results?search_query=Delete+Server+Action'),(@lesson,'Next.js docs: Deleting data','https://nextjs.org/docs/app/getting-started/updating-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Delete Server Action','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why confirm before a delete?','Confirmation prevents accidental data loss.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The action is destructive and hard to undo',1,0),(@q,'Because forms require it',0,1),(@q,'To slow the user down',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A delete action should revalidate the list page.','Otherwise the removed row can remain cached.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Delete Server Action','Practise: Delete a record from a form','Add a delete button beside each product that submits a delete action after a confirmation step, then confirm the row disappears.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Delete Server Action: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 81: Optimistic Updates
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Optimistic Updates', 'Show a change instantly with useOptimistic.', 'Create optimistic state.
Apply the change before the server replies.
Roll back on failure.', '## What this lesson covers

Show a change instantly with useOptimistic.

- useOptimistic shows a temporary state while the action runs.
- The server response replaces the temporary state.
- On failure the optimistic change disappears, so always show the error.

## Key code
```tsx
const [optimisticLikes, addLike] = useOptimistic(likes, (state, amount: number) => state + amount);
```

## Practice
Add an optimistic like button that increments immediately and falls back to the server value when the action fails.', 'useOptimistic shows a temporary state while the action runs.
The server response replaces the temporary state.
On failure the optimistic change disappears, so always show the error.', 'ipmfUw8I2qc', 6, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create optimistic state.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Apply the change before the server replies.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Roll back on failure.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=ipmfUw8I2qc'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Optimistic Updates','https://www.youtube.com/results?search_query=Optimistic+Updates'),(@lesson,'Next.js docs: useOptimistic','https://nextjs.org/docs/app/api-reference/functions/use-optimistic');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Optimistic Updates','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does an optimistic update do?','It improves perceived speed.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Shows the expected result instantly before the server confirms it',1,0),(@q,'Skips the server call',0,1),(@q,'Caches forever',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An optimistic update is discarded if the action fails.','The real state replaces it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Optimistic Updates','Practise: Show a change instantly with useOptimistic','Add an optimistic like button that increments immediately and falls back to the server value when the action fails.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Optimistic Updates: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 82: Form Component
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Form Component', 'Use the Next.js form component with client-side navigation.', 'Import the form component.
Handle prefetching and pending UI.
Reset a form after success.', '## What this lesson covers

Use the Next.js form component with client-side navigation.

- next/form gives you client navigation and prefetching for search forms.
- It performs a client-side navigation with the submitted values as a query string.
- It suits search and filter forms rather than data writes.

## Key code
```tsx
import Form from "next/form";

export default function Search() {
  return (
    <Form action="/products" className="flex gap-2">
      <input name="q" className="border p-2" placeholder="Search products" />
      <button className="px-4 py-2 rounded bg-indigo-600 text-white">Search</button>
    </Form>
  );
}
```

## Practice
Replace a search form with next/form so submitting it navigates to /products?q=... without a full reload.', 'next/form gives you client navigation and prefetching for search forms.
It performs a client-side navigation with the submitted values as a query string.
It suits search and filter forms rather than data writes.', '8CYDkIncDSw', 8, 1, 1, 9, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Import the form component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Handle prefetching and pending UI.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reset a form after success.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=8CYDkIncDSw'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Form Component','https://www.youtube.com/results?search_query=Form+Component'),(@lesson,'Next.js docs: Form component','https://nextjs.org/docs/app/api-reference/components/form');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Form Component','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is next/form best suited for?','It navigates with the query string.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Search and filter forms that change the URL',1,0),(@q,'Writing to a database',0,1),(@q,'Uploading large files',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','next/form performs a full page reload.','It uses client-side navigation.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Form Component','Practise: Use the Next.js form component with client-side navigation','Replace a search form with next/form so submitting it navigates to /products?q=... without a full reload.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Form Component: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 12: Authentication with Clerk =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Authentication with Clerk','Add sign in, protected routes and roles.',11);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Authentication with Clerk',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Authentication with Clerk');

-- Lesson 83: Authentication
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Authentication', 'Plan authentication for a Next.js application.', 'Explain the pieces of an auth system.
Choose a provider.
Plan protected areas of the app.', '## What this lesson covers

Plan authentication for a Next.js application.

- Authentication proves identity; authorisation decides what an identity may do.
- Session data is read on the server before rendering protected content.
- Clerk is one hosted provider that handles sign in, sessions and profiles.

## Practice
List the routes in your project and mark each as public or protected, with the rule that should apply.', 'Authentication proves identity; authorisation decides what an identity may do.
Session data is read on the server before rendering protected content.
Clerk is one hosted provider that handles sign in, sessions and profiles.', 'X3CHpXpeQ0c', 2, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the pieces of an auth system.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose a provider.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Plan protected areas of the app.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=X3CHpXpeQ0c'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Authentication','https://www.youtube.com/results?search_query=Authentication'),(@lesson,'Next.js docs: Authentication','https://nextjs.org/docs/app/building-your-application/authentication');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Authentication','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is the difference between authentication and authorisation?','Identity comes first, then permissions.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Authentication proves identity; authorisation decides permissions',1,0),(@q,'They are the same',0,1),(@q,'Authorisation proves identity',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Protected pages should be checked on the server.','Client checks can be bypassed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Authentication','Practise: Plan authentication for a Next.js application','List the routes in your project and mark each as public or protected, with the rule that should apply.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Authentication: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 84: Clerk Setup
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Clerk Setup', 'Install and configure Clerk in a Next.js project.', 'Create a Clerk application.
Add the environment keys.
Wrap the app in the Clerk provider.', '## What this lesson covers

Install and configure Clerk in a Next.js project.

- Clerk needs a publishable key and a secret key in the environment.
- The root layout is wrapped in the ClerkProvider.
- The middleware protects routes using Clerk session data.

## Key code
```tsx
// app/layout.tsx
import { ClerkProvider } from "@clerk/nextjs";

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <ClerkProvider>
      <html lang="en"><body>{children}</body></html>
    </ClerkProvider>
  );
}
```

## Practice
Install Clerk, add both keys to .env.local, wrap the root layout with ClerkProvider and confirm the app still loads.', 'Clerk needs a publishable key and a secret key in the environment.
The root layout is wrapped in the ClerkProvider.
The middleware protects routes using Clerk session data.', 'GXIjfcYeDog', 3, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a Clerk application.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add the environment keys.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap the app in the Clerk provider.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=GXIjfcYeDog'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Clerk Setup','https://www.youtube.com/results?search_query=Clerk+Setup'),(@lesson,'Clerk docs: Next.js quickstart','https://clerk.com/docs/quickstarts/nextjs');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Clerk Setup','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where does ClerkProvider belong?','The provider must wrap the whole app.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In the root layout',1,0),(@q,'In every page',0,1),(@q,'In globals.css',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The Clerk secret key belongs in a public environment variable.','Secret keys stay server-side.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Clerk Setup','Practise: Install and configure Clerk in a Next.js project','Install Clerk, add both keys to .env.local, wrap the root layout with ClerkProvider and confirm the app still loads.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Clerk Setup: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 85: Sign in and Sign out
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Sign in and Sign out', 'Add sign in and sign out actions to the interface.', 'Add sign in and sign up buttons.
Add a sign out button.
Test both flows.', '## What this lesson covers

Add sign in and sign out actions to the interface.

- Providing a sign-in route makes redirects predictable.
- SignedOut and SignedIn components show content per state.
- Sign out clears the session and returns to a public page.

## Key code
```tsx
import { SignInButton, SignOutButton, SignedIn, SignedOut } from "@clerk/nextjs";

<SignedOut><SignInButton /></SignedOut>
<SignedIn><SignOutButton /></SignedIn>
```

## Practice
Create a /sign-in route with the Clerk sign-in component and add SignInButton, SignOutButton, SignedIn and SignedOut to the header.', 'Providing a sign-in route makes redirects predictable.
SignedOut and SignedIn components show content per state.
Sign out clears the session and returns to a public page.', 'Qm-1PwZeUhU', 3, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add sign in and sign up buttons.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a sign out button.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Test both flows.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Qm-1PwZeUhU'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Sign in and Sign out','https://www.youtube.com/results?search_query=Sign+in+and+Sign+out'),(@lesson,'Clerk docs: Components','https://clerk.com/docs/components/overview');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Sign in and Sign out','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which component shows content only when a user is signed in?','The components render conditionally on session state.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'SignedIn',1,0),(@q,'SignedOut',0,1),(@q,'UserButton',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Signing out should invalidate the session cookie.','A signed-out user must lose access immediately.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Sign in and Sign out','Practise: Add sign in and sign out actions to the interface','Create a /sign-in route with the Clerk sign-in component and add SignInButton, SignOutButton, SignedIn and SignedOut to the header.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Sign in and Sign out: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 86: Profile Settings
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Profile Settings', 'Give users a profile page to manage their account.', 'Add a user profile route.
Use the Clerk user profile component.
Link to it from the header.', '## What this lesson covers

Give users a profile page to manage their account.

- The user profile component handles name, email, password and sessions.
- Marketing that page is usually reachable only for signed-in users.
- Hosting these screens yourself avoids rebuilding account security.

## Practice
Create /profile showing the user profile component and a user button in the header, then edit your name and confirm it saves.', 'The user profile component handles name, email, password and sessions.
Marketing that page is usually reachable only for signed-in users.
Hosting these screens yourself avoids rebuilding account security.', 'DmuwoBrYuIE', 3, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a user profile route.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the Clerk user profile component.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Link to it from the header.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=DmuwoBrYuIE'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Profile Settings','https://www.youtube.com/results?search_query=Profile+Settings'),(@lesson,'Clerk docs: UserProfile component','https://clerk.com/docs/components/user/user-profile');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Profile Settings','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does the user profile component let a visitor change?','The component manages the signed-in user''s own account.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Account details such as name, email and password',1,0),(@q,'Someone else''s account',0,1),(@q,'Database tables',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A profile page should normally be protected.','Only the account owner should see it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Profile Settings','Practise: Give users a profile page to manage their account','Create /profile showing the user profile component and a user button in the header, then edit your name and confirm it saves.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Profile Settings: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 87: Conditional UI Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Conditional UI Rendering', 'Show different UI for signed-in and signed-out visitors.', 'Render UI based on session state.
Keep server checks as well.
Avoid flashing protected content.', '## What this lesson covers

Show different UI for signed-in and signed-out visitors.

- SignedIn and SignedOut handle simple cases.
- Server-side checks decide access; the UI only reflects it.
- Hiding a button is not security.

## Practice
Change the dashboard link so it only appears when signed in, and confirm a signed-out visitor cannot open the dashboard URL.', 'SignedIn and SignedOut handle simple cases.
Server-side checks decide access; the UI only reflects it.
Hiding a button is not security.', 'ZIqa2hS0X6k', 2, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render UI based on session state.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep server checks as well.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Avoid flashing protected content.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=ZIqa2hS0X6k'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Conditional UI Rendering','https://www.youtube.com/results?search_query=Conditional+UI+Rendering'),(@lesson,'Clerk docs: Conditional rendering','https://clerk.com/docs/components/control/authenticated');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Conditional UI Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Is hiding a button enough to protect a route?','UI changes do not enforce access.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'No, the route must also be protected on the server',1,0),(@q,'Yes, if the button is gone',0,1),(@q,'Only for admins',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Conditional UI and access control are different things.','One is presentation, the other is enforcement.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Conditional UI Rendering','Practise: Show different UI for signed-in and signed-out visitors','Change the dashboard link so it only appears when signed in, and confirm a signed-out visitor cannot open the dashboard URL.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Conditional UI Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 88: Protecting Routes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Protecting Routes', 'Block access to private routes.', 'Configure the Clerk middleware.
Protect a folder of routes.
Send signed-out visitors to sign in.', '## What this lesson covers

Block access to private routes.

- The middleware needs public route patterns for sign in and static assets.
- auth.protect() sends unauthenticated visitors to the sign-in page.
- Protect routes on the server, then verify with a direct URL visit.

## Key code
```ts
import { clerkMiddleware, createRouteMatcher } from "@clerk/nextjs/server";

const isProtected = createRouteMatcher(["/dashboard(.*)", "/admin(.*)"]);

export default clerkMiddleware(async (auth, req) => {
  if (isProtected(req)) await auth.protect();
});

export const config = {
  matcher: ["/((?!_next|.*\\..*).*)", "/(api|trpc)(.*)"],
};
```

## Practice
Protect /dashboard and /admin with Clerk middleware, keep sign in and static files public, then open each URL while signed out.', 'The middleware needs public route patterns for sign in and static assets.
auth.protect() sends unauthenticated visitors to the sign-in page.
Protect routes on the server, then verify with a direct URL visit.', 'O4LhNvL5N28', 4, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Configure the Clerk middleware.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Protect a folder of routes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Send signed-out visitors to sign in.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=O4LhNvL5N28'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Protecting Routes','https://www.youtube.com/results?search_query=Protecting+Routes'),(@lesson,'Clerk docs: Protect routes','https://clerk.com/docs/references/nextjs/clerk-middleware');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Protecting Routes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which call blocks unauthenticated access inside middleware?','protect enforces the session requirement.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'auth.protect()',1,0),(@q,'auth.redirect()',0,1),(@q,'auth.block()',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Sign-in routes must stay public in the middleware matcher.','Otherwise the redirect target would itself be blocked.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Protecting Routes','Practise: Block access to private routes','Protect /dashboard and /admin with Clerk middleware, keep sign in and static files public, then open each URL while signed out.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Protecting Routes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 89: Read Session and User Data
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Read Session and User Data', 'Read the current user in server code.', 'Call auth on the server.
Fetch the full user when needed.
Use the data to personalise pages.', '## What this lesson covers

Read the current user in server code.

- await auth() returns the session and user id on the server.
- currentUser() returns the full user object for profile data.
- Use the id for database rows that belong to a user.

## Key code
```tsx
import { auth, currentUser } from "@clerk/nextjs/server";

export default async function Dashboard() {
  const { userId } = await auth();
  const user = await currentUser();
  return <h1>Welcome back, {user?.firstName ?? "learner"}</h1>;
}
```

## Practice
Personalise the dashboard greeting with the current user name and store the user id with a saved record.', 'await auth() returns the session and user id on the server.
currentUser() returns the full user object for profile data.
Use the id for database rows that belong to a user.', 'lUqOhq3YxnQ', 5, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call auth on the server.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Fetch the full user when needed.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the data to personalise pages.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=lUqOhq3YxnQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Read Session and User Data','https://www.youtube.com/results?search_query=Read+Session+and+User+Data'),(@lesson,'Clerk docs: auth()','https://clerk.com/docs/references/nextjs/auth');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Read Session and User Data','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which call returns the current user id on the server?','auth() reads the server-side session.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'await auth()',1,0),(@q,'useAuth() only',0,1),(@q,'getUser()',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','User-owned database rows should be linked to the user id.','Ownership is checked against the session id.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Read Session and User Data','Practise: Read the current user in server code','Personalise the dashboard greeting with the current user name and store the user id with a saved record.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Read Session and User Data: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 90: Role Based Access Control
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Role Based Access Control', 'Give different roles different permissions.', 'Store roles in session claims or your database.
Check a role on the server.
Hide admin actions from other users.', '## What this lesson covers

Give different roles different permissions.

- Roles can come from Clerk metadata or your own users table.
- Every protected action must check the role on the server.
- Hiding the admin UI is a convenience, never the control.

## Key code
```ts
const { userId, sessionClaims } = await auth();
if (sessionClaims?.metadata?.role !== "admin") {
  return { error: "Not allowed" };
}
```

## Practice
Add an admin role check so only admins see /admin and its delete action, then test with a normal account to confirm both the page and the action refuse.', 'Roles can come from Clerk metadata or your own users table.
Every protected action must check the role on the server.
Hiding the admin UI is a convenience, never the control.', 'aY5Mq-3UemY', 11, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Store roles in session claims or your database.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Check a role on the server.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Hide admin actions from other users.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=aY5Mq-3UemY'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Role Based Access Control','https://www.youtube.com/results?search_query=Role+Based+Access+Control'),(@lesson,'Clerk docs: Role based access control','https://clerk.com/docs/guides/users/managing#roles-and-permissions');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Role Based Access Control','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where must a role be checked for a destructive action?','The action enforces the rule.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'On the server, in the action itself',1,0),(@q,'In the button style',0,1),(@q,'In the middleware only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Middleware alone is enough authorisation for every action.','Protect the action itself as well.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Role Based Access Control','Practise: Give different roles different permissions','Add an admin role check so only admins see /admin and its delete action, then test with a normal account to confirm both the page and the action refuse.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Role Based Access Control: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 91: Customizing Clerk Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Customizing Clerk Components', 'Match the Clerk screens to your own design.', 'Use the appearance prop.
Set shared theme values.
Keep contrast and focus states intact.', '## What this lesson covers

Match the Clerk screens to your own design.

- Clerk components accept an appearance prop for colours, fonts and layout.
- Theme values can be set once on the provider and inherited.
- Keep the sign-in screens accessible: do not remove focus outlines.

## Key code
```tsx
<ClerkProvider appearance={{ variables: { colorPrimary: "#4f46e5", borderRadius: "0.5rem" } }}>
  {children}
</ClerkProvider>
```

## Practice
Theme the sign-in and profile components to match your brand colours with the appearance prop, then check keyboard navigation.', 'Clerk components accept an appearance prop for colours, fonts and layout.
Theme values can be set once on the provider and inherited.
Keep the sign-in screens accessible: do not remove focus outlines.', 'AocT--scISg', 7, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the appearance prop.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set shared theme values.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep contrast and focus states intact.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=AocT--scISg'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Customizing Clerk Components','https://www.youtube.com/results?search_query=Customizing+Clerk+Components'),(@lesson,'Clerk docs: Appearance prop','https://clerk.com/docs/customization/overview');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Customizing Clerk Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which prop customises the look of Clerk components?','The appearance prop carries variables and element styles.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'appearance',1,0),(@q,'style',0,1),(@q,'theme only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Customising a sign-in form should keep focus outlines visible.','Keyboard users need visible focus.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Customizing Clerk Components','Practise: Match the Clerk screens to your own design','Theme the sign-in and profile components to match your brand colours with the appearance prop, then check keyboard navigation.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Customizing Clerk Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 13: Deployment and Final Projects =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Deployment and Final Projects','Ship the app, then build a complete project and take the review quiz.',12);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Deployment and Final Projects',0);
SET @module=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Deployment and Final Projects');

-- Lesson 92: Deploying Next.js Apps to Vercel
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Deploying Next.js Apps to Vercel', 'Deploy a Next.js application to Vercel.', 'Push the project to a Git repository.
Import the repository into Vercel.
Add the environment variables.', '## What this lesson covers

Deploy a Next.js application to Vercel.

- Vercel builds each push and gives every deployment a URL.
- Environment variables replace the values in .env.local.
- Run the production build locally before deploying.

## Key code
```bash
npm run build
# push, then import the repository at vercel.com/new
```

## Practice
Push your project to GitHub, deploy it to Vercel, add the Clerk keys as environment variables and screenshot the live URL.', 'Vercel builds each push and gives every deployment a URL.
Environment variables replace the values in .env.local.
Run the production build locally before deploying.', 'eJBQqzXmTeM', 7, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Push the project to a Git repository.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Import the repository into Vercel.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add the environment variables.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=eJBQqzXmTeM'),(@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Deploying Next.js Apps to Vercel','https://www.youtube.com/results?search_query=Deploying+Next.js+Apps+to+Vercel'),(@lesson,'Next.js docs: Deploying','https://nextjs.org/docs/app/getting-started/deploying');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Deploying Next.js Apps to Vercel','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where do production secrets go on Vercel?','Secrets are stored as project environment variables.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Environment variables in the project settings',1,0),(@q,'The public folder',0,1),(@q,'next.config',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Running a production build locally first can catch deploy failures early.','The build shows errors that would break the deployment.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Deploying Next.js Apps to Vercel','Practise: Deploy a Next.js application to Vercel','Push your project to GitHub, deploy it to Vercel, add the Clerk keys as environment variables and screenshot the live URL.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Deploying Next.js Apps to Vercel: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 93: Final Project Briefing
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Final Project Briefing', 'Plan the final projects and check that you are ready.', 'Read both project briefs.
Sketch the routes, layouts and data.
List the Next.js features you will use.', '## What this lesson covers

Plan the final projects and check that you are ready.

- A complete project combines routing, layouts, data fetching, mutations, loading and error states and authentication.
- Plan the route tree before coding.
- Test with a production build, not only the dev server.

## Practice
Sketch the route tree for both projects, list the data each route needs and note where client components are required. Submit the sketch with your notes.', 'A complete project combines routing, layouts, data fetching, mutations, loading and error states and authentication.
Plan the route tree before coding.
Test with a production build, not only the dev server.', NULL, 12, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read both project briefs.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Sketch the routes, layouts and data.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List the Next.js features you will use.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch the full playlist','https://www.youtube.com/playlist?list=PLC3y8-rFHvwhIEc4I4-YTApqp1QDF1wQY'),(@lesson,'Search YouTube: Final Project Briefing','https://www.youtube.com/results?search_query=Final+Project+Briefing');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Final review quiz','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which list best describes a complete App Router project?','A finished project uses most framework features together.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Routes, layouts, data fetching, mutations, states and auth',1,0),(@q,'Only pages and styles',0,1),(@q,'Only API routes',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Testing only with the dev server is enough before deploying.','Always run a production build before shipping.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which should be protected on the server?','Writes, admin pages and role checks are enforced on the server.',2,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Database writes from server actions',1,0),(@q,'Admin pages',1,1),(@q,'A colour preference stored in CSS',0,2),(@q,'Role checks for destructive actions',1,3);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 1: Full-stack task manager','Build and deploy a complete Next.js 15 application with authentication.','Build a task manager with the Next.js 15 App Router.
Requirements: a task list route that loads tasks on the server, a create form using a server action with validation feedback, an update action and a delete action with a confirmation step, an optimistic toggle for completing a task, loading and error boundaries for the list route, a custom not-found page, a metadata title template, Clerk sign in and sign out with the task routes protected, per-user tasks filtered by the signed-in user id, and a deployed URL on Vercel with the environment variables set.
Keep secrets in environment variables and validate every write on the server.

Submit the live URL and the repository link, plus a short note on one bug you fixed and how you found it.','Build a complete, authenticated, deployed App Router project',100,60,1,1,1,1,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'All task features work: create, read, update, delete, complete',30),(@assign,'Server actions validate and authorise every write',20),(@assign,'Loading, error and not-found states are handled',15),(@assign,'Authentication and per-user data isolation work',15),(@assign,'Code quality: server and client boundaries, naming, structure',10),(@assign,'Live URL, repository and reflection note',10);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 2: Content site with search and modals (optional challenge)','Build a documentation or blog site with intercepted routes and search.','Build a content site with the Next.js 15 App Router using local markdown or a database.
Include a docs route with an optional catch-all segment, a sidebar layout for the docs section, generateStaticParams for the prerendered pages, a search form using next/form, an intercepted route so a page opens in a modal while keeping a direct URL, generateMetadata for each page and a sitemap-style index page.
Run a production build and confirm the prerendered routes in the output.

Submit the live URL or repository link and a note explaining which routes are static and which are dynamic, with reasons.','Combine routing, metadata, static rendering and interception',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Routing features work: catch-all, groups, interception',30),(@assign,'Static rendering and generateStaticParams verified in the build',25),(@assign,'Metadata and search work correctly',20),(@assign,'Structure and code quality',15),(@assign,'Live link and explanatory note',10);
SET @prev_stage=@stage;

COMMIT;
SELECT 'Next.js 15 for Beginners installed' AS result,(SELECT COUNT(*) FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=@path) AS lessons,(SELECT COUNT(*) FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE s.path_id=@path) AS quizzes,(SELECT COUNT(*) FROM assignments a JOIN stages s ON s.id=a.stage_id WHERE s.path_id=@path) AS assignments;
