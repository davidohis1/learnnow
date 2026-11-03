-- React.js for Beginners: 120 video lessons + final project briefing, 121 quizzes, 120 practice assignments and 2 final projects.
-- Built from the Codevolution "ReactJS Tutorial for Beginners" videos you provided.
-- Run in phpMyAdmin with YOUR database selected. Run it once.
-- To reinstall later, first run:  DELETE FROM learning_paths WHERE slug='reactjs-for-beginners';  (this also deletes enrolments and progress for the course)
START TRANSACTION;
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Web Development','web-development','Build useful things for the web.','code','orange',1);
SET @cat=(SELECT id FROM categories WHERE slug='web-development');
INSERT INTO learning_paths(category_id,title,slug,description,objectives,difficulty,status,certificate_enabled,certificate_min_score) VALUES(@cat,'React.js for Beginners', 'reactjs-for-beginners', 'Learn React from the ground up in four sections. React JS covers components, JSX, props, state, events, lists, forms, lifecycle methods, refs, portals, error boundaries, HOCs, render props and context. React Hooks covers useState, useEffect, useContext, useReducer, useCallback, useMemo, useRef and custom hooks. React Render explains renders, memoisation and context performance. React TypeScript covers typing props, events, state, hooks, refs and advanced component patterns. Pass a quiz after every lesson, practise with an assignment and finish with two complete projects.', 'Build component trees with JSX, props and composition
Manage state, events, forms and lists correctly
Use class component lifecycle methods and the hooks that replace them
Share logic with custom hooks, context, HOCs and render props
Measure and reduce unnecessary renders with memo, useMemo and useCallback
Type React applications end to end with TypeScript
Apply everything in two portfolio projects', 'intermediate', 'published', 1, 60);
SET @path=LAST_INSERT_ID();
SET @prev_stage=NULL;

-- ===== STAGE 1: React JS =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'React JS','Understand components, JSX, props, state, events, lists, forms, lifecycle methods, refs, portals, error boundaries and reusable patterns.',0);
SET @stage=LAST_INSERT_ID();
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'React JS');

-- Module: Getting Started with React
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Getting Started with React',0);
SET @module=LAST_INSERT_ID();

-- Lesson 1: Introduction
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Introduction', 'Meet React and see why component-based user interfaces are easier to build and maintain.', 'Explain what React is in one sentence.
Name the two ways of writing components.
Describe how React updates the page.', '## What this lesson covers

Meet React and see why component-based user interfaces are easier to build and maintain.

- React is a JavaScript library for building user interfaces from components.
- Components are small, reusable pieces of UI that you compose into pages.
- React is declarative: you describe what the UI should look like for a given state and React updates the DOM.

## Practice
Create a new React project with Vite, open it in the browser and write down the name of the file that renders the App component.', 'React is a JavaScript library for building user interfaces from components.
Components are small, reusable pieces of UI that you compose into pages.
React is declarative: you describe what the UI should look like for a given state and React updates the DOM.', 'QFaFIcGhPoM', 10, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what React is in one sentence.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name the two ways of writing components.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe how React updates the page.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=QFaFIcGhPoM'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Introduction','https://www.youtube.com/results?search_query=Introduction'),(@lesson,'React docs: Learn React','https://react.dev/learn');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Introduction','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is React?','React focuses on the view layer of an application.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A JavaScript library for building user interfaces',1,0),(@q,'A database engine',0,1),(@q,'A CSS framework',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','In React you update the DOM by hand for every state change.','You describe the UI for a state and React updates the DOM.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Introduction','Practise: Meet React and see why component-based user interfaces are easier to build and maintain','Create a new React project with Vite, open it in the browser and write down the name of the file that renders the App component.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Introduction: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 2: Hello World
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Hello World', 'Create your first React application and render a greeting from a component.', 'Create a project with Vite.
Render a JSX element from a component.
Find the file that mounts the app.', '## What this lesson covers

Create your first React application and render a greeting from a component.

- create-react-app is legacy; the current recommended tool is Vite with the react template.
- The root element is mounted from src/main.jsx with createRoot.
- Everything you see in the browser comes from the component tree.

## Key code
```bash
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

## Practice
Run npm create vite@latest my-app -- --template react, start the dev server and replace the starter content with a Hello World heading.', 'create-react-app is legacy; the current recommended tool is Vite with the react template.
The root element is mounted from src/main.jsx with createRoot.
Everything you see in the browser comes from the component tree.', '9hb_0TZ_MVI', 5, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a project with Vite.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render a JSX element from a component.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Find the file that mounts the app.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=9hb_0TZ_MVI'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Hello World','https://www.youtube.com/results?search_query=Hello+World'),(@lesson,'React docs: Creating a React app','https://react.dev/learn/creating-a-react-app');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Hello World','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which command creates a React project with Vite?','The Vite template scaffolds a modern React project.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'npm create vite@latest my-app -- --template react',1,0),(@q,'npm install react-app',0,1),(@q,'npm run react',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','src/main.jsx is where the app is mounted into the DOM.','main.jsx creates the root and renders App into it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Hello World','Practise: Create your first React application and render a greeting from a component','Run npm create vite@latest my-app -- --template react, start the dev server and replace the starter content with a Hello World heading.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Hello World: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 3: Folder Structure
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Folder Structure', 'Understand the folders and files a React project generates.', 'Identify src, public and package.json.
Explain what main.jsx does.
Create a components folder.', '## What this lesson covers

Understand the folders and files a React project generates.

- src holds all application code and assets you import.
- public holds files served as they are, such as icons.
- package.json lists scripts and dependencies; node_modules is generated, never edited.

## Practice
Open your project and write a short note explaining main.jsx, App.jsx, index.html and the public folder. Add a components folder inside src.', 'src holds all application code and assets you import.
public holds files served as they are, such as icons.
package.json lists scripts and dependencies; node_modules is generated, never edited.', '9VIiLJL0H4Y', 6, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Identify src, public and package.json.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what main.jsx does.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a components folder.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=9VIiLJL0H4Y'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Folder Structure','https://www.youtube.com/results?search_query=Folder+Structure'),(@lesson,'React docs: Project structure','https://react.dev/learn/creating-a-react-app#project-structure');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Folder Structure','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where should your own React components live?','Application code lives under src.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In src, usually in a components folder',1,0),(@q,'In node_modules',0,1),(@q,'In public',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','index.html is the only HTML page in a single-page React app.','The app mounts into the div inside index.html.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Folder Structure','Practise: Understand the folders and files a React project generates','Open your project and write a short note explaining main.jsx, App.jsx, index.html and the public folder. Add a components folder inside src.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Folder Structure: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 4: Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Components', 'Break a page into components that can be reused and composed.', 'Create a component file.
Render a component inside another.
Explain why component names are capitalised.', '## What this lesson covers

Break a page into components that can be reused and composed.

- A component is a function that returns JSX.
- Component names must start with a capital letter so they are treated as components, not HTML tags.
- Components can render other components, which is called composition.

## Key code
```jsx
function UserCard() {
  return <p className="p-3 border rounded">Amara Okafor</p>;
}

export default function App() {
  return (
    <>
      <UserCard />
      <UserCard />
    </>
  );
}
```

## Practice
Create Greeting, UserCard and App components where App renders two UserCard components. Screenshot the page.', 'A component is a function that returns JSX.
Component names must start with a capital letter so they are treated as components, not HTML tags.
Components can render other components, which is called composition.', 'Y2hgEGPzTZY', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a component file.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render a component inside another.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why component names are capitalised.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Y2hgEGPzTZY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Components','https://www.youtube.com/results?search_query=Components'),(@lesson,'React docs: Your first component','https://react.dev/learn/your-first-component');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why must a component name start with a capital letter?','Lowercase names are treated as built-in HTML elements.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'So React treats it as a component, not an HTML tag',1,0),(@q,'Because JavaScript requires it',0,1),(@q,'For CSS to apply',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A component can render other components.','Composition is how React UIs are built.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Components','Practise: Break a page into components that can be reused and composed','Create Greeting, UserCard and App components where App renders two UserCard components. Screenshot the page.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 5: Functional Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Functional Components', 'Write components as plain functions and see why they are the default today.', 'Write a functional component.
Return JSX from the function.
Use props in a function component.', '## What this lesson covers

Write components as plain functions and see why they are the default today.

- A functional component is a JavaScript function that returns JSX.
- It is shorter than a class component and works with hooks.
- Modern React code uses functional components almost everywhere.

## Practice
Rewrite the UserCard from the previous lesson as a function component that accepts a name prop and renders it.', 'A functional component is a JavaScript function that returns JSX.
It is shorter than a class component and works with hooks.
Modern React code uses functional components almost everywhere.', 'Cla1WwguArA', 7, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write a functional component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return JSX from the function.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use props in a function component.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Cla1WwguArA'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Functional Components','https://www.youtube.com/results?search_query=Functional+Components'),(@lesson,'React docs: Components','https://react.dev/learn/your-first-component');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Functional Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a functional component return?','The return value describes the UI.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'JSX (React elements)',1,0),(@q,'A string of CSS',0,1),(@q,'A database query',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Functional components can use hooks.','Hooks are only available in function components and custom hooks.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Functional Components','Practise: Write components as plain functions and see why they are the default today','Rewrite the UserCard from the previous lesson as a function component that accepts a name prop and renders it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Functional Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 6: Class Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Class Components', 'Read and write a class component so older codebases make sense.', 'Create a class that extends React.Component.
Implement render.
Read props with this.props.', '## What this lesson covers

Read and write a class component so older codebases make sense.

- A class component extends React.Component and defines a render method.
- Props are read from this.props and state from this.state.
- Class components still work, but new code is usually written with functions.

## Key code
```jsx
import React from "react";

class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
export default Welcome;
```

## Practice
Write a Welcome class component that renders a greeting from this.props.name, render it once and screenshot it.', 'A class component extends React.Component and defines a render method.
Props are read from this.props and state from this.state.
Class components still work, but new code is usually written with functions.', 'lnV34uLEzis', 6, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a class that extends React.Component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Implement render.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read props with this.props.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=lnV34uLEzis'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Class Components','https://www.youtube.com/results?search_query=Class+Components'),(@lesson,'React docs: Component class','https://react.dev/reference/react/Component');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Class Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which method must a class component define?','render returns the JSX for that component.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'render',1,0),(@q,'constructor only',0,1),(@q,'componentDidMount only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Class components are removed from React today.','They remain supported, though functional components are recommended.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Class Components','Practise: Read and write a class component so older codebases make sense','Write a Welcome class component that renders a greeting from this.props.name, render it once and screenshot it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Class Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 7: Hooks Update
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Hooks Update', 'Learn what hooks changed and how to work with both component styles.', 'Explain what hooks added in React 16.8.
Convert a simple class component to a function.
Know that class code still works.', '## What this lesson covers

Learn what hooks changed and how to work with both component styles.

- Hooks let function components use state and lifecycle features.
- They were added in React 16.8 without breaking class components.
- New projects should prefer function components with hooks.

## Practice
Convert the Welcome class component into a function component and note one thing that became shorter.', 'Hooks let function components use state and lifecycle features.
They were added in React 16.8 without breaking class components.
New projects should prefer function components with hooks.', 'oecI26cWqzk', 4, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what hooks added in React 16.8.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Convert a simple class component to a function.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know that class code still works.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=oecI26cWqzk'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Hooks Update','https://www.youtube.com/results?search_query=Hooks+Update'),(@lesson,'React docs: Hooks at a glance','https://react.dev/reference/react');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Hooks Update','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which React version introduced hooks?','Hooks arrived in React 16.8.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'16.8',1,0),(@q,'15.0',0,1),(@q,'18.0',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Using hooks requires rewriting all your class components.','Both styles work side by side.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Hooks Update','Practise: Learn what hooks changed and how to work with both component styles','Convert the Welcome class component into a function component and note one thing that became shorter.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Hooks Update: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 8: JSX
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'JSX', 'Write JSX and understand the rules it follows.', 'Write JSX with expressions and attributes.
Explain why className is used.
Return one parent element or a fragment.', '## What this lesson covers

Write JSX and understand the rules it follows.

- JSX looks like HTML but is JavaScript; a compiler turns it into React.createElement calls.
- Attributes use camelCase names such as className and htmlFor.
- A component returns one parent element, or a fragment that groups siblings.

## Key code
```jsx
const name = "Amara";
const card = (
  <div className="card p-4">
    <h2 className="text-xl">{name}</h2>
    <p>{21 + 2} lessons completed</p>
    <img src="/avatar.png" alt="Profile photo of Amara" />
  </div>
);
```

## Practice
Build a card in JSX that shows a name, an age with a calculation, a className, an inline style and an image with alt text.', 'JSX looks like HTML but is JavaScript; a compiler turns it into React.createElement calls.
Attributes use camelCase names such as className and htmlFor.
A component returns one parent element, or a fragment that groups siblings.', '7fPXI_MnBOY', 11, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write JSX with expressions and attributes.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why className is used.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return one parent element or a fragment.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7fPXI_MnBOY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: JSX','https://www.youtube.com/results?search_query=JSX'),(@lesson,'React docs: Writing markup with JSX','https://react.dev/learn/writing-markup-with-jsx');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: JSX','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which attribute sets CSS classes in JSX?','Because class is a reserved word in JavaScript.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'className',1,0),(@q,'class',0,1),(@q,'cssClass',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you embed a JavaScript expression in JSX?','Curly braces evaluate expressions inside JSX.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Put it in curly braces',1,0),(@q,'Prefix it with a dollar sign',0,1),(@q,'Wrap it in HTML comments',0,2);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: JSX','Practise: Write JSX and understand the rules it follows','Build a card in JSX that shows a name, an age with a calculation, a className, an inline style and an image with alt text.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','JSX: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Props, State and Events
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Props, State and Events',1);
SET @module=LAST_INSERT_ID();

-- Lesson 9: Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Props', 'Pass data into components with props and read values from the props object.', 'Pass props to a component.
Read props in both component styles.
Use children and default props.', '## What this lesson covers

Pass data into components with props and read values from the props object.

- Props are read-only values passed from parent to child.
- A function component receives a props object, its first parameter.
- props.children holds whatever is placed between the opening and closing tags.

## Key code
```jsx
function Badge({ label, tone = "blue" }) {
  return <span className={`badge badge-${tone}`}>{label}</span>;
}

<Badge label="New" />
<Badge label="Done" tone="green" />
```

## Practice
Build a Button component that accepts label, variant and children, then use it three times with different values.', 'Props are read-only values passed from parent to child.
A function component receives a props object, its first parameter.
props.children holds whatever is placed between the opening and closing tags.', 'm7OWXtbiXX8', 12, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass props to a component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read props in both component styles.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use children and default props.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=m7OWXtbiXX8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Props','https://www.youtube.com/results?search_query=Props'),(@lesson,'React docs: Passing props to a component','https://react.dev/learn/passing-props-to-a-component');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Can a child component change the props it receives?','Props flow one way, from parent to child.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'No, props are read-only',1,0),(@q,'Yes, with assignment',0,1),(@q,'Only in class components',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','props.children holds content placed between a component tags.','Children are passed like any other prop.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Props','Practise: Pass data into components with props and read values from the props object','Build a Button component that accepts label, variant and children, then use it three times with different values.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 10: State
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'State', 'Give a component memory with state and understand re-rendering.', 'Declare state in a function component.
Update state and see the UI change.
Explain why state matters.', '## What this lesson covers

Give a component memory with state and understand re-rendering.

- State is data that belongs to a component instance and survives re-renders.
- Changing state tells React to render the component again.
- Props come from the parent; state lives inside the component.

## Key code
```jsx
import { useState } from "react";

export default function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>Clicked {count} times</button>;
}
```

## Practice
Build a counter with a number in state and a button that increases it. Confirm the page updates without a reload.', 'State is data that belongs to a component instance and survives re-renders.
Changing state tells React to render the component again.
Props come from the parent; state lives inside the component.', '4ORZ1GmjaMc', 11, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Declare state in a function component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Update state and see the UI change.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why state matters.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=4ORZ1GmjaMc'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: State','https://www.youtube.com/results?search_query=State'),(@lesson,'React docs: State, a component memory','https://react.dev/learn/state-a-components-memory');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: State','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What happens when state changes?','State updates trigger a re-render.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React re-renders that component',1,0),(@q,'The browser reloads',0,1),(@q,'Nothing until you refresh',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','State values reset on every re-render.','State persists between renders of the same component instance.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: State','Practise: Give a component memory with state and understand re-rendering','Build a counter with a number in state and a button that increases it. Confirm the page updates without a reload.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','State: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 11: setState
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'setState', 'Update state correctly, including the updater form of setState.', 'Call a state setter to update state.
Use the updater function for the previous value.
Explain batching.', '## What this lesson covers

Update state correctly, including the updater form of setState.

- State setters do not change state immediately; they schedule a new render.
- React batches several updates in one event handler.
- The updater form setCount(prev => prev + 1) always works from the latest value.

## Key code
```jsx
function addThree() {
  setCount(prev => prev + 1);
  setCount(prev => prev + 1);
  setCount(prev => prev + 1);
}
```

## Practice
Build a counter with a button that adds three in one click by calling the updater three times, and compare it with calling setCount(count + 1) three times.', 'State setters do not change state immediately; they schedule a new render.
React batches several updates in one event handler.
The updater form setCount(prev => prev + 1) always works from the latest value.', 'uirRaVjRsf4', 14, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call a state setter to update state.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the updater function for the previous value.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain batching.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=uirRaVjRsf4'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: setState','https://www.youtube.com/results?search_query=setState'),(@lesson,'React docs: Updating state','https://react.dev/reference/react/useState#updating-state-based-on-the-previous-state');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: setState','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which form safely increments state three times in one handler?','The updater reads the latest pending value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Three calls to setCount(prev => prev + 1)',1,0),(@q,'Three calls to setCount(count + 1)',0,1),(@q,'setCount(count * 3)',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','State updates are batched inside event handlers.','Batching keeps renders efficient.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: setState','Practise: Update state correctly, including the updater form of setState','Build a counter with a button that adds three in one click by calling the updater three times, and compare it with calling setCount(count + 1) three times.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','setState: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 12: Destructuring props and state
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Destructuring props and state', 'Destructure props and state to keep components readable.', 'Destructure props in a function parameter.
Destructure state in class components.
Alias values when needed.', '## What this lesson covers

Destructure props and state to keep components readable.

- Destructuring pulls named values out of an object in one line.
- Function components can destructure props directly in the parameter list.
- Class components destructure this.props or this.state in render.

## Key code
```jsx
function Card({ title, price = 0, tags = [] }) {
  return <h3>{title} - {price}</h3>;
}
```

## Practice
Take a component with five props and rewrite it with destructuring and default values, including one renamed value.', 'Destructuring pulls named values out of an object in one line.
Function components can destructure props directly in the parameter list.
Class components destructure this.props or this.state in render.', '5_PdMS9CLLI', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Destructure props in a function parameter.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Destructure state in class components.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Alias values when needed.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=5_PdMS9CLLI'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Destructuring props and state','https://www.youtube.com/results?search_query=Destructuring+props+and+state'),(@lesson,'React docs: Destructuring props','https://react.dev/learn/passing-props-to-a-component#forwarding-props-with-the-jsx-spread-syntax');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Destructuring props and state','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which line destructures props in a function component?','The parameter object is destructured directly.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'function Card({ title, price })',1,0),(@q,'function Card(props.title)',0,1),(@q,'function Card(name = props)',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Destructuring changes the original props object.','It only copies values into local variables.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Destructuring props and state','Practise: Destructure props and state to keep components readable','Take a component with five props and rewrite it with destructuring and default values, including one renamed value.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Destructuring props and state: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 13: Event Handling
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Event Handling', 'Respond to clicks, typing and other events in React.', 'Attach an event handler with camelCase props.
Pass a function, not a call.
Read the event object.', '## What this lesson covers

Respond to clicks, typing and other events in React.

- Event props use camelCase names such as onClick, onChange and onSubmit.
- Pass the function itself: onClick={handleClick}, not onClick={handleClick()}.
- React passes a synthetic event with preventDefault and access to the target.

## Practice
Build a form with a text input that logs each keystroke, and a link that calls preventDefault so it does not navigate.', 'Event props use camelCase names such as onClick, onChange and onSubmit.
Pass the function itself: onClick={handleClick}, not onClick={handleClick()}.
React passes a synthetic event with preventDefault and access to the target.', 'Znqv84xi8Vs', 8, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Attach an event handler with camelCase props.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass a function, not a call.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the event object.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Znqv84xi8Vs'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Event Handling','https://www.youtube.com/results?search_query=Event+Handling'),(@lesson,'React docs: Responding to events','https://react.dev/learn/responding-to-events');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Event Handling','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is the correct way to attach a handler?','Pass the function reference so React can call it later.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'onClick={handleClick}',1,0),(@q,'onclick="handleClick()"',0,1),(@q,'onClick={handleClick()}',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React event names are written in camelCase.','React uses onClick, onChange and similar names.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Event Handling','Practise: Respond to clicks, typing and other events in React','Build a form with a text input that logs each keystroke, and a link that calls preventDefault so it does not navigate.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Event Handling: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 14: Binding Event Handlers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Binding Event Handlers', 'Bind event handlers correctly in class components.', 'Explain why this is undefined in a handler.
Bind in the constructor.
Use a class field arrow function.', '## What this lesson covers

Bind event handlers correctly in class components.

- In class components, a normal method loses its this binding when passed as a callback.
- Binding in the constructor, or using an arrow class field, keeps this pointing at the instance.
- Arrow class fields avoid the cost of binding on every render.

## Key code
```jsx
class Toggle extends React.Component {
  state = { on: false };
  handleClick = () => this.setState({ on: !this.state.on });
  render() {
    return <button onClick={this.handleClick}>{this.state.on ? "On" : "Off"}</button>;
  }
}
```

## Practice
Create a class component with a handleClick method that reads this.state, attach it without binding to see the error, then fix it with an arrow class field.', 'In class components, a normal method loses its this binding when passed as a callback.
Binding in the constructor, or using an arrow class field, keeps this pointing at the instance.
Arrow class fields avoid the cost of binding on every render.', 'kVWpBtRjkCk', 12, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why this is undefined in a handler.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Bind in the constructor.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use a class field arrow function.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=kVWpBtRjkCk'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Binding Event Handlers','https://www.youtube.com/results?search_query=Binding+Event+Handlers'),(@lesson,'React docs: Binding event handlers','https://react.dev/reference/react/Component');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Binding Event Handlers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why does this become undefined inside a class handler passed to onClick?','Binding decides what this refers to when the function runs.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The function is called without its object context',1,0),(@q,'Because state is async',0,1),(@q,'Because React removes this',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An arrow function class field keeps the correct this binding.','Arrow functions capture the instance this.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Binding Event Handlers','Practise: Bind event handlers correctly in class components','Create a class component with a handleClick method that reads this.state, attach it without binding to see the error, then fix it with an arrow class field.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Binding Event Handlers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 15: Methods as props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Methods as props', 'Pass functions from parent to child so children can report actions.', 'Pass a callback as a prop.
Call the parent callback with a value.
Keep handlers in the parent.', '## What this lesson covers

Pass functions from parent to child so children can report actions.

- A parent can pass a function prop; the child calls it with data.
- This pattern keeps state in one place and lets children stay simple.
- Name callbacks clearly, such as onSave or onDelete.

## Practice
Build a list where each child row has a delete button that calls a parent onDelete function with the row id, and confirm the parent removes the row.', 'A parent can pass a function prop; the child calls it with data.
This pattern keeps state in one place and lets children stay simple.
Name callbacks clearly, such as onSave or onDelete.', 'QpfyjwhY9kg', 9, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass a callback as a prop.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call the parent callback with a value.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep handlers in the parent.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=QpfyjwhY9kg'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Methods as props','https://www.youtube.com/results?search_query=Methods+as+props'),(@lesson,'React docs: Sharing state between components','https://react.dev/learn/sharing-state-between-components');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Methods as props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a child component do with a function prop?','The child triggers the parent handler.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Calls it to notify the parent',1,0),(@q,'Modifies it directly',0,1),(@q,'Stores it in state',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Keeping state in the parent is a common React pattern.','It avoids duplicated state across children.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Methods as props','Practise: Pass functions from parent to child so children can report actions','Build a list where each child row has a delete button that calls a parent onDelete function with the row id, and confirm the parent removes the row.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Methods as props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 16: Conditional Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Conditional Rendering', 'Render different UI depending on state and props.', 'Use if and early returns.
Use the ternary operator in JSX.
Use && for optional blocks.', '## What this lesson covers

Render different UI depending on state and props.

- You can return early from a component to skip rendering.
- Ternaries choose between two JSX values inside the markup.
- The && operator renders the right side only when the condition is truthy.

## Practice
Build a profile card that shows a sign-in button when logged out, a greeting and an admin badge when logged in and a loading skeleton while loading.', 'You can return early from a component to skip rendering.
Ternaries choose between two JSX values inside the markup.
The && operator renders the right side only when the condition is truthy.', '7o5FPaVA9m0', 12, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use if and early returns.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the ternary operator in JSX.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use && for optional blocks.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7o5FPaVA9m0'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Conditional Rendering','https://www.youtube.com/results?search_query=Conditional+Rendering'),(@lesson,'React docs: Conditional rendering','https://react.dev/learn/conditional-rendering');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Conditional Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which expression renders a message only when count is greater than zero?','The && operator renders the right side only for truthy values.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'{count > 0 && <p>Items</p>}',1,0),(@q,'{count > 0 ? null}',0,1),(@q,'{if (count) <p>Items</p>}',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Returning null from a component renders nothing.','null is a valid render result.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Conditional Rendering','Practise: Render different UI depending on state and props','Build a profile card that shows a sign-in button when logged out, a greeting and an admin badge when logged in and a loading skeleton while loading.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Conditional Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Lists, Forms and Lifecycle
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Lists, Forms and Lifecycle',2);
SET @module=LAST_INSERT_ID();

-- Lesson 17: List Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'List Rendering', 'Render arrays of data with map.', 'Transform an array into JSX with map.
Render a list of objects.
Keep the markup readable.', '## What this lesson covers

Render arrays of data with map.

- map returns a new array, and React can render an array of elements.
- Each item needs a key prop when the list is rendered.
- Extract an item component when the JSX inside map gets long.

## Key code
```jsx
const courses = [{ id: 1, title: "HTML" }, { id: 2, title: "CSS" }];

<ul>{courses.map((course) => <li key={course.id}>{course.title}</li>)}</ul>
```

## Practice
Render a list of six courses from an array of objects with their title, level and duration.', 'map returns a new array, and React can render an array of elements.
Each item needs a key prop when the list is rendered.
Extract an item component when the JSX inside map gets long.', '5s8Ol9uw-yM', 12, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Transform an array into JSX with map.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render a list of objects.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the markup readable.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=5s8Ol9uw-yM'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: List Rendering','https://www.youtube.com/results?search_query=List+Rendering'),(@lesson,'React docs: Rendering lists','https://react.dev/learn/rendering-lists');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: List Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which method turns an array of data into an array of JSX elements?','map transforms every item.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'map',1,0),(@q,'filter',0,1),(@q,'find',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React can render an array of elements directly.','Each element needs a stable key.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: List Rendering','Practise: Render arrays of data with map','Render a list of six courses from an array of objects with their title, level and duration.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','List Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 18: Lists and Keys
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Lists and Keys', 'Use keys so React can match list items between renders.', 'Add a key to each list item.
Choose a stable key from the data.
Explain what keys are for.', '## What this lesson covers

Use keys so React can match list items between renders.

- Keys help React identify which items changed, moved or were removed.
- A key must be unique among siblings and stable over time.
- Use a database id or a slug, not a random value.

## Practice
Add proper keys to a list of users with duplicate names and explain in a comment why the id is used instead of the name.', 'Keys help React identify which items changed, moved or were removed.
A key must be unique among siblings and stable over time.
Use a database id or a slug, not a random value.', '0sasRxl35_8', 8, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a key to each list item.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose a stable key from the data.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what keys are for.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=0sasRxl35_8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Lists and Keys','https://www.youtube.com/results?search_query=Lists+and+Keys'),(@lesson,'React docs: Keys','https://react.dev/learn/rendering-lists#keeping-list-items-in-order-with-key');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Lists and Keys','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What makes a good key?','Stable ids let React match items correctly.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A unique, stable id from the data',1,0),(@q,'The array index',0,1),(@q,'Math.random()',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Keys must be unique across the whole page.','They only need to be unique among siblings.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Lists and Keys','Practise: Use keys so React can match list items between renders','Add proper keys to a list of users with duplicate names and explain in a comment why the id is used instead of the name.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Lists and Keys: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 19: Index as Key Anti-pattern
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Index as Key Anti-pattern', 'See why array indexes make poor keys when a list changes.', 'Explain the index key problem.
Reproduce a bug with reordering.
Replace indexes with real ids.', '## What this lesson covers

See why array indexes make poor keys when a list changes.

- An index is only unique until the list is reordered, filtered or items are inserted.
- With index keys, React can reuse the wrong DOM node, which breaks input state.
- Real ids keep component state attached to the right item.

## Practice
Build a sortable list of inputs keyed by index, sort it and observe the values moving to the wrong rows. Fix it with ids.', 'An index is only unique until the list is reordered, filtered or items are inserted.
With index keys, React can reuse the wrong DOM node, which breaks input state.
Real ids keep component state attached to the right item.', 'xlPxnc5uUPQ', 11, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the index key problem.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reproduce a bug with reordering.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Replace indexes with real ids.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=xlPxnc5uUPQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Index as Key Anti-pattern','https://www.youtube.com/results?search_query=Index+as+Key+Anti-pattern'),(@lesson,'React docs: Index as a key','https://react.dev/learn/rendering-lists#why-does-react-need-keys');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Index as Key Anti-pattern','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does using the index as a key cause bugs?','The index no longer identifies the same item.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'When the list is reordered, filtered or has items inserted',1,0),(@q,'Only with ten or more items',0,1),(@q,'Never',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An index key is fine for a static list that never changes.','Stable order means the index stays attached to the same item.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Index as Key Anti-pattern','Practise: See why array indexes make poor keys when a list changes','Build a sortable list of inputs keyed by index, sort it and observe the values moving to the wrong rows. Fix it with ids.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Index as Key Anti-pattern: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 20: Styling and CSS Basics
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Styling and CSS Basics', 'Style React components with classes, inline styles and CSS files.', 'Import a CSS file into a component.
Use className and conditional classes.
Write inline styles as objects.', '## What this lesson covers

Style React components with classes, inline styles and CSS files.

- Importing a CSS file makes its rules available to the bundle.
- Conditional classes combine a base class with state-driven classes.
- The style prop takes a camelCase object, such as style={{ backgroundColor: "red" }}.

## Practice
Style a button three ways: a CSS class, a conditional class for the active state and an inline style for a custom colour.', 'Importing a CSS file makes its rules available to the bundle.
Conditional classes combine a base class with state-driven classes.
The style prop takes a camelCase object, such as style={{ backgroundColor: "red" }}.', 'j5P9FHiBVNo', 12, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Import a CSS file into a component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use className and conditional classes.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write inline styles as objects.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=j5P9FHiBVNo'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Styling and CSS Basics','https://www.youtube.com/results?search_query=Styling+and+CSS+Basics'),(@lesson,'React docs: Adding CSS','https://react.dev/learn/adding-css');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Styling and CSS Basics','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How is an inline style written in JSX?','The style prop takes an object with camelCase properties.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'style={{ color: "red" }}',1,0),(@q,'style="color:red"',0,1),(@q,'style={color:red}',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','CSS files imported into a component apply to the whole page by default.','Plain CSS imports are global; CSS modules scope them.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Styling and CSS Basics','Practise: Style React components with classes, inline styles and CSS files','Style a button three ways: a CSS class, a conditional class for the active state and an inline style for a custom colour.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Styling and CSS Basics: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 21: Basics of Form Handling
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Basics of Form Handling', 'Handle forms with controlled inputs.', 'Tie inputs to state with value and onChange.
Handle several fields with one handler.
Prevent the default submit.', '## What this lesson covers

Handle forms with controlled inputs.

- A controlled input takes its value from state and updates state on change.
- One handler can serve many fields by reading event.target.name.
- Call preventDefault in onSubmit to stop the browser reloading the page.

## Key code
```jsx
const [form, setForm] = useState({ name: "", email: "" });

function handleChange(e) {
  setForm({ ...form, [e.target.name]: e.target.value });
}
```

## Practice
Build a registration form with name, email and a select, all controlled from one state object and one change handler.', 'A controlled input takes its value from state and updates state on change.
One handler can serve many fields by reading event.target.name.
Call preventDefault in onSubmit to stop the browser reloading the page.', '7Vo_VCcWupQ', 14, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Tie inputs to state with value and onChange.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Handle several fields with one handler.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Prevent the default submit.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7Vo_VCcWupQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Basics of Form Handling','https://www.youtube.com/results?search_query=Basics+of+Form+Handling'),(@lesson,'React docs: Forms','https://react.dev/reference/react-dom/components/form');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Basics of Form Handling','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What makes an input controlled?','State is the single source of truth.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Its value comes from state and changes call a setter',1,0),(@q,'It has a name attribute',0,1),(@q,'It is inside a form',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Calling preventDefault stops the form from reloading the page.','It cancels the default browser submit.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Basics of Form Handling','Practise: Handle forms with controlled inputs','Build a registration form with name, email and a select, all controlled from one state object and one change handler.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Basics of Form Handling: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 22: Component Lifecycle Methods
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Component Lifecycle Methods', 'Understand the lifecycle phases of a class component.', 'Name the three lifecycle phases.
List the common lifecycle methods.
Know the hook equivalents.', '## What this lesson covers

Understand the lifecycle phases of a class component.

- The phases are mounting, updating and unmounting.
- Key methods include constructor, render, componentDidMount, componentDidUpdate and componentWillUnmount.
- Function components express the same ideas with useEffect.

## Practice
Draw the three phases and write the lifecycle methods that run in each, then note the useEffect equivalent for each.', 'The phases are mounting, updating and unmounting.
Key methods include constructor, render, componentDidMount, componentDidUpdate and componentWillUnmount.
Function components express the same ideas with useEffect.', 'qnN_FuFNq2g', 3, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name the three lifecycle phases.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List the common lifecycle methods.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know the hook equivalents.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=qnN_FuFNq2g'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Component Lifecycle Methods','https://www.youtube.com/results?search_query=Component+Lifecycle+Methods'),(@lesson,'React docs: Component lifecycle','https://react.dev/reference/react/Component#reference');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Component Lifecycle Methods','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which phase runs when a component is removed from the page?','Unmounting is the removal phase.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Unmounting',1,0),(@q,'Mounting',0,1),(@q,'Updating',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','componentDidMount runs after the first render.','It runs once the component is in the DOM.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Component Lifecycle Methods','Practise: Understand the lifecycle phases of a class component','Draw the three phases and write the lifecycle methods that run in each, then note the useEffect equivalent for each.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Component Lifecycle Methods: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 23: Component Mounting Lifecycle Methods
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Component Mounting Lifecycle Methods', 'Use mounting lifecycle methods for setup work.', 'Explain constructor and getDerivedStateFromProps.
Use componentDidMount for side effects.
Know the run order.', '## What this lesson covers

Use mounting lifecycle methods for setup work.

- The constructor sets initial state and binds methods.
- componentDidMount runs once after the first paint, which suits fetching or subscriptions.
- getDerivedStateFromProps is a rare escape hatch for state from props.

## Key code
```jsx
class Users extends React.Component {
  state = { users: [], loading: true };
  async componentDidMount() {
    const res = await fetch("https://jsonplaceholder.typicode.com/users");
    this.setState({ users: await res.json(), loading: false });
  }
  render() {
    return this.state.loading ? <p>Loading...</p> : <p>{this.state.users.length} users</p>;
  }
}
```

## Practice
Create a class component that fetches a user in componentDidMount, shows a loading flag and prints the order of lifecycle calls.', 'The constructor sets initial state and binds methods.
componentDidMount runs once after the first paint, which suits fetching or subscriptions.
getDerivedStateFromProps is a rare escape hatch for state from props.', 'KDXZibVdiEI', 11, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain constructor and getDerivedStateFromProps.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use componentDidMount for side effects.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know the run order.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=KDXZibVdiEI'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Component Mounting Lifecycle Methods','https://www.youtube.com/results?search_query=Component+Mounting+Lifecycle+Methods'),(@lesson,'React docs: componentDidMount','https://react.dev/reference/react/Component#componentdidmount');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Component Mounting Lifecycle Methods','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where should a class component start a fetch request?','Side effects belong after mounting.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'componentDidMount',1,0),(@q,'render',0,1),(@q,'the constructor',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Calling setState inside render is a good idea.','It triggers an infinite render loop.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Component Mounting Lifecycle Methods','Practise: Use mounting lifecycle methods for setup work','Create a class component that fetches a user in componentDidMount, shows a loading flag and prints the order of lifecycle calls.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Component Mounting Lifecycle Methods: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 24: Component Updating Lifecycle Methods
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Component Updating Lifecycle Methods', 'Control updates with the updating lifecycle methods.', 'Use shouldComponentUpdate to skip renders.
Use componentDidUpdate for post-update work.
Compare with hooks.', '## What this lesson covers

Control updates with the updating lifecycle methods.

- shouldComponentUpdate returns true or false to decide whether to re-render.
- componentDidUpdate runs after a re-render and can compare previous props and state.
- Always guard setState inside componentDidUpdate with a condition.

## Practice
Add shouldComponentUpdate to a class component that only re-renders when a prop changed, and log when it blocks a render.', 'shouldComponentUpdate returns true or false to decide whether to re-render.
componentDidUpdate runs after a re-render and can compare previous props and state.
Always guard setState inside componentDidUpdate with a condition.', 'DyPkojd1fas', 11, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use shouldComponentUpdate to skip renders.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use componentDidUpdate for post-update work.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Compare with hooks.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=DyPkojd1fas'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Component Updating Lifecycle Methods','https://www.youtube.com/results?search_query=Component+Updating+Lifecycle+Methods'),(@lesson,'React docs: componentDidUpdate','https://react.dev/reference/react/Component#componentdidupdate');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Component Updating Lifecycle Methods','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should shouldComponentUpdate return?','The boolean controls the update.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'true to re-render, false to skip',1,0),(@q,'the new state',0,1),(@q,'nothing',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','componentDidUpdate runs before the DOM is updated.','It runs after the update.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Component Updating Lifecycle Methods','Practise: Control updates with the updating lifecycle methods','Add shouldComponentUpdate to a class component that only re-renders when a prop changed, and log when it blocks a render.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Component Updating Lifecycle Methods: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Reusable Patterns
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Reusable Patterns',3);
SET @module=LAST_INSERT_ID();

-- Lesson 25: Fragments
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fragments', 'Group elements without adding extra DOM nodes.', 'Use the fragment shorthand.
Use React.Fragment with a key.
Explain why fragments help layout.', '## What this lesson covers

Group elements without adding extra DOM nodes.

- A fragment groups children without rendering a wrapper element.
- The shorthand is <> ... </>.
- Use the long form React.Fragment when a list needs keys.

## Key code
```jsx
function Row({ cells }) {
  return (
    <>
      {cells.map((c) => <React.Fragment key={c.id}><td>{c.a}</td><td>{c.b}</td></React.Fragment>)}
    </>
  );
}
```

## Practice
Return two sibling table cells from a row component using a keyed fragment so the table markup stays valid.', 'A fragment groups children without rendering a wrapper element.
The shorthand is <> ... </>.
Use the long form React.Fragment when a list needs keys.', 'bHdh1T0-US4', 10, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the fragment shorthand.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use React.Fragment with a key.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why fragments help layout.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=bHdh1T0-US4'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Fragments','https://www.youtube.com/results?search_query=Fragments'),(@lesson,'React docs: Fragment','https://react.dev/reference/react/Fragment');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fragments','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a fragment render in the DOM?','Fragments add no extra element.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Nothing, it only groups children',1,0),(@q,'A div',0,1),(@q,'A span',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The shorthand <> cannot take a key.','Use React.Fragment when you need props such as key.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fragments','Practise: Group elements without adding extra DOM nodes','Return two sibling table cells from a row component using a keyed fragment so the table markup stays valid.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fragments: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 26: Pure Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Pure Components', 'Skip unnecessary renders with PureComponent.', 'Create a pure class component.
Explain shallow comparison.
Avoid mutating props and state.', '## What this lesson covers

Skip unnecessary renders with PureComponent.

- PureComponent compares props and state shallowly and skips rendering when nothing changed.
- Shallow comparison checks references, so mutating an object keeps the same reference.
- Always return new objects and arrays instead of changing existing ones.

## Practice
Build a PureComponent child rendered by a parent that updates unrelated state, and log whether the child re-renders. Then break it by mutating an array.', 'PureComponent compares props and state shallowly and skips rendering when nothing changed.
Shallow comparison checks references, so mutating an object keeps the same reference.
Always return new objects and arrays instead of changing existing ones.', 'YCRuTT31qR0', 13, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a pure class component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain shallow comparison.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Avoid mutating props and state.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=YCRuTT31qR0'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Pure Components','https://www.youtube.com/results?search_query=Pure+Components'),(@lesson,'React docs: PureComponent','https://react.dev/reference/react/PureComponent');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Pure Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How does PureComponent decide to re-render?','Shallow comparison is fast but reference based.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It shallowly compares props and state',1,0),(@q,'It always re-renders',0,1),(@q,'It deep compares everything',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Mutating a state array makes PureComponent notice the change.','The reference stays the same, so the change is missed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Pure Components','Practise: Skip unnecessary renders with PureComponent','Build a PureComponent child rendered by a parent that updates unrelated state, and log whether the child re-renders. Then break it by mutating an array.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Pure Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 27: memo
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'memo', 'Memoise function components with React.memo.', 'Wrap a component in React.memo.
Explain when memo helps.
Recognise its limits.', '## What this lesson covers

Memoise function components with React.memo.

- React.memo skips re-rendering when the props are shallowly equal.
- It helps components that render often and receive stable props.
- Object and function props created inline defeat it unless you memoise them too.

## Key code
```jsx
const Row = React.memo(function Row({ label }) {
  console.log("render", label);
  return <li>{label}</li>;
});
```

## Practice
Wrap a list row in React.memo, log renders with a parent button that updates unrelated state and observe the difference.', 'React.memo skips re-rendering when the props are shallowly equal.
It helps components that render often and receive stable props.
Object and function props created inline defeat it unless you memoise them too.', '7TaBhrnPH78', 4, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap a component in React.memo.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when memo helps.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise its limits.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=7TaBhrnPH78'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: memo','https://www.youtube.com/results?search_query=memo'),(@lesson,'React docs: memo','https://react.dev/reference/react/memo');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: memo','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does React.memo compare by default?','Only props are compared, and only one level deep.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Props, shallowly',1,0),(@q,'The whole component state',0,1),(@q,'The DOM',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React.memo prevents re-renders caused by the component own state.','memo only skips renders when props are unchanged.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: memo','Practise: Memoise function components with React.memo','Wrap a list row in React.memo, log renders with a parent button that updates unrelated state and observe the difference.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','memo: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 28: Refs
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Refs', 'Reach DOM nodes and hold mutable values with refs.', 'Create a ref with useRef.
Attach it to a DOM element.
Explain why refs do not re-render.', '## What this lesson covers

Reach DOM nodes and hold mutable values with refs.

- A ref is a mutable box whose value you change without triggering a render.
- Attaching a ref to an element gives you that DOM node in ref.current.
- Use refs for focus, measurements, timers and media playback, not for visible data.

## Key code
```jsx
import { useEffect, useRef } from "react";

const inputRef = useRef(null);
useEffect(() => { inputRef.current?.focus(); }, []);
return <input ref={inputRef} />;
```

## Practice
Build a search box that focuses automatically on mount with useRef, and a button that focuses it again.', 'A ref is a mutable box whose value you change without triggering a render.
Attaching a ref to an element gives you that DOM node in ref.current.
Use refs for focus, measurements, timers and media playback, not for visible data.', 'FXa9mMTKOu8', 10, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a ref with useRef.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Attach it to a DOM element.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why refs do not re-render.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=FXa9mMTKOu8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Refs','https://www.youtube.com/results?search_query=Refs'),(@lesson,'React docs: useRef','https://react.dev/reference/react/useRef');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Refs','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which change re-renders a component?','Refs do not trigger renders.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Changing state',1,0),(@q,'Changing ref.current',0,1),(@q,'Changing a local variable',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','ref.current is null until the element is mounted.','React sets it after the DOM node exists.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Refs','Practise: Reach DOM nodes and hold mutable values with refs','Build a search box that focuses automatically on mount with useRef, and a button that focuses it again.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Refs: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 29: Refs with Class Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Refs with Class Components', 'Use refs with class components, including callback refs.', 'Create a ref in a class.
Attach a ref to a child component.
Use a callback ref.', '## What this lesson covers

Use refs with class components, including callback refs.

- createRef is called in the constructor and read from ref.current.
- Attaching a ref to a class child gives you that child instance.
- A callback ref is a function that receives the node, useful for dynamic elements.

## Practice
In a class component, focus an input with createRef, then repeat it with a callback ref and note the difference.', 'createRef is called in the constructor and read from ref.current.
Attaching a ref to a class child gives you that child instance.
A callback ref is a function that receives the node, useful for dynamic elements.', '8aCXVC9Qmto', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a ref in a class.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Attach a ref to a child component.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use a callback ref.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=8aCXVC9Qmto'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Refs with Class Components','https://www.youtube.com/results?search_query=Refs+with+Class+Components'),(@lesson,'React docs: createRef','https://react.dev/reference/react/createRef');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Refs with Class Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a ref attached to a class component give you?','You get the instance, so you can call its methods.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The component instance',1,0),(@q,'Its rendered HTML string',0,1),(@q,'Its props',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A callback ref receives the DOM node as its argument.','React calls it with the node on mount and null on unmount.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Refs with Class Components','Practise: Use refs with class components, including callback refs','In a class component, focus an input with createRef, then repeat it with a callback ref and note the difference.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Refs with Class Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 30: Forwarding Refs
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Forwarding Refs', 'Pass refs through components with forwardRef and useImperativeHandle.', 'Wrap a component in forwardRef.
Expose a limited API with useImperativeHandle.
Know when this is needed.', '## What this lesson covers

Pass refs through components with forwardRef and useImperativeHandle.

- A function component does not receive refs by default.
- forwardRef passes the ref down to a DOM node or an imperative handle.
- useImperativeHandle limits what parents can do, which keeps components encapsulated.

## Key code
```jsx
const CustomInput = React.forwardRef(function CustomInput(props, ref) {
  return <input ref={ref} {...props} />;
});
```

## Practice
Build a CustomInput component with forwardRef that exposes focus and clear methods, and call both from the parent.', 'A function component does not receive refs by default.
forwardRef passes the ref down to a DOM node or an imperative handle.
useImperativeHandle limits what parents can do, which keeps components encapsulated.', 'RLWniwmfdq4', 7, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap a component in forwardRef.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Expose a limited API with useImperativeHandle.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know when this is needed.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=RLWniwmfdq4'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Forwarding Refs','https://www.youtube.com/results?search_query=Forwarding+Refs'),(@lesson,'React docs: forwardRef','https://react.dev/reference/react/forwardRef');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Forwarding Refs','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why is forwardRef needed?','The ref must be forwarded explicitly.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Function components do not receive ref props by default',1,0),(@q,'To create state',0,1),(@q,'To make CSS work',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','useImperativeHandle can expose custom methods instead of the raw node.','It gives you a controlled public API.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Forwarding Refs','Practise: Pass refs through components with forwardRef and useImperativeHandle','Build a CustomInput component with forwardRef that exposes focus and clear methods, and call both from the parent.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Forwarding Refs: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 31: Portals
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Portals', 'Render modals and tooltips outside the parent DOM tree with portals.', 'Create a portal with createPortal.
Explain why portals help with overlays.
Know how events bubble.', '## What this lesson covers

Render modals and tooltips outside the parent DOM tree with portals.

- createPortal renders children into a different DOM node while keeping the React tree.
- Portals solve z-index and overflow problems for modals and tooltips.
- Events still bubble through the React tree, not the DOM tree.

## Key code
```jsx
import { createPortal } from "react-dom";

function Modal({ children }) {
  return createPortal(children, document.getElementById("modal-root"));
}
```

## Practice
Build a modal rendered into a portal root div and confirm it escapes a parent with overflow hidden.', 'createPortal renders children into a different DOM node while keeping the React tree.
Portals solve z-index and overflow problems for modals and tooltips.
Events still bubble through the React tree, not the DOM tree.', 'HpHLa-5Wdys', 9, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a portal with createPortal.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why portals help with overlays.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know how events bubble.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=HpHLa-5Wdys'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Portals','https://www.youtube.com/results?search_query=Portals'),(@lesson,'React docs: createPortal','https://react.dev/reference/react-dom/createPortal');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Portals','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where does a portal render its children?','You pass the target DOM node to createPortal.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Into another DOM node you choose',1,0),(@q,'Into the server',0,1),(@q,'Into a new window',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React events inside a portal bubble to the React parent.','The React tree, not the DOM tree, decides bubbling.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Portals','Practise: Render modals and tooltips outside the parent DOM tree with portals','Build a modal rendered into a portal root div and confirm it escapes a parent with overflow hidden.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Portals: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 32: Error Boundary
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Error Boundary', 'Catch rendering errors with an error boundary.', 'Create a class error boundary.
Provide a fallback UI.
Know what boundaries cannot catch.', '## What this lesson covers

Catch rendering errors with an error boundary.

- An error boundary is a class component using getDerivedStateFromError or componentDidCatch.
- It renders a fallback instead of a crashed subtree.
- It does not catch errors in event handlers, timers or async code; handle those with try and catch.

## Practice
Build an error boundary around a component that throws, render a friendly fallback with a retry button and confirm the rest of the page keeps working.', 'An error boundary is a class component using getDerivedStateFromError or componentDidCatch.
It renders a fallback instead of a crashed subtree.
It does not catch errors in event handlers, timers or async code; handle those with try and catch.', 'DNYXgtZBRPE', 11, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a class error boundary.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Provide a fallback UI.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know what boundaries cannot catch.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=DNYXgtZBRPE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Error Boundary','https://www.youtube.com/results?search_query=Error+Boundary'),(@lesson,'React docs: Error boundary','https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Error Boundary','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which component type can be an error boundary?','There is no hook equivalent yet; a class is required.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A class component with getDerivedStateFromError',1,0),(@q,'Any function component',0,1),(@q,'A fragment',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An error boundary catches errors thrown in an onClick handler.','Event handler errors need try and catch.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Error Boundary','Practise: Catch rendering errors with an error boundary','Build an error boundary around a component that throws, render a friendly fallback with a retry button and confirm the rest of the page keeps working.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Error Boundary: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 33: Higher Order Components (Part 1)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Higher Order Components (Part 1)', 'Share behaviour between components with a higher order component.', 'Explain the HOC pattern.
Write a function that takes and returns a component.
See what the wrapper adds.', '## What this lesson covers

Share behaviour between components with a higher order component.

- A HOC is a function that takes a component and returns a new component.
- It is used to reuse logic such as data loading or logging.
- The wrapped component receives extra props from the HOC.

## Key code
```jsx
function withLogger(Wrapped) {
  return function Enhanced(props) {
    console.log("props", props);
    return <Wrapped {...props} />;
  };
}
```

## Practice
Write a withLogger HOC that logs props and returns an enhanced component, then use it on two different components.', 'A HOC is a function that takes a component and returns a new component.
It is used to reuse logic such as data loading or logging.
The wrapped component receives extra props from the HOC.', 'B6aNv8nkUSw', 7, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the HOC pattern.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write a function that takes and returns a component.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'See what the wrapper adds.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=B6aNv8nkUSw'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Higher Order Components (Part 1)','https://www.youtube.com/results?search_query=Higher+Order+Components+(Part+1)'),(@lesson,'React docs: Higher order components','https://legacy.reactjs.org/docs/higher-order-components.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Higher Order Components (Part 1)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is a higher order component?','It is a composition pattern, not a component itself.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A function that takes a component and returns a new component',1,0),(@q,'A component with children',0,1),(@q,'A React hook',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A HOC changes the original component.','A good HOC returns a new component and leaves the original untouched.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Higher Order Components (Part 1)','Practise: Share behaviour between components with a higher order component','Write a withLogger HOC that logs props and returns an enhanced component, then use it on two different components.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Higher Order Components (Part 1): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 34: Higher Order Components (Part 2)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Higher Order Components (Part 2)', 'Build a practical HOC that injects shared state and handlers.', 'Create a withCounter HOC.
Pass the injected props through.
Use it with several components.', '## What this lesson covers

Build a practical HOC that injects shared state and handlers.

- The HOC owns state and passes count and increment as props.
- The wrapped component stays a simple presentational component.
- Set displayName so the wrapper is easy to find in DevTools.

## Key code
```jsx
function withCounter(Wrapped) {
  function WithCounter(props) {
    const [count, setCount] = useState(0);
    return <Wrapped {...props} count={count} increment={() => setCount(count + 1)} />;
  }
  WithCounter.displayName = `withCounter(${Wrapped.displayName || Wrapped.name})`;
  return WithCounter;
}
```

## Practice
Build withCounter that injects count and increment, then use it for a button and a heading that both show the same count.', 'The HOC owns state and passes count and increment as props.
The wrapped component stays a simple presentational component.
Set displayName so the wrapper is easy to find in DevTools.', 'rsBQj6X7UK8', 13, 1, 1, 9, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a withCounter HOC.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass the injected props through.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use it with several components.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=rsBQj6X7UK8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Higher Order Components (Part 2)','https://www.youtube.com/results?search_query=Higher+Order+Components+(Part+2)'),(@lesson,'React docs: HOC caveats','https://legacy.reactjs.org/docs/higher-order-components.html#caveats');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Higher Order Components (Part 2)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How does the wrapped component receive the injected values?','HOCs pass values as props.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'As props from the HOC',1,0),(@q,'By importing a global',0,1),(@q,'Through context only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A HOC can hold state and handlers.','Wrapping a class component lets it own state.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Higher Order Components (Part 2)','Practise: Build a practical HOC that injects shared state and handlers','Build withCounter that injects count and increment, then use it for a button and a heading that both show the same count.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Higher Order Components (Part 2): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 35: Higher Order Components (Part 3)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Higher Order Components (Part 3)', 'Avoid the common HOC mistakes.', 'Do not mutate the wrapped component.
Understand ref and static method limits.
Keep wrappers focused.', '## What this lesson covers

Avoid the common HOC mistakes.

- Mutating the input component breaks reuse and tests.
- Refs are not passed through by default; forward them explicitly.
- One HOC should add one concern so composition stays readable.

## Practice
Review a HOC that mutates its argument and rewrite it to return a new component, forwarding refs and copying nothing else.', 'Mutating the input component breaks reuse and tests.
Refs are not passed through by default; forward them explicitly.
One HOC should add one concern so composition stays readable.', 'l8V59zIdBXU', 4, 1, 1, 10, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Do not mutate the wrapped component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Understand ref and static method limits.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep wrappers focused.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=l8V59zIdBXU'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Higher Order Components (Part 3)','https://www.youtube.com/results?search_query=Higher+Order+Components+(Part+3)'),(@lesson,'React docs: HOC caveats','https://legacy.reactjs.org/docs/higher-order-components.html#caveats');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Higher Order Components (Part 3)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why should a HOC not mutate the component it receives?','Shared components must stay predictable.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It changes behaviour for every other user of that component',1,0),(@q,'It is slower',0,1),(@q,'It breaks CSS',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Static methods of the wrapped component are copied automatically.','You must copy or hoist them yourself.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Higher Order Components (Part 3)','Practise: Avoid the common HOC mistakes','Review a HOC that mutates its argument and rewrite it to return a new component, forwarding refs and copying nothing else.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Higher Order Components (Part 3): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 36: Render Props (Part 1)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Render Props (Part 1)', 'Share state through a render prop.', 'Explain the render prop pattern.
Pass a function as a prop.
Render based on the values provided.', '## What this lesson covers

Share state through a render prop.

- A render prop is a function prop that returns JSX.
- The component owning state calls that function with the values it manages.
- It is an alternative to HOCs for sharing logic.

## Key code
```jsx
function MouseTracker({ render }) {
  const [pos, setPos] = useState({ x: 0, y: 0 });
  return <div onMouseMove={(e) => setPos({ x: e.clientX, y: e.clientY })}>{render(pos)}</div>;
}

<MouseTracker render={({ x, y }) => <p>{x}, {y}</p>} />;
```

## Practice
Build a MouseTracker component that passes its coordinates to a render prop and renders two different views from the same tracker.', 'A render prop is a function prop that returns JSX.
The component owning state calls that function with the values it manages.
It is an alternative to HOCs for sharing logic.', 'NdapMDgNhtE', 5, 1, 1, 11, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the render prop pattern.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass a function as a prop.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render based on the values provided.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=NdapMDgNhtE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Render Props (Part 1)','https://www.youtube.com/results?search_query=Render+Props+(Part+1)'),(@lesson,'React docs: Render props','https://legacy.reactjs.org/docs/render-props.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Render Props (Part 1)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is a render prop?','The function receives data and returns elements.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A prop whose value is a function that returns JSX',1,0),(@q,'A prop named render',0,1),(@q,'A CSS property',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A render prop lets the parent decide the markup.','The state owner stays presentational.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Render Props (Part 1)','Practise: Share state through a render prop','Build a MouseTracker component that passes its coordinates to a render prop and renders two different views from the same tracker.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Render Props (Part 1): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 37: Render Props (Part 2)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Render Props (Part 2)', 'Use children as a function and compare render props with HOCs.', 'Use a function as children.
Choose between HOC and render prop.
Keep names descriptive.', '## What this lesson covers

Use children as a function and compare render props with HOCs.

- children can be a function receiving the shared values.
- Render props avoid the extra wrapper component a HOC adds.
- Both patterns are less common today because hooks express shared logic more directly.

## Practice
Rewrite the MouseTracker to accept a function as children and use it twice with different markup.', 'children can be a function receiving the shared values.
Render props avoid the extra wrapper component a HOC adds.
Both patterns are less common today because hooks express shared logic more directly.', 'EZil2OTyB4w', 11, 1, 1, 12, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use a function as children.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose between HOC and render prop.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep names descriptive.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=EZil2OTyB4w'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Render Props (Part 2)','https://www.youtube.com/results?search_query=Render+Props+(Part+2)'),(@lesson,'React docs: Render props','https://legacy.reactjs.org/docs/render-props.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Render Props (Part 2)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pattern puts the shared logic in a custom hook instead of a wrapper?','Hooks extract logic without touching the component tree.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A custom hook',1,0),(@q,'A HOC',0,1),(@q,'A render prop',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Render props and HOCs solve the same problem in different ways.','Both share behaviour between components.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Render Props (Part 2)','Practise: Use children as a function and compare render props with HOCs','Rewrite the MouseTracker to accept a function as children and use it twice with different markup.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Render Props (Part 2): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 38: Context (Part 1)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Context (Part 1)', 'Recognise prop drilling and when context is the answer.', 'Explain prop drilling.
Describe what context provides.
Decide when context is worth it.', '## What this lesson covers

Recognise prop drilling and when context is the answer.

- Prop drilling is passing props through components that do not use them.
- Context provides a value to a whole subtree without prop chains.
- Use context for genuinely shared values such as theme, locale or the current user.

## Practice
Take a three-level component tree that passes a user object down two levels and mark which components do not need it.', 'Prop drilling is passing props through components that do not use them.
Context provides a value to a whole subtree without prop chains.
Use context for genuinely shared values such as theme, locale or the current user.', 'j3j8St50fNY', 3, 1, 1, 13, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain prop drilling.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe what context provides.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Decide when context is worth it.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=j3j8St50fNY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Context (Part 1)','https://www.youtube.com/results?search_query=Context+(Part+1)'),(@lesson,'React docs: Passing data deeply with context','https://react.dev/learn/passing-data-deeply-with-context');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Context (Part 1)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What problem does context solve?','Context avoids prop drilling.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Passing values through many intermediate components',1,0),(@q,'Slow network requests',0,1),(@q,'CSS conflicts',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Context should be used for every piece of state in an app.','Local state stays local; context is for shared values.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Context (Part 1)','Practise: Recognise prop drilling and when context is the answer','Take a three-level component tree that passes a user object down two levels and mark which components do not need it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Context (Part 1): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 39: Context (Part 2)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Context (Part 2)', 'Create a context and read it with a provider and consumer.', 'Create a context with createContext.
Provide a value.
Read it with Consumer or contextType.', '## What this lesson covers

Create a context and read it with a provider and consumer.

- createContext takes a default value used when no provider is above.
- The Provider supplies a value to everything inside it.
- Older class code reads context with Consumer or static contextType.

## Key code
```jsx
const ThemeContext = React.createContext("light");
<ThemeContext.Provider value="dark"><Toolbar /></ThemeContext.Provider>
```

## Practice
Create a ThemeContext with a default of light, wrap a section in a Provider with a dark value and read it in a child.', 'createContext takes a default value used when no provider is above.
The Provider supplies a value to everything inside it.
Older class code reads context with Consumer or static contextType.', 'lTjQjWemKgE', 7, 1, 1, 14, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a context with createContext.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Provide a value.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read it with Consumer or contextType.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=lTjQjWemKgE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Context (Part 2)','https://www.youtube.com/results?search_query=Context+(Part+2)'),(@lesson,'React docs: createContext','https://react.dev/reference/react/createContext');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Context (Part 2)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which component supplies a context value?','Providers set the value for their subtree.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The Provider',1,0),(@q,'The Consumer',0,1),(@q,'createContext itself',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The default value passed to createContext is used when no provider exists.','It is the fallback value.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Context (Part 2)','Practise: Create a context and read it with a provider and consumer','Create a ThemeContext with a default of light, wrap a section in a Provider with a dark value and read it in a child.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Context (Part 2): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 40: Context (Part 3)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Context (Part 3)', 'Read context in both class and function components.', 'Use useContext in a function component.
Use contextType in a class component.
Consume several contexts.', '## What this lesson covers

Read context in both class and function components.

- useContext returns the nearest provider value.
- static contextType = ThemeContext gives a class component this.context.
- Nesting providers lets you combine several contexts.

## Practice
Read the theme with useContext in a function component and with contextType in a class component, then nest a locale provider around both.', 'useContext returns the nearest provider value.
static contextType = ThemeContext gives a class component this.context.
Nesting providers lets you combine several contexts.', 'A9WlkhdLnn0', 5, 1, 1, 15, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use useContext in a function component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use contextType in a class component.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Consume several contexts.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=A9WlkhdLnn0'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Context (Part 3)','https://www.youtube.com/results?search_query=Context+(Part+3)'),(@lesson,'React docs: useContext','https://react.dev/reference/react/useContext');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Context (Part 3)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which hook reads a context value?','useContext takes the context object and returns the value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'useContext',1,0),(@q,'useReducer',0,1),(@q,'useRef',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A component reads the nearest provider above it.','Nested providers override outer ones.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Context (Part 3)','Practise: Read context in both class and function components','Read the theme with useContext in a function component and with contextType in a class component, then nest a locale provider around both.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Context (Part 3): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: HTTP and React
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'HTTP and React',4);
SET @module=LAST_INSERT_ID();

-- Lesson 41: HTTP and React
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTTP and React', 'Plan how a React app talks to an API.', 'Choose fetch or axios.
Describe the request lifecycle.
Decide where requests belong.', '## What this lesson covers

Plan how a React app talks to an API.

- React itself has no data layer; you use fetch or a library such as axios.
- A request has a loading state, a success state and an error state.
- In class components requests belong in componentDidMount; in function components in useEffect or a server layer.

## Practice
Write down the loading, success and error states for a comments list and where each request would live in a function component.', 'React itself has no data layer; you use fetch or a library such as axios.
A request has a loading state, a success state and an error state.
In class components requests belong in componentDidMount; in function components in useEffect or a server layer.', 'GTmjthNvrxY', 3, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose fetch or axios.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe the request lifecycle.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Decide where requests belong.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=GTmjthNvrxY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: HTTP and React','https://www.youtube.com/results?search_query=HTTP+and+React'),(@lesson,'React docs: Fetching data','https://react.dev/learn/synchronizing-with-effects#fetching-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTTP and React','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which tool can a React app use to call an API?','fetch is built in; axios is a popular library.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'fetch or axios',1,0),(@q,'Only axios',0,1),(@q,'No tool; React fetches automatically',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A request needs a loading state and an error state.','Both are part of a good data flow.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: HTTP and React','Practise: Plan how a React app talks to an API','Write down the loading, success and error states for a comments list and where each request would live in a function component.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','HTTP and React: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 42: HTTP GET Request
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTTP GET Request', 'Fetch and display a list of records with a GET request.', 'Call an API with fetch.
Store the response in state.
Render a loading state.', '## What this lesson covers

Fetch and display a list of records with a GET request.

- fetch returns a promise; call response.json() for the body.
- Store results in state so the component re-renders.
- Guard against setting state after unmount with a cancel flag.

## Key code
```jsx
const [posts, setPosts] = useState([]);
useEffect(() => {
  const controller = new AbortController();
  fetch("https://jsonplaceholder.typicode.com/posts", { signal: controller.signal })
    .then((r) => { if (!r.ok) throw new Error("Request failed"); return r.json(); })
    .then(setPosts)
    .catch((e) => { if (e.name !== "AbortError") console.error(e); });
  return () => controller.abort();
}, []);
```

## Practice
Fetch https://jsonplaceholder.typicode.com/posts and render the first ten titles with a loading message while the request runs.', 'fetch returns a promise; call response.json() for the body.
Store results in state so the component re-renders.
Guard against setting state after unmount with a cancel flag.', 'NEYrSUM4Umw', 8, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call an API with fetch.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Store the response in state.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render a loading state.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=NEYrSUM4Umw'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: HTTP GET Request','https://www.youtube.com/results?search_query=HTTP+GET+Request'),(@lesson,'React docs: Fetching data','https://react.dev/learn/synchronizing-with-effects#fetching-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTTP GET Request','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which call reads a JSON body from a fetch response?','The json method returns a promise for the parsed body.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'await response.json()',1,0),(@q,'response.body',0,1),(@q,'JSON.parse(response)',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A successful response status is in the 200 to 299 range.','Anything else should be handled as an error.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: HTTP GET Request','Practise: Fetch and display a list of records with a GET request','Fetch https://jsonplaceholder.typicode.com/posts and render the first ten titles with a loading message while the request runs.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','HTTP GET Request: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 43: HTTP Post Request
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'HTTP Post Request', 'Send data to an API with a POST request.', 'Send a POST with a JSON body.
Set the content type header.
Handle the response.', '## What this lesson covers

Send data to an API with a POST request.

- POST needs method, headers with Content-Type application/json and a JSON.stringify body.
- Check response.ok before treating the request as successful.
- Show success or error feedback to the user.

## Key code
```jsx
await fetch("https://jsonplaceholder.typicode.com/posts", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ title, body }),
});
```

## Practice
Build a form that posts a new post to https://jsonplaceholder.typicode.com/posts and shows the created id in a message.', 'POST needs method, headers with Content-Type application/json and a JSON.stringify body.
Check response.ok before treating the request as successful.
Show success or error feedback to the user.', 'x9UEDRbLhJE', 7, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Send a POST with a JSON body.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Set the content type header.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Handle the response.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=x9UEDRbLhJE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: HTTP Post Request','https://www.youtube.com/results?search_query=HTTP+Post+Request'),(@lesson,'React docs: Sending data','https://react.dev/learn/synchronizing-with-effects');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: HTTP Post Request','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which header tells the server the body is JSON?','The content type describes the request body.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Content-Type: application/json',1,0),(@q,'Accept: text/html',0,1),(@q,'Body-Type: json',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The body of a POST request must be converted to a string.','JSON.stringify converts the object into a JSON string.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: HTTP Post Request','Practise: Send data to an API with a POST request','Build a form that posts a new post to https://jsonplaceholder.typicode.com/posts and shows the created id in a message.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','HTTP Post Request: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 2: React Hooks =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'React Hooks','Use state, effects, context, reducers and performance hooks, then write your own custom hooks.',1);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'React Hooks');

-- Module: Hooks Foundations
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Hooks Foundations',0);
SET @module=LAST_INSERT_ID();

-- Lesson 44: Hooks Introduction
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Hooks Introduction', 'Meet hooks and the rules that keep them working.', 'Explain what a hook is.
Name the most common hooks.
Follow the rules of hooks.', '## What this lesson covers

Meet hooks and the rules that keep them working.

- Hooks are functions that let function components use state and other React features.
- Call hooks only at the top level of a component or custom hook, never inside conditions or loops.
- Common hooks are useState, useEffect, useContext, useReducer, useRef, useCallback and useMemo.

## Practice
List the hooks you have used so far and mark three places in old code where a hook is called inside an if statement that would need fixing.', 'Hooks are functions that let function components use state and other React features.
Call hooks only at the top level of a component or custom hook, never inside conditions or loops.
Common hooks are useState, useEffect, useContext, useReducer, useRef, useCallback and useMemo.', 'cF2lQ_gZeA8', 8, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what a hook is.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name the most common hooks.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Follow the rules of hooks.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=cF2lQ_gZeA8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Hooks Introduction','https://www.youtube.com/results?search_query=Hooks+Introduction'),(@lesson,'React docs: Rules of hooks','https://react.dev/reference/rules/rules-of-hooks');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Hooks Introduction','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where may a hook be called?','Hooks must run in the same order on every render.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'At the top level of a component or custom hook',1,0),(@q,'Inside any if statement',0,1),(@q,'Inside a loop',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Hooks work in class components.','Hooks are for function components and custom hooks.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Hooks Introduction','Practise: Meet hooks and the rules that keep them working','List the hooks you have used so far and mark three places in old code where a hook is called inside an if statement that would need fixing.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Hooks Introduction: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 45: useState Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState Hook', 'Add state to a function component with useState.', 'Call useState with an initial value.
Destructure the pair it returns.
Update state with the setter.', '## What this lesson covers

Add state to a function component with useState.

- useState returns an array with the current value and a setter function.
- The initial value is only used on the first render.
- Calling the setter schedules a re-render with the new value.

## Key code
```jsx
const [isOpen, setIsOpen] = useState(false);
return <button onClick={() => setIsOpen(!isOpen)}>{isOpen ? "Hide" : "Show"}</button>;
```

## Practice
Build a toggle component with useState that shows and hides a panel when a button is clicked.', 'useState returns an array with the current value and a setter function.
The initial value is only used on the first render.
Calling the setter schedules a re-render with the new value.', 'lAW1Jmmr9hc', 11, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call useState with an initial value.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Destructure the pair it returns.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Update state with the setter.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=lAW1Jmmr9hc'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState Hook','https://www.youtube.com/results?search_query=useState+Hook'),(@lesson,'React docs: useState','https://react.dev/reference/react/useState');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does useState return?','The pair is usually destructured.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'An array with the value and a setter',1,0),(@q,'Only the value',0,1),(@q,'A promise',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The initial value passed to useState is used again on every render.','It is used only for the first render.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState Hook','Practise: Add state to a function component with useState','Build a toggle component with useState that shows and hides a panel when a button is clicked.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 46: useState with previous state
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState with previous state', 'Update state from its previous value safely.', 'Use the updater form of a setter.
Explain why it matters for batched updates.
Use it in counters and toggles.', '## What this lesson covers

Update state from its previous value safely.

- setCount(prev => prev + 1) receives the latest pending value.
- Calling setCount(count + 1) twice uses the same stale count.
- The updater form is the safe choice whenever the next value depends on the old one.

## Practice
Build a counter with a button that increases by three using three updater calls, then try the naive version and explain the difference.', 'setCount(prev => prev + 1) receives the latest pending value.
Calling setCount(count + 1) twice uses the same stale count.
The updater form is the safe choice whenever the next value depends on the old one.', 'd0plTCQgsXs', 6, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the updater form of a setter.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why it matters for batched updates.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use it in counters and toggles.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=d0plTCQgsXs'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState with previous state','https://www.youtube.com/results?search_query=useState+with+previous+state'),(@lesson,'React docs: Updating state based on the previous state','https://react.dev/reference/react/useState#updating-state-based-on-the-previous-state');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState with previous state','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which update is safe to repeat inside one handler?','The updater always sees the latest queued value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'setCount(prev => prev + 1)',1,0),(@q,'setCount(count + 1)',0,1),(@q,'count = count + 1',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','State setters run synchronously and change state immediately.','They schedule an update that React applies later.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState with previous state','Practise: Update state from its previous value safely','Build a counter with a button that increases by three using three updater calls, then try the naive version and explain the difference.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState with previous state: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 47: useState with object
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState with object', 'Store an object in state without losing fields.', 'Initialise state with an object.
Merge updates with the spread operator.', '## What this lesson covers

Store an object in state without losing fields.

- A state setter replaces the value it is given; it does not merge objects.
- Spread the old object and override the changed field.
- Keep objects flat where possible so updates stay simple.

## Key code
```jsx
const [user, setUser] = useState({ name: "", email: "" });
setUser((prev) => ({ ...prev, name: "Ada" }));
```

## Practice
Build a profile form holding name, email and city in one state object, update each field with one handler and confirm the other fields stay intact.', 'A state setter replaces the value it is given; it does not merge objects.
Spread the old object and override the changed field.
Keep objects flat where possible so updates stay simple.', '-3lL8oyev9w', 7, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Initialise state with an object.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Merge updates with the spread operator.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=-3lL8oyev9w'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState with object','https://www.youtube.com/results?search_query=useState+with+object'),(@lesson,'React docs: Objects in state','https://react.dev/learn/updating-objects-in-state');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState with object','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What happens if you call setUser({ name: "Ada" }) on an object state holding name, email and city?','React replaces the state value, so spread the old object.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'email and city are lost because the object is replaced',1,0),(@q,'They merge automatically',0,1),(@q,'It throws an error',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Spreading the old object keeps its other fields.','The spread copies existing properties first.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState with object','Practise: Store an object in state without losing fields','Build a profile form holding name, email and city in one state object, update each field with one handler and confirm the other fields stay intact.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState with object: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 48: useState with array
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState with array', 'Store and update arrays in state immutably.', 'Add items with the spread operator.
Remove and update items without mutation.', '## What this lesson covers

Store and update arrays in state immutably.

- Never push to a state array; create a new array instead.
- filter removes items, map updates them and spread appends.
- Always provide a key when you render the array.

## Key code
```jsx
setTags((prev) => [...prev, newTag]);
setTags((prev) => prev.filter((t) => t.id !== id));
setTags((prev) => prev.map((t) => (t.id === id ? { ...t, name: newName } : t)));
```

## Practice
Build a tag list: add a tag from an input, remove a tag with a button and rename a tag with map, never mutating the array.', 'Never push to a state array; create a new array instead.
filter removes items, map updates them and spread appends.
Always provide a key when you render the array.', 'RZ5wKYbOM_I', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add items with the spread operator.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Remove and update items without mutation.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=RZ5wKYbOM_I'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState with array','https://www.youtube.com/results?search_query=useState+with+array'),(@lesson,'React docs: Arrays in state','https://react.dev/learn/updating-arrays-in-state');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState with array','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which call removes an item from a state array by id?','filter returns a new array without the item.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'setTags(tags.filter(t => t.id !== id))',1,0),(@q,'tags.splice(index, 1)',0,1),(@q,'delete tags[id]',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','push modifies the array in place, so React may not re-render.','Mutating state breaks change detection.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState with array','Practise: Store and update arrays in state immutably','Build a tag list: add a tag from an input, remove a tag with a button and rename a tag with map, never mutating the array.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState with array: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Effects and Data Fetching
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Effects and Data Fetching',1);
SET @module=LAST_INSERT_ID();

-- Lesson 49: useEffect Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useEffect Hook', 'Run side effects after render with useEffect.', 'Add an effect to a component.
Explain when effects run.
Keep effects focused on one job.', '## What this lesson covers

Run side effects after render with useEffect.

- useEffect runs after the component renders and the DOM is updated.
- Effects are for work outside rendering: fetching, subscriptions, timers and manual DOM changes.
- Each effect should do one thing so its dependencies stay clear.

## Key code
```jsx
useEffect(() => {
  document.title = `Count: ${count}`;
});
```

## Practice
Add an effect that updates the document title with a counter value and confirm the tab name changes as you click.', 'useEffect runs after the component renders and the DOM is updated.
Effects are for work outside rendering: fetching, subscriptions, timers and manual DOM changes.
Each effect should do one thing so its dependencies stay clear.', '06Y6aJzTmXY', 4, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add an effect to a component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when effects run.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep effects focused on one job.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=06Y6aJzTmXY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useEffect Hook','https://www.youtube.com/results?search_query=useEffect+Hook'),(@lesson,'React docs: useEffect','https://react.dev/reference/react/useEffect');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useEffect Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does useEffect run?','Effects run after paint.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'After the component renders and the DOM is updated',1,0),(@q,'Before render',0,1),(@q,'Only on the server',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','useEffect is the place for side effects such as subscriptions.','Rendering must stay pure; effects handle the outside world.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useEffect Hook','Practise: Run side effects after render with useEffect','Add an effect that updates the document title with a counter value and confirm the tab name changes as you click.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useEffect Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 50: useEffect after render
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useEffect after render', 'Understand the default effect behaviour with no dependency array.', 'Explain what an effect without dependencies does.
Log renders to see it run.
Know when that is wasteful.', '## What this lesson covers

Understand the default effect behaviour with no dependency array.

- Without a dependency array the effect runs after every render.
- That is correct for work that must follow every change, such as syncing a title.
- It is wasteful for fetching or subscriptions, which usually need a dependency array.

## Practice
Log inside an effect in a component with two counters and observe how many times the effect runs after each click.', 'Without a dependency array the effect runs after every render.
That is correct for work that must follow every change, such as syncing a title.
It is wasteful for fetching or subscriptions, which usually need a dependency array.', 'nAuWOnFMlOw', 7, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what an effect without dependencies does.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Log renders to see it run.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know when that is wasteful.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=nAuWOnFMlOw'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useEffect after render','https://www.youtube.com/results?search_query=useEffect+after+render'),(@lesson,'React docs: Effect dependencies','https://react.dev/reference/react/useEffect#specifying-reactive-dependencies');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useEffect after render','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How often does an effect with no dependency array run?','There is no dependency list to limit it.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'After every render',1,0),(@q,'Only once',0,1),(@q,'Never',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An effect with no dependencies is usually right for fetching data.','Fetching usually belongs in an effect with dependencies.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useEffect after render','Practise: Understand the default effect behaviour with no dependency array','Log inside an effect in a component with two counters and observe how many times the effect runs after each click.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useEffect after render: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 51: Conditionally run effects
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Conditionally run effects', 'Limit an effect to the values it actually depends on.', 'Add a dependency array.
List every reactive value used.
Explain the lint warning.', '## What this lesson covers

Limit an effect to the values it actually depends on.

- The dependency array lists the values the effect reads.
- The effect re-runs only when one of those values changes.
- eslint-plugin-react-hooks reports missing dependencies; do not silence it without a reason.

## Practice
Add a dependency array to the title effect so it runs only when count changes, and confirm with console logs.', 'The dependency array lists the values the effect reads.
The effect re-runs only when one of those values changes.
eslint-plugin-react-hooks reports missing dependencies; do not silence it without a reason.', '8DYlzVUTC7s', 8, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Add a dependency array.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List every reactive value used.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the lint warning.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=8DYlzVUTC7s'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Conditionally run effects','https://www.youtube.com/results?search_query=Conditionally+run+effects'),(@lesson,'React docs: Dependencies','https://react.dev/reference/react/useEffect#specifying-reactive-dependencies');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Conditionally run effects','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does an effect with [count] run?','React compares the listed values between renders.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'When count changes, plus the first render',1,0),(@q,'On every render',0,1),(@q,'Only once',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','You may omit a dependency if the effect reads it.','Every reactive value the effect reads should be listed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Conditionally run effects','Practise: Limit an effect to the values it actually depends on','Add a dependency array to the title effect so it runs only when count changes, and confirm with console logs.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Conditionally run effects: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 52: Run effects only once
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Run effects only once', 'Run an effect exactly once when the component mounts.', 'Use an empty dependency array.
Fetch or subscribe on mount.
Know that it still runs twice in StrictMode.', '## What this lesson covers

Run an effect exactly once when the component mounts.

- An empty array tells React the effect has no dependencies, so it runs on mount only.
- This is the usual place for a first data request.
- In development StrictMode runs effects twice on purpose to reveal missing cleanup.

## Practice
Fetch a list of users once on mount with an empty dependency array and confirm the request appears only once in the network tab after the StrictMode double run.', 'An empty array tells React the effect has no dependencies, so it runs on mount only.
This is the usual place for a first data request.
In development StrictMode runs effects twice on purpose to reveal missing cleanup.', 'BH4xvzHa7H8', 5, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use an empty dependency array.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Fetch or subscribe on mount.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know that it still runs twice in StrictMode.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=BH4xvzHa7H8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Run effects only once','https://www.youtube.com/results?search_query=Run+effects+only+once'),(@lesson,'React docs: Effects on mount','https://react.dev/reference/react/useEffect');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Run effects only once','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which dependency array runs an effect only on mount?','An empty array means no dependencies.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'[]',1,0),(@q,'[true]',0,1),(@q,'no array',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','StrictMode double-invokes effects in development on purpose.','It helps you find cleanup bugs.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Run effects only once','Practise: Run an effect exactly once when the component mounts','Fetch a list of users once on mount with an empty dependency array and confirm the request appears only once in the network tab after the StrictMode double run.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Run effects only once: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 53: useEffect with cleanup
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useEffect with cleanup', 'Clean up timers and subscriptions in an effect.', 'Return a cleanup function.
Clear timers and listeners.
Explain when cleanup runs.', '## What this lesson covers

Clean up timers and subscriptions in an effect.

- An effect can return a function that React calls before the next run and on unmount.
- Cleanup prevents leaks such as running intervals or duplicate listeners.
- Every subscription must have a matching unsubscribe.

## Key code
```jsx
useEffect(() => {
  const id = setInterval(() => setTick((t) => t + 1), 1000);
  return () => clearInterval(id);
}, []);
```

## Practice
Build a component with an interval that updates a clock, add cleanup so it never runs twice and unmount it to prove the interval stops.', 'An effect can return a function that React calls before the next run and on unmount.
Cleanup prevents leaks such as running intervals or duplicate listeners.
Every subscription must have a matching unsubscribe.', 'DTlmk6QeOHY', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return a cleanup function.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Clear timers and listeners.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when cleanup runs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=DTlmk6QeOHY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useEffect with cleanup','https://www.youtube.com/results?search_query=useEffect+with+cleanup'),(@lesson,'React docs: Cleaning up an effect','https://react.dev/reference/react/useEffect#cleaning-up-an-effect');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useEffect with cleanup','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does an effect cleanup function run?','Cleanup also runs before each re-run.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Before the effect runs again and on unmount',1,0),(@q,'Only on unmount',0,1),(@q,'Never',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An interval without cleanup keeps running after unmount.','It leaks work and can warn about updating unmounted components.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useEffect with cleanup','Practise: Clean up timers and subscriptions in an effect','Build a component with an interval that updates a clock, add cleanup so it never runs twice and unmount it to prove the interval stops.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useEffect with cleanup: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 54: useEffect with incorrect dependency
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useEffect with incorrect dependency', 'Spot and fix an incorrect dependency list.', 'Recognise stale values in an effect.
Fix missing dependencies.
Use the lint rule.', '## What this lesson covers

Spot and fix an incorrect dependency list.

- A missing dependency makes the effect read an old value, which causes stale UI or extra requests.
- Including the dependency makes the effect re-run when that value changes.
- The exhaustive-deps lint rule reports every missing dependency.

## Practice
Write an effect that fetches a user by id while leaving id out of the dependencies, then click through ids to see the stale bug and fix it.', 'A missing dependency makes the effect read an old value, which causes stale UI or extra requests.
Including the dependency makes the effect re-run when that value changes.
The exhaustive-deps lint rule reports every missing dependency.', 'SP-NrbQHFww', 10, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise stale values in an effect.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Fix missing dependencies.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the lint rule.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=SP-NrbQHFww'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useEffect with incorrect dependency','https://www.youtube.com/results?search_query=useEffect+with+incorrect+dependency'),(@lesson,'React docs: Removing effect dependencies','https://react.dev/learn/removing-effect-dependencies');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useEffect with incorrect dependency','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is the symptom of a missing dependency?','The effect does not re-run when the value changes.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The effect reads an old value and shows stale data',1,0),(@q,'A syntax error',0,1),(@q,'The component will not compile',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The exhaustive-deps lint rule lists missing dependencies.','It is the fastest way to catch the problem.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useEffect with incorrect dependency','Practise: Spot and fix an incorrect dependency list','Write an effect that fetches a user by id while leaving id out of the dependencies, then click through ids to see the stale bug and fix it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useEffect with incorrect dependency: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 55: Fetching data with useEffect Part 1
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching data with useEffect Part 1', 'Fetch data in an effect, part one: the request and loading state.', 'Start a request in an effect.
Track loading and error state.
Render while loading.', '## What this lesson covers

Fetch data in an effect, part one: the request and loading state.

- Fetch inside an effect with an empty dependency array for a first load.
- A loading flag avoids rendering empty lists while waiting.
- Check response.ok and store the error message.

## Key code
```jsx
const [users, setUsers] = useState([]);
const [status, setStatus] = useState("loading");

useEffect(() => {
  let cancelled = false;
  fetch("https://jsonplaceholder.typicode.com/users")
    .then((r) => { if (!r.ok) throw new Error("Failed"); return r.json(); })
    .then((data) => { if (!cancelled) { setUsers(data); setStatus("done"); } })
    .catch(() => { if (!cancelled) setStatus("error"); });
  return () => { cancelled = true; };
}, []);
```

## Practice
Create a users page that fetches on mount, shows a skeleton while loading and an error message when the request fails.', 'Fetch inside an effect with an empty dependency array for a first load.
A loading flag avoids rendering empty lists while waiting.
Check response.ok and store the error message.', 'bYFYF2GnMy8', 6, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Start a request in an effect.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Track loading and error state.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Render while loading.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=bYFYF2GnMy8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Fetching data with useEffect Part 1','https://www.youtube.com/results?search_query=Fetching+data+with+useEffect+Part+1'),(@lesson,'React docs: Fetching data','https://react.dev/learn/synchronizing-with-effects#fetching-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching data with useEffect Part 1','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should the component render while a request is in flight?','A loading state keeps the interface understandable.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A loading state such as a skeleton or spinner',1,0),(@q,'Nothing at all',0,1),(@q,'An error message',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','response.ok is false for a 404 response.','Only 2xx responses are ok.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching data with useEffect Part 1','Practise: Fetch data in an effect, part one: the request and loading state','Create a users page that fetches on mount, shows a skeleton while loading and an error message when the request fails.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching data with useEffect Part 1: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 56: Fetching data with useEffect Part 2
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching data with useEffect Part 2', 'Fetch data in an effect, part two: render the results as a list.', 'Map results into components.
Use stable keys.
Extract an item component.', '## What this lesson covers

Fetch data in an effect, part two: render the results as a list.

- Render the fetched array with map and a key from the record id.
- Extract a UserCard component to keep the page readable.
- Handle the empty case with a short message.

## Practice
Render the fetched users as cards showing name, email and city, with a message when the list is empty.', 'Render the fetched array with map and a key from the record id.
Extract a UserCard component to keep the page readable.
Handle the empty case with a short message.', '1tfd6ANaNRY', 5, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Map results into components.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use stable keys.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Extract an item component.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=1tfd6ANaNRY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Fetching data with useEffect Part 2','https://www.youtube.com/results?search_query=Fetching+data+with+useEffect+Part+2'),(@lesson,'React docs: Rendering lists','https://react.dev/learn/rendering-lists');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching data with useEffect Part 2','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which value should be the key for fetched records?','API ids are stable and unique.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The record id from the API',1,0),(@q,'The array index',0,1),(@q,'The record name',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An empty result should still show a message.','Empty states explain why nothing is shown.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching data with useEffect Part 2','Practise: Fetch data in an effect, part two: render the results as a list','Render the fetched users as cards showing name, email and city, with a message when the list is empty.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching data with useEffect Part 2: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 57: Fetching data with useEffect Part 3
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching data with useEffect Part 3', 'Fetch data in an effect, part three: respond to a selected item.', 'Re-fetch when a dependency changes.
Show item details.
Cancel outdated requests.', '## What this lesson covers

Fetch data in an effect, part three: respond to a selected item.

- Add the selected id to the dependency array so the effect re-runs.
- Ignore responses that arrive after the value changed.
- An AbortController cancels the previous request cleanly.

## Practice
Add a user selector: clicking a user fetches their details and the request only runs for the selected id.', 'Add the selected id to the dependency array so the effect re-runs.
Ignore responses that arrive after the value changed.
An AbortController cancels the previous request cleanly.', 'zm_09NER-R0', 3, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Re-fetch when a dependency changes.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Show item details.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Cancel outdated requests.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=zm_09NER-R0'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Fetching data with useEffect Part 3','https://www.youtube.com/results?search_query=Fetching+data+with+useEffect+Part+3'),(@lesson,'React docs: Fetching data with a dependency','https://react.dev/learn/synchronizing-with-effects#fetching-data');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching data with useEffect Part 3','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you make an effect re-run when the selected id changes?','Dependencies control re-runs.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'List the id in the dependency array',1,0),(@q,'Call the effect twice',0,1),(@q,'Use a ref',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Outdated responses can arrive after newer ones.','Always ignore or cancel stale requests.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching data with useEffect Part 3','Practise: Fetch data in an effect, part three: respond to a selected item','Add a user selector: clicking a user fetches their details and the request only runs for the selected id.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching data with useEffect Part 3: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Context and Reducers
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Context and Reducers',2);
SET @module=LAST_INSERT_ID();

-- Lesson 58: useContext Hook Part 1
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useContext Hook Part 1', 'Use context with hooks, part one: the shared value.', 'Create a context for a shared value.
Wrap a subtree in a provider.', '## What this lesson covers

Use context with hooks, part one: the shared value.

- Context removes the need to pass a value through every component.
- The provider value can be any shape, including objects and functions.
- Components outside the provider read the default value.

## Practice
Create a UserContext with a default of null and wrap the profile section of your app in a provider.', 'Context removes the need to pass a value through every component.
The provider value can be any shape, including objects and functions.
Components outside the provider read the default value.', 'CI7EYWmRDJE', 4, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a context for a shared value.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap a subtree in a provider.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=CI7EYWmRDJE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useContext Hook Part 1','https://www.youtube.com/results?search_query=useContext+Hook+Part+1'),(@lesson,'React docs: createContext','https://react.dev/reference/react/createContext');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useContext Hook Part 1','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which component makes a context value available to a subtree?','Providers set the value for their children.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The provider',1,0),(@q,'The consumer',0,1),(@q,'The hook',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Context is only for global application state.','It is useful for any value shared by a subtree.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useContext Hook Part 1','Practise: Use context with hooks, part one: the shared value','Create a UserContext with a default of null and wrap the profile section of your app in a provider.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useContext Hook Part 1: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 59: useContext Hook Part 2
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useContext Hook Part 2', 'Use context with hooks, part two: read it with useContext.', 'Read a value with useContext.
Consume it inside a deep child.
Keep the provider high enough.', '## What this lesson covers

Use context with hooks, part two: read it with useContext.

- useContext(UserContext) returns the nearest provider value.
- Consumers re-render when the provided value changes.
- Place the provider above every component that needs the value.

## Key code
```jsx
const UserContext = createContext(null);

function Avatar() {
  const user = useContext(UserContext);
  return <img src={user?.avatar} alt={user?.name ?? "Guest"} />;
}
```

## Practice
Read the user name in a component three levels deep with useContext instead of props and confirm the prop chain is gone.', 'useContext(UserContext) returns the nearest provider value.
Consumers re-render when the provided value changes.
Place the provider above every component that needs the value.', 'tEqNSOhCHLU', 6, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read a value with useContext.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Consume it inside a deep child.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the provider high enough.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=tEqNSOhCHLU'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useContext Hook Part 2','https://www.youtube.com/results?search_query=useContext+Hook+Part+2'),(@lesson,'React docs: useContext','https://react.dev/reference/react/useContext');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useContext Hook Part 2','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does useContext return?','It returns the current value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The nearest provider value for that context',1,0),(@q,'A setter function only',0,1),(@q,'The provider component',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Changing a context value re-renders the consumers.','Consumers read the value and update when it changes.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useContext Hook Part 2','Practise: Use context with hooks, part two: read it with useContext','Read the user name in a component three levels deep with useContext instead of props and confirm the prop chain is gone.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useContext Hook Part 2: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 60: useContext Hook Part 3
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useContext Hook Part 3', 'Use context with hooks, part three: several contexts and updates.', 'Nest providers for several contexts.
Provide update functions through context.', '## What this lesson covers

Use context with hooks, part three: several contexts and updates.

- Each context is independent and can be nested.
- Passing a setter through context lets deep children trigger updates.
- Memoise object values to avoid re-rendering every consumer on each render.

## Key code
```jsx
const value = useMemo(() => ({ user, setUser }), [user]);
<UserContext.Provider value={value}>{children}</UserContext.Provider>
```

## Practice
Add a ThemeContext and a UserContext to the same tree, with a toggle function supplied through context, and switch the theme from a deep child.', 'Each context is independent and can be nested.
Passing a setter through context lets deep children trigger updates.
Memoise object values to avoid re-rendering every consumer on each render.', 'UjjtvroahBU', 3, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Nest providers for several contexts.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Provide update functions through context.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=UjjtvroahBU'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useContext Hook Part 3','https://www.youtube.com/results?search_query=useContext+Hook+Part+3'),(@lesson,'React docs: Scaling context','https://react.dev/reference/react/useContext#optimizing-re-renders-when-passing-objects-and-functions');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useContext Hook Part 3','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why memoise a context value object?','Consumers compare the value reference.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A new object each render re-renders every consumer',1,0),(@q,'It makes CSS faster',0,1),(@q,'Because React requires it',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Several providers can wrap the same subtree.','Contexts can be nested freely.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useContext Hook Part 3','Practise: Use context with hooks, part three: several contexts and updates','Add a ThemeContext and a UserContext to the same tree, with a toggle function supplied through context, and switch the theme from a deep child.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useContext Hook Part 3: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 61: useReducer Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useReducer Hook', 'Manage complex state with useReducer.', 'Explain the reducer pattern.
Write a reducer function.
Dispatch actions.', '## What this lesson covers

Manage complex state with useReducer.

- useReducer takes a reducer function and an initial state and returns state and dispatch.
- The reducer receives the current state and an action and returns the next state.
- Every state change is described by a named action, which makes complex logic easier to follow.

## Key code
```jsx
function reducer(state, action) {
  switch (action.type) {
    case "increment": return { count: state.count + 1 };
    case "decrement": return { count: state.count - 1 };
    case "reset": return { count: 0 };
    default: return state;
  }
}
const [state, dispatch] = useReducer(reducer, { count: 0 });
```

## Practice
Write a reducer for a counter with increment, decrement and reset actions and use it in a component with three buttons.', 'useReducer takes a reducer function and an initial state and returns state and dispatch.
The reducer receives the current state and an action and returns the next state.
Every state change is described by a named action, which makes complex logic easier to follow.', 'cVYp4u1m6iA', 9, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the reducer pattern.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write a reducer function.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Dispatch actions.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=cVYp4u1m6iA'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useReducer Hook','https://www.youtube.com/results?search_query=useReducer+Hook'),(@lesson,'React docs: useReducer','https://react.dev/reference/react/useReducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useReducer Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a reducer function return?','Reducers are pure functions from state and action to state.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The next state',1,0),(@q,'An action',0,1),(@q,'A component',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A reducer may call fetch or setState inside itself.','Reducers must stay pure; side effects belong elsewhere.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useReducer Hook','Practise: Manage complex state with useReducer','Write a reducer for a counter with increment, decrement and reset actions and use it in a component with three buttons.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useReducer Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 62: useReducer (simple state and action)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useReducer (simple state and action)', 'Apply useReducer to a simple state and action.', 'Create a simple reducer with one action type.
Dispatch from a button.', '## What this lesson covers

Apply useReducer to a simple state and action.

- Start with one value and one action to see the pattern clearly.
- Always return the current state for unknown actions.
- The action object can carry a payload when needed.

## Practice
Convert the counter from useState to useReducer and confirm the behaviour is identical.', 'Start with one value and one action to see the pattern clearly.
Always return the current state for unknown actions.
The action object can carry a payload when needed.', 'IHJ-TO_1nME', 10, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a simple reducer with one action type.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Dispatch from a button.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=IHJ-TO_1nME'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useReducer (simple state and action)','https://www.youtube.com/results?search_query=useReducer+(simple+state+and+action)'),(@lesson,'React docs: useReducer example','https://react.dev/reference/react/useReducer#adding-a-reducer-to-a-component');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useReducer (simple state and action)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should a reducer return for an unknown action?','Returning state keeps the app stable.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The current state unchanged',1,0),(@q,'null',0,1),(@q,'An error',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','useReducer and useState can express the same counter logic.','Either works; useReducer scales better as logic grows.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useReducer (simple state and action)','Practise: Apply useReducer to a simple state and action','Convert the counter from useState to useReducer and confirm the behaviour is identical.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useReducer (simple state and action): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 63: useReducer (complex state and action)
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useReducer (complex state and action)', 'Handle complex state and actions in a reducer.', 'Use object state in a reducer.
Pass payloads in actions.', '## What this lesson covers

Handle complex state and actions in a reducer.

- Complex state such as forms or carts fits a reducer well.
- Actions carry a payload, for example { type: "add", item }.
- Immutable updates inside the reducer keep React informed.

## Key code
```jsx
function cartReducer(state, action) {
  switch (action.type) {
    case "add":
      return { items: [...state.items, action.item] };
    case "clear":
      return { items: [] };
    default:
      return state;
  }
}
```

## Practice
Build a shopping cart reducer with add, remove and clear actions that carry payloads and update a total.', 'Complex state such as forms or carts fits a reducer well.
Actions carry a payload, for example { type: "add", item }.
Immutable updates inside the reducer keep React informed.', 'uX7lxFrWUbA', 9, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use object state in a reducer.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass payloads in actions.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=uX7lxFrWUbA'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useReducer (complex state and action)','https://www.youtube.com/results?search_query=useReducer+(complex+state+and+action)'),(@lesson,'React docs: useReducer with objects','https://react.dev/reference/react/useReducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useReducer (complex state and action)','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where does data needed by an action go?','The second argument carries the payload.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In the action object as a payload',1,0),(@q,'In a global variable',0,1),(@q,'In the reducer signature',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A reducer should mutate the existing state object.','Return new objects and arrays instead.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useReducer (complex state and action)','Practise: Handle complex state and actions in a reducer','Build a shopping cart reducer with add, remove and clear actions that carry payloads and update a total.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useReducer (complex state and action): apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 64: Multiple useReducers
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Multiple useReducers', 'Use several reducers in one component.', 'Call useReducer twice.
Keep unrelated state in separate reducers.', '## What this lesson covers

Use several reducers in one component.

- Multiple useReducer calls are fine; each manages its own state.
- Split reducers by concern so each stays small.
- Avoid one giant reducer that knows everything.

## Practice
Build a screen with a counter reducer and a text reducer, and show that dispatching to one does not affect the other.', 'Multiple useReducer calls are fine; each manages its own state.
Split reducers by concern so each stays small.
Avoid one giant reducer that knows everything.', '5DsCKNRA8s4', 3, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call useReducer twice.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep unrelated state in separate reducers.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=5DsCKNRA8s4'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Multiple useReducers','https://www.youtube.com/results?search_query=Multiple+useReducers'),(@lesson,'React docs: useReducer','https://react.dev/reference/react/useReducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Multiple useReducers','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which is the better structure for unrelated pieces of state?','Small reducers are easier to test and read.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Separate reducers per concern',1,0),(@q,'One large reducer for everything',0,1),(@q,'A reducer plus a ref',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Calling useReducer twice is allowed.','Hooks can be called multiple times at the top level.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Multiple useReducers','Practise: Use several reducers in one component','Build a screen with a counter reducer and a text reducer, and show that dispatching to one does not affect the other.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Multiple useReducers: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 65: useReducer with useContext
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useReducer with useContext', 'Share reducer state across the app with context.', 'Hold useReducer in a provider.
Read state with context.
Dispatch actions from deep children.', '## What this lesson covers

Share reducer state across the app with context.

- The provider owns useReducer and passes state and dispatch through context.
- Deep children can dispatch without prop drilling.
- Memoise the context value so consumers do not re-render needlessly.

## Practice
Build a small theme and counter store with useReducer plus context and toggle it from a component three levels deep.', 'The provider owns useReducer and passes state and dispatch through context.
Deep children can dispatch without prop drilling.
Memoise the context value so consumers do not re-render needlessly.', 'BCD2irXaVoE', 12, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Hold useReducer in a provider.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read state with context.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Dispatch actions from deep children.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=BCD2irXaVoE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useReducer with useContext','https://www.youtube.com/results?search_query=useReducer+with+useContext'),(@lesson,'React docs: Scaling up with reducer and context','https://react.dev/learn/scaling-up-with-reducer-and-context');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useReducer with useContext','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where should the reducer state live in this pattern?','The provider is the single source of truth.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In the provider component',1,0),(@q,'In every consumer',0,1),(@q,'In localStorage only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Splitting state and dispatch into separate contexts reduces re-renders.','Components that only dispatch do not depend on state changes.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useReducer with useContext','Practise: Share reducer state across the app with context','Build a small theme and counter store with useReducer plus context and toggle it from a component three levels deep.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useReducer with useContext: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 66: Fetching data with useReducer Part 1
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching data with useReducer Part 1', 'Fetch data with useReducer, part one: model the states.', 'Model loading, success and error states.
Dispatch from an effect.', '## What this lesson covers

Fetch data with useReducer, part one: model the states.

- A reducer keeps fetch states explicit: loading, success and error.
- The effect performs the request and dispatches actions.
- The component reads state.status to decide what to render.

## Key code
```jsx
function reducer(state, action) {
  switch (action.type) {
    case "loading": return { status: "loading", data: null };
    case "success": return { status: "done", data: action.data };
    case "error": return { status: "error", data: null };
    default: return state;
  }
}
```

## Practice
Rewrite the user fetch with useReducer using status and data fields and render a loading and error branch.', 'A reducer keeps fetch states explicit: loading, success and error.
The effect performs the request and dispatches actions.
The component reads state.status to decide what to render.', 'snzS7-73SEQ', 7, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Model loading, success and error states.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Dispatch from an effect.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=snzS7-73SEQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Fetching data with useReducer Part 1','https://www.youtube.com/results?search_query=Fetching+data+with+useReducer+Part+1'),(@lesson,'React docs: useReducer with data fetching','https://react.dev/reference/react/useReducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching data with useReducer Part 1','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which state shape fits fetching well?','A status field makes the UI branches clear.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'{ status, data, error }',1,0),(@q,'A single boolean',0,1),(@q,'An array of errors',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The effect should dispatch actions instead of setting state directly.','Reducers centralise the transitions.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching data with useReducer Part 1','Practise: Fetch data with useReducer, part one: model the states','Rewrite the user fetch with useReducer using status and data fields and render a loading and error branch.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching data with useReducer Part 1: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 67: Fetching data with useReducer Part 2
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Fetching data with useReducer Part 2', 'Fetch data with useReducer, part two: fetch by id.', 'Re-fetch on id change.
Reset state when parameters change.', '## What this lesson covers

Fetch data with useReducer, part two: fetch by id.

- Add the id to the effect dependencies and dispatch loading before the request.
- Reset stale data when the request parameters change.
- Show the selected item with its own request.

## Practice
Add an id selector to the reducer-based fetch, dispatch loading on each change and confirm no stale data flashes.', 'Add the id to the effect dependencies and dispatch loading before the request.
Reset stale data when the request parameters change.
Show the selected item with its own request.', 'imjfiXxvMD8', 7, 1, 1, 9, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Re-fetch on id change.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reset state when parameters change.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=imjfiXxvMD8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Fetching data with useReducer Part 2','https://www.youtube.com/results?search_query=Fetching+data+with+useReducer+Part+2'),(@lesson,'React docs: useReducer','https://react.dev/reference/react/useReducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Fetching data with useReducer Part 2','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should be dispatched before starting a new request?','Clearing old data prevents stale flashes.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A loading action that clears old data',1,0),(@q,'The success action',0,1),(@q,'Nothing',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The effect must depend on the id it fetches.','Otherwise it never re-runs for a new id.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Fetching data with useReducer Part 2','Practise: Fetch data with useReducer, part two: fetch by id','Add an id selector to the reducer-based fetch, dispatch loading on each change and confirm no stale data flashes.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Fetching data with useReducer Part 2: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 68: useState vs useReducer
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState vs useReducer', 'Choose between useState and useReducer.', 'Compare the two hooks.
Pick based on complexity.
Recognise when to refactor.', '## What this lesson covers

Choose between useState and useReducer.

- useState is best for simple, independent values.
- useReducer shines when several fields change together or the next state depends on many rules.
- If you are writing many setters that must stay consistent, move to a reducer.

## Practice
Look at a form with six related fields and decide which hook fits, then justify the choice in two sentences.', 'useState is best for simple, independent values.
useReducer shines when several fields change together or the next state depends on many rules.
If you are writing many setters that must stay consistent, move to a reducer.', '3VClygDRSsU', 4, 1, 1, 10, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Compare the two hooks.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pick based on complexity.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise when to refactor.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=3VClygDRSsU'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState vs useReducer','https://www.youtube.com/results?search_query=useState+vs+useReducer'),(@lesson,'React docs: useState vs useReducer','https://react.dev/learn/extracting-state-logic-into-a-reducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState vs useReducer','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When is useReducer the better choice?','Reducers centralise multi-field transitions.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'When state transitions are complex or several values change together',1,0),(@q,'For every piece of state',0,1),(@q,'When you need CSS',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','useReducer requires more boilerplate than useState.','The extra structure pays off only when the logic is complex.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState vs useReducer','Practise: Choose between useState and useReducer','Look at a form with six related fields and decide which hook fits, then justify the choice in two sentences.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState vs useReducer: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Performance and Custom Hooks
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Performance and Custom Hooks',3);
SET @module=LAST_INSERT_ID();

-- Lesson 69: useCallback Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useCallback Hook', 'Keep a function reference stable with useCallback.', 'Wrap a handler in useCallback.
List its dependencies.
Explain when it is unnecessary.', '## What this lesson covers

Keep a function reference stable with useCallback.

- useCallback returns the same function reference until a dependency changes.
- It matters when the function is passed to a memoised child or used in an effect dependency.
- Adding useCallback everywhere adds noise without benefit.

## Key code
```jsx
const handleDelete = useCallback((id) => {
  setItems((prev) => prev.filter((item) => item.id !== id));
}, []);
```

## Practice
Pass a handler to a React.memo child with and without useCallback, log child renders and compare.', 'useCallback returns the same function reference until a dependency changes.
It matters when the function is passed to a memoised child or used in an effect dependency.
Adding useCallback everywhere adds noise without benefit.', 'IL82CzlaCys', 15, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap a handler in useCallback.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List its dependencies.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when it is unnecessary.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=IL82CzlaCys'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useCallback Hook','https://www.youtube.com/results?search_query=useCallback+Hook'),(@lesson,'React docs: useCallback','https://react.dev/reference/react/useCallback');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useCallback Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does useCallback return a new function?','It memoises until the dependencies change.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'When a dependency changes',1,0),(@q,'On every render',0,1),(@q,'Never',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','useCallback makes the function itself run faster.','It only keeps the reference stable.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useCallback Hook','Practise: Keep a function reference stable with useCallback','Pass a handler to a React.memo child with and without useCallback, log child renders and compare.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useCallback Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 70: useMemo Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useMemo Hook', 'Cache expensive calculations with useMemo.', 'Wrap a computation in useMemo.
List dependencies.
Avoid using it for side effects.', '## What this lesson covers

Cache expensive calculations with useMemo.

- useMemo returns a cached value until a dependency changes.
- Use it for genuinely expensive calculations or for stable object references.
- Do not put fetching or logging inside useMemo.

## Key code
```jsx
const sorted = useMemo(
  () => [...items].sort((a, b) => a.price - b.price),
  [items]
);
```

## Practice
Build a filtered and sorted list from a thousand records, measure it without useMemo, then add useMemo and compare the profile.', 'useMemo returns a cached value until a dependency changes.
Use it for genuinely expensive calculations or for stable object references.
Do not put fetching or logging inside useMemo.', 'qySZIzZvZOY', 11, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap a computation in useMemo.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List dependencies.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Avoid using it for side effects.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=qySZIzZvZOY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useMemo Hook','https://www.youtube.com/results?search_query=useMemo+Hook'),(@lesson,'React docs: useMemo','https://react.dev/reference/react/useMemo');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useMemo Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does useMemo return?','useCallback caches functions; useMemo caches values.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A cached value',1,0),(@q,'A cached function',0,1),(@q,'A DOM node',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','useMemo is the right place for a fetch request.','Effects are for side effects.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useMemo Hook','Practise: Cache expensive calculations with useMemo','Build a filtered and sorted list from a thousand records, measure it without useMemo, then add useMemo and compare the profile.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useMemo Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 71: useRef Hook Part 1
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useRef Hook Part 1', 'Hold values that survive renders with useRef.', 'Create a ref with useRef.
Store a timer id or node.
Explain why refs do not re-render.', '## What this lesson covers

Hold values that survive renders with useRef.

- useRef returns an object with a current property that persists across renders.
- Changing current does not trigger a render, which suits timers and DOM nodes.
- Never read ref.current during render to decide what to display.

## Practice
Store an interval id in a ref so a stop button can clear it, and log the value to prove it persists across renders.', 'useRef returns an object with a current property that persists across renders.
Changing current does not trigger a render, which suits timers and DOM nodes.
Never read ref.current during render to decide what to display.', 'yCS2m01bQ6w', 4, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a ref with useRef.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Store a timer id or node.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why refs do not re-render.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=yCS2m01bQ6w'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useRef Hook Part 1','https://www.youtube.com/results?search_query=useRef+Hook+Part+1'),(@lesson,'React docs: useRef','https://react.dev/reference/react/useRef');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useRef Hook Part 1','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which value persists across renders without causing a re-render?','Refs persist and stay silent.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A ref value',1,0),(@q,'A state value',0,1),(@q,'A local variable',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Reading ref.current during render to display data is recommended.','Visible data belongs in state so React can re-render.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useRef Hook Part 1','Practise: Hold values that survive renders with useRef','Store an interval id in a ref so a stop button can clear it, and log the value to prove it persists across renders.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useRef Hook Part 1: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 72: useRef Hook Part 2
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useRef Hook Part 2', 'Use refs for focus, previous values and click counts.', 'Focus an input with a ref.
Track a previous value.
Count renders safely.', '## What this lesson covers

Use refs for focus, previous values and click counts.

- Refs are ideal for imperative actions such as focus and scroll.
- A ref can remember the previous value between renders.
- Counting renders with a ref avoids a render loop.

## Key code
```jsx
const inputRef = useRef(null);
const renders = useRef(0);
renders.current += 1;

useEffect(() => { inputRef.current?.focus(); }, []);
```

## Practice
Build a search form that focuses the input on mount and shows how many times the component rendered using a ref counter.', 'Refs are ideal for imperative actions such as focus and scroll.
A ref can remember the previous value between renders.
Counting renders with a ref avoids a render loop.', 'LWg0OyZQffc', 10, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Focus an input with a ref.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Track a previous value.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Count renders safely.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=LWg0OyZQffc'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useRef Hook Part 2','https://www.youtube.com/results?search_query=useRef+Hook+Part+2'),(@lesson,'React docs: useRef examples','https://react.dev/reference/react/useRef');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useRef Hook Part 2','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which task suits a ref best?','Focus is an imperative browser action.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Focusing an input',1,0),(@q,'Storing the visible list of items',0,1),(@q,'Holding form values',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Updating a ref counter inside useEffect can cause a render loop.','Ref updates do not trigger renders.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useRef Hook Part 2','Practise: Use refs for focus, previous values and click counts','Build a search form that focuses the input on mount and shows how many times the component rendered using a ref counter.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useRef Hook Part 2: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 73: Custom Hooks
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Custom Hooks', 'Extract reusable logic into a custom hook.', 'Create a function starting with use.
Call other hooks inside it.
Return what the component needs.', '## What this lesson covers

Extract reusable logic into a custom hook.

- A custom hook is a function whose name starts with use and that calls other hooks.
- It shares logic, not state: each call gets its own state.
- Return an object or array that matches how callers will use it.

## Key code
```jsx
function useCounter(start = 0) {
  const [count, setCount] = useState(start);
  const increment = () => setCount((c) => c + 1);
  return { count, increment };
}
```

## Practice
Extract the interval counter from earlier lessons into a useCounter custom hook and use it in two different components.', 'A custom hook is a function whose name starts with use and that calls other hooks.
It shares logic, not state: each call gets its own state.
Return an object or array that matches how callers will use it.', 'l-s9MgoMwTI', 2, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a function starting with use.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Call other hooks inside it.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return what the component needs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=l-s9MgoMwTI'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Custom Hooks','https://www.youtube.com/results?search_query=Custom+Hooks'),(@lesson,'React docs: Custom hooks','https://react.dev/learn/reusing-logic-with-custom-hooks');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Custom Hooks','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which naming rule applies to custom hooks?','The prefix lets the lint rules treat it as a hook.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The name must start with use',1,0),(@q,'The name must start with get',0,1),(@q,'Any name works',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Two components using the same custom hook share the same state.','Each call creates independent state.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Custom Hooks','Practise: Extract reusable logic into a custom hook','Extract the interval counter from earlier lessons into a useCounter custom hook and use it in two different components.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Custom Hooks: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 74: useDocumentTitle Custom Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useDocumentTitle Custom Hook', 'Build a useDocumentTitle hook that syncs the tab title.', 'Update document.title in an effect.
Accept a parameter.
Keep the hook reusable.', '## What this lesson covers

Build a useDocumentTitle hook that syncs the tab title.

- The hook takes a title string and updates the document in an effect.
- The title must be a dependency so changes apply.
- Clean up by restoring the previous title when the component unmounts.

## Key code
```jsx
function useDocumentTitle(title) {
  useEffect(() => {
    const previous = document.title;
    document.title = title;
    return () => { document.title = previous; };
  }, [title]);
}
```

## Practice
Create useDocumentTitle(title) and use it on two pages, then confirm the tab title changes as you navigate.', 'The hook takes a title string and updates the document in an effect.
The title must be a dependency so changes apply.
Clean up by restoring the previous title when the component unmounts.', '4yp6T-hF5ZY', 9, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Update document.title in an effect.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Accept a parameter.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep the hook reusable.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=4yp6T-hF5ZY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useDocumentTitle Custom Hook','https://www.youtube.com/results?search_query=useDocumentTitle+Custom+Hook'),(@lesson,'React docs: Custom hooks','https://react.dev/learn/reusing-logic-with-custom-hooks');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useDocumentTitle Custom Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which API sets the browser tab title?','The title property updates the tab text.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'document.title',1,0),(@q,'window.name',0,1),(@q,'document.head',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A custom hook may use useEffect internally.','Custom hooks can call any built-in hook.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useDocumentTitle Custom Hook','Practise: Build a useDocumentTitle hook that syncs the tab title','Create useDocumentTitle(title) and use it on two pages, then confirm the tab title changes as you navigate.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useDocumentTitle Custom Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 75: useCounter Custom Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useCounter Custom Hook', 'Build a useCounter hook with increment, decrement and reset.', 'Design the hook API.
Expose several actions.
Reuse it in two components.', '## What this lesson covers

Build a useCounter hook with increment, decrement and reset.

- Return the value plus the actions callers need.
- Use updater functions so rapid clicks stay correct.
- Accept an initial value and a step so the hook fits more cases.

## Practice
Write useCounter(initial, step) returning count, increment, decrement and reset, then use it for a quantity selector and a likes button.', 'Return the value plus the actions callers need.
Use updater functions so rapid clicks stay correct.
Accept an initial value and a step so the hook fits more cases.', 'W3_GIiN-nuc', 8, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Design the hook API.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Expose several actions.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reuse it in two components.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=W3_GIiN-nuc'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useCounter Custom Hook','https://www.youtube.com/results?search_query=useCounter+Custom+Hook'),(@lesson,'React docs: Custom hooks','https://react.dev/learn/reusing-logic-with-custom-hooks');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useCounter Custom Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pattern keeps rapid increments correct?','Updaters always read the latest value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Updater functions such as setCount(c => c + step)',1,0),(@q,'setCount(count + step)',0,1),(@q,'A ref',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A custom hook should expose only what callers need.','Small APIs are easier to reuse.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useCounter Custom Hook','Practise: Build a useCounter hook with increment, decrement and reset','Write useCounter(initial, step) returning count, increment, decrement and reset, then use it for a quantity selector and a likes button.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useCounter Custom Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 76: useInput Custom Hook
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useInput Custom Hook', 'Build a useInput hook for controlled fields.', 'Manage value and change handling in one hook.
Expose a reset action.
Reuse it for several inputs.', '## What this lesson covers

Build a useInput hook for controlled fields.

- useInput returns value, onChange, reset and bind props for an input.
- It removes repeated controlled-input boilerplate.
- Keep the hook generic: no field-specific validation inside.

## Key code
```jsx
function useInput(initial = "") {
  const [value, setValue] = useState(initial);
  const onChange = (e) => setValue(e.target.value);
  const reset = () => setValue(initial);
  return { value, onChange, reset };
}
```

## Practice
Write useInput(initialValue) and use it for a login form with email and password fields plus a reset button.', 'useInput returns value, onChange, reset and bind props for an input.
It removes repeated controlled-input boilerplate.
Keep the hook generic: no field-specific validation inside.', '6am-yn3ZLEw', 10, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Manage value and change handling in one hook.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Expose a reset action.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reuse it for several inputs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=6am-yn3ZLEw'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useInput Custom Hook','https://www.youtube.com/results?search_query=useInput+Custom+Hook'),(@lesson,'React docs: Custom hooks','https://react.dev/learn/reusing-logic-with-custom-hooks');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useInput Custom Hook','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What should a useInput hook return for easy binding?','Returning bind props keeps callers short.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The value plus a change handler to spread on the input',1,0),(@q,'Only the value',0,1),(@q,'A ref to the input',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A custom hook must return an object.','It can return an object, an array or a single value.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useInput Custom Hook','Practise: Build a useInput hook for controlled fields','Write useInput(initialValue) and use it for a login form with email and password fields plus a reset button.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useInput Custom Hook: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 77: How To Debug React Apps
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'How To Debug React Apps', 'Find and fix bugs with the React DevTools and the browser.', 'Inspect the component tree.
Read props and state in DevTools.
Use the Profiler and breakpoints.', '## What this lesson covers

Find and fix bugs with the React DevTools and the browser.

- React DevTools shows the component tree with props, state and hooks.
- The Profiler records renders so you can see what re-renders and why.
- Browser breakpoints and console logs answer questions DevTools cannot.

## Practice
Install React DevTools, inspect a component state while clicking through your app and record a profile of a slow interaction.', 'React DevTools shows the component tree with props, state and hooks.
The Profiler records renders so you can see what re-renders and why.
Browser breakpoints and console logs answer questions DevTools cannot.', 'd10qxIXgLbg', 18, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Inspect the component tree.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read props and state in DevTools.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use the Profiler and breakpoints.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=d10qxIXgLbg'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: How To Debug React Apps','https://www.youtube.com/results?search_query=How+To+Debug+React+Apps'),(@lesson,'React DevTools','https://react.dev/learn/react-developer-tools');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: How To Debug React Apps','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which DevTools tab shows what re-rendered and how long it took?','The Profiler records render timings.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Profiler',1,0),(@q,'Elements',0,1),(@q,'Network',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','StrictMode can double-invoke renders and effects in development.','It is intentional and helps reveal bugs.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: How To Debug React Apps','Practise: Find and fix bugs with the React DevTools and the browser','Install React DevTools, inspect a component state while clicking through your app and record a profile of a slow interaction.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','How To Debug React Apps: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 3: React Render =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'React Render','Understand what causes renders and reduce unnecessary work with memo, useMemo, useCallback and context patterns.',2);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'React Render');

-- Module: Rendering and State
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Rendering and State',0);
SET @module=LAST_INSERT_ID();

-- Lesson 78: Render Introduction
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Render Introduction', 'Understand what a render is and why unnecessary renders matter.', 'Define a render in React.
Explain why render counts matter.
Plan how to measure renders.', '## What this lesson covers

Understand what a render is and why unnecessary renders matter.

- A render is React calling a component function to work out what the UI should look like.
- Renders are cheap individually, but many of them in a big tree cost time.
- The goal is not zero renders; it is no unnecessary renders on expensive components.

## Practice
Add a console log to three components, click around your app and note which components render on each interaction.', 'A render is React calling a component function to work out what the UI should look like.
Renders are cheap individually, but many of them in a big tree cost time.
The goal is not zero renders; it is no unnecessary renders on expensive components.', 'YP2f-ErXG_M', 3, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Define a render in React.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why render counts matter.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Plan how to measure renders.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=YP2f-ErXG_M'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Render Introduction','https://www.youtube.com/results?search_query=Render+Introduction'),(@lesson,'React docs: Render and commit','https://react.dev/learn/render-and-commit');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Render Introduction','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is a render in React?','The browser paints after React renders.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Calling a component function to compute its output',1,0),(@q,'Painting pixels on screen',0,1),(@q,'A network request',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Every render is a problem that must be removed.','Only unnecessary renders of expensive components matter.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Render Introduction','Practise: Understand what a render is and why unnecessary renders matter','Add a console log to three components, click around your app and note which components render on each interaction.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Render Introduction: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 79: Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Rendering', 'Separate the initial render from re-renders.', 'Describe the initial render.
Describe a re-render.
Explain the commit phase.', '## What this lesson covers

Separate the initial render from re-renders.

- The initial render mounts the tree and inserts DOM nodes.
- A re-render happens when state, props or context change.
- React compares the new output with the previous one and commits only the differences.

## Practice
Log renders in a parent and child, then change parent state that the child does not use and describe what happened.', 'The initial render mounts the tree and inserts DOM nodes.
A re-render happens when state, props or context change.
React compares the new output with the previous one and commits only the differences.', 'VPtL6dU0YXc', 6, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe the initial render.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe a re-render.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the commit phase.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=VPtL6dU0YXc'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Rendering','https://www.youtube.com/results?search_query=Rendering'),(@lesson,'React docs: Render and commit','https://react.dev/learn/render-and-commit');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What triggers a re-render?','React re-renders when data it reads changes.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A state, prop or context change',1,0),(@q,'A CSS change',0,1),(@q,'A console log',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React updates the whole DOM on every render.','It commits only the differences.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Rendering','Practise: Separate the initial render from re-renders','Log renders in a parent and child, then change parent state that the child does not use and describe what happened.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 80: useState Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState Rendering', 'See how useState updates affect rendering.', 'Explain the rule for state updates.
Recognise the bailout for equal values.
Measure renders.', '## What this lesson covers

See how useState updates affect rendering.

- Calling a state setter schedules a render of that component.
- If the new value is the same as the old one (Object.is), React can bail out.
- Several setters called in one handler are batched into a single render.

## Practice
Build a counter that sets the same value again on one button and a changed value on another, and log renders to compare.', 'Calling a state setter schedules a render of that component.
If the new value is the same as the old one (Object.is), React can bail out.
Several setters called in one handler are batched into a single render.', 'OQYsHvEq7nE', 13, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the rule for state updates.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise the bailout for equal values.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Measure renders.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=OQYsHvEq7nE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState Rendering','https://www.youtube.com/results?search_query=useState+Rendering'),(@lesson,'React docs: useState bailout','https://react.dev/reference/react/useState#setstate');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What happens when you set state to the value it already holds?','Object.is equality lets React skip work.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React may bail out and skip the re-render',1,0),(@q,'It always renders twice',0,1),(@q,'It throws',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Multiple state updates in one click handler cause multiple renders.','Updates are batched into one render.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState Rendering','Practise: See how useState updates affect rendering','Build a counter that sets the same value again on one button and a changed value on another, and log renders to compare.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 81: useReducer Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useReducer Rendering', 'See how a reducer dispatch affects rendering.', 'Explain when a dispatch causes a render.
Return the same state to skip it.', '## What this lesson covers

See how a reducer dispatch affects rendering.

- dispatch always re-renders unless the reducer returns the identical state object.
- Returning state unchanged is the reducer equivalent of a state bailout.
- Mutable updates inside a reducer hide changes from React.

## Practice
Add a no-op action to a reducer that returns the same state, dispatch it from a button and confirm no render happens.', 'dispatch always re-renders unless the reducer returns the identical state object.
Returning state unchanged is the reducer equivalent of a state bailout.
Mutable updates inside a reducer hide changes from React.', 'xgDb05jNpAo', 9, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain when a dispatch causes a render.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Return the same state to skip it.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=xgDb05jNpAo'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useReducer Rendering','https://www.youtube.com/results?search_query=useReducer+Rendering'),(@lesson,'React docs: useReducer','https://react.dev/reference/react/useReducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useReducer Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How does a reducer avoid a re-render?','An identical reference lets React skip the update.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Return the same state reference',1,0),(@q,'Return null',0,1),(@q,'Dispatch twice',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A dispatch with an unknown action always re-renders.','If the reducer returns the same state, React can skip the render.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useReducer Rendering','Practise: See how a reducer dispatch affects rendering','Add a no-op action to a reducer that returns the same state, dispatch it from a button and confirm no render happens.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useReducer Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 82: State Immutability
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'State Immutability', 'Treat state as immutable so React notices changes.', 'Update objects and arrays immutably.
Explain why mutation breaks rendering.', '## What this lesson covers

Treat state as immutable so React notices changes.

- React compares references, so mutating the same object keeps the reference identical.
- The UI then shows stale data or skips a render entirely.
- Copy with spread, map and filter to create new references.

## Practice
Create a bug by pushing into a state array, observe the stale UI, then fix it with the spread operator and compare.', 'React compares references, so mutating the same object keeps the reference identical.
The UI then shows stale data or skips a render entirely.
Copy with spread, map and filter to create new references.', '-hi-QQHWlHg', 11, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Update objects and arrays immutably.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain why mutation breaks rendering.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=-hi-QQHWlHg'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: State Immutability','https://www.youtube.com/results?search_query=State+Immutability'),(@lesson,'React docs: State as a snapshot','https://react.dev/learn/state-as-a-snapshot');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: State Immutability','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why does mutating state break updates?','Change detection is reference based.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The reference stays the same, so React sees no change',1,0),(@q,'It causes a syntax error',0,1),(@q,'It reloads the page',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','The spread operator creates a new array reference.','That new reference lets React detect the change.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: State Immutability','Practise: Treat state as immutable so React notices changes','Create a bug by pushing into a state array, observe the stale UI, then fix it with the spread operator and compare.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','State Immutability: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Memoisation and Context
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Memoisation and Context',1);
SET @module=LAST_INSERT_ID();

-- Lesson 83: Parent and Child
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Parent and Child', 'Understand what happens to children when a parent re-renders.', 'Explain the default behaviour.
Recognise when children re-render.', '## What this lesson covers

Understand what happens to children when a parent re-renders.

- When a parent re-renders, its children re-render by default.
- The child function runs again even if its props did not change.
- This is normal in React; optimise only when the child is expensive.

## Practice
Build a parent with a counter and a heavy child that only renders text, log both, and count child renders after each click.', 'When a parent re-renders, its children re-render by default.
The child function runs again even if its props did not change.
This is normal in React; optimise only when the child is expensive.', 'b_DtnmQkhWM', 11, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the default behaviour.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise when children re-render.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=b_DtnmQkhWM'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Parent and Child','https://www.youtube.com/results?search_query=Parent+and+Child'),(@lesson,'React docs: Render behaviour','https://react.dev/learn/render-and-commit');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Parent and Child','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What happens to a child when its parent re-renders?','Rendering flows down the tree.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The child re-renders too by default',1,0),(@q,'The child never re-renders',0,1),(@q,'The child unmounts',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A child re-render always means the DOM changed.','React still diffs the output; often nothing changes.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Parent and Child','Practise: Understand what happens to children when a parent re-renders','Build a parent with a counter and a heavy child that only renders text, log both, and count child renders after each click.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Parent and Child: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 84: Same Element Reference
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Same Element Reference', 'Skip child renders when the element reference is unchanged.', 'Pass a stable element as children.
Explain the same element reference trick.', '## What this lesson covers

Skip child renders when the element reference is unchanged.

- If a parent passes the same element object as children, React can skip re-rendering that child.
- Creating the element inside the parent render defeats this, because a new element is made each time.
- This pattern moves the heavy component out of the parent component so the element is created once.

## Key code
```jsx
function Outer() {
  const [count, setCount] = useState(0);
  const heavy = <HeavyChild />;
  return <Parent count={count} setCount={setCount}>{heavy}</Parent>;
}
```

## Practice
Refactor a parent so a heavy child element is created in an outer component and passed down as children, and log the render counts before and after.', 'If a parent passes the same element object as children, React can skip re-rendering that child.
Creating the element inside the parent render defeats this, because a new element is made each time.
This pattern moves the heavy component out of the parent component so the element is created once.', 'K19dWjcI1Jk', 13, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass a stable element as children.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the same element reference trick.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=K19dWjcI1Jk'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Same Element Reference','https://www.youtube.com/results?search_query=Same+Element+Reference'),(@lesson,'React docs: Passing JSX as children','https://react.dev/learn/passing-props-to-a-component#passing-jsx-as-children');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Same Element Reference','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why can the same element reference skip a child render?','An identical element lets React bail out.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React sees the element object is unchanged',1,0),(@q,'Because the child has no props',0,1),(@q,'Because of memo',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Creating the child element inside the parent render keeps the reference stable.','A new element object is created on every render.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Same Element Reference','Practise: Skip child renders when the element reference is unchanged','Refactor a parent so a heavy child element is created in an outer component and passed down as children, and log the render counts before and after.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Same Element Reference: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 85: React memo
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'React memo', 'Skip renders with React.memo when props are unchanged.', 'Wrap a component in memo.
Log renders to confirm.', '## What this lesson covers

Skip renders with React.memo when props are unchanged.

- React.memo compares props shallowly and skips the render when they are equal.
- It works well for components rendered often with stable primitive props.
- A parent re-render still renders the parent itself.

## Practice
Wrap a heavy child in React.memo and confirm it stops re-rendering when only unrelated parent state changes.', 'React.memo compares props shallowly and skips the render when they are equal.
It works well for components rendered often with stable primitive props.
A parent re-render still renders the parent itself.', 'bZeBToIqaR4', 8, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Wrap a component in memo.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Log renders to confirm.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=bZeBToIqaR4'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: React memo','https://www.youtube.com/results?search_query=React+memo'),(@lesson,'React docs: memo','https://react.dev/reference/react/memo');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: React memo','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does React.memo compare?','Shallow comparison of props.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Props, one level deep',1,0),(@q,'State only',0,1),(@q,'The whole virtual DOM',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React.memo prevents the component from ever re-rendering.','It only skips renders when props are equal.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: React memo','Practise: Skip renders with React.memo when props are unchanged','Wrap a heavy child in React.memo and confirm it stops re-rendering when only unrelated parent state changes.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','React memo: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 86: Questions on Optimization
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Questions on Optimization', 'Decide when optimisation is worth the complexity.', 'Ask what is actually slow.
Measure before optimising.
Prefer simple, cheap fixes.', '## What this lesson covers

Decide when optimisation is worth the complexity.

- Most renders are fast; optimise only measured problems.
- memo, useMemo and useCallback add code and can hide bugs if dependencies are wrong.
- Splitting state so updates affect smaller subtrees often beats memo.

## Practice
Measure a slow interaction with the Profiler, then write down the slowest component and one non-memo fix for it.', 'Most renders are fast; optimise only measured problems.
memo, useMemo and useCallback add code and can hide bugs if dependencies are wrong.
Splitting state so updates affect smaller subtrees often beats memo.', '8T1TRh8xDig', 6, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Ask what is actually slow.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Measure before optimising.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Prefer simple, cheap fixes.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=8T1TRh8xDig'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Questions on Optimization','https://www.youtube.com/results?search_query=Questions+on+Optimization'),(@lesson,'React docs: Performance','https://react.dev/learn/render-and-commit#step-3-react-commits-changes-to-the-dom');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Questions on Optimization','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When should you add memo?','Measure first, optimise second.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'After measuring a genuinely expensive component',1,0),(@q,'On every component',0,1),(@q,'Only in class components',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Moving state closer to where it is used can reduce renders.','Smaller state scope keeps updates local.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Questions on Optimization','Practise: Decide when optimisation is worth the complexity','Measure a slow interaction with the Profiler, then write down the slowest component and one non-memo fix for it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Questions on Optimization: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 87: Incorrect memo with children
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Incorrect memo with children', 'See why memo fails when children are re-created.', 'Reproduce the failing case.
Explain the cause.
Fix it with a stable children element.', '## What this lesson covers

See why memo fails when children are re-created.

- A memo component that receives children fails to skip renders when the parent creates new children each time.
- The children prop is a new element object on every render.
- Create the children outside or memoise them.

## Practice
Wrap a layout component in memo that accepts children, log renders, then move the children creation one level up and confirm the fix.', 'A memo component that receives children fails to skip renders when the parent creates new children each time.
The children prop is a new element object on every render.
Create the children outside or memoise them.', 'fVnnPImZ6a8', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reproduce the failing case.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain the cause.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Fix it with a stable children element.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=fVnnPImZ6a8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Incorrect memo with children','https://www.youtube.com/results?search_query=Incorrect+memo+with+children'),(@lesson,'React docs: memo with children','https://react.dev/reference/react/memo');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Incorrect memo with children','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why does memo fail with inline children?','New props defeat shallow comparison.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The children prop is a new element on every parent render',1,0),(@q,'memo ignores children',0,1),(@q,'Children are state',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React.memo compares the children prop like any other prop.','A new element object means the props changed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Incorrect memo with children','Practise: See why memo fails when children are re-created','Wrap a layout component in memo that accepts children, log renders, then move the children creation one level up and confirm the fix.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Incorrect memo with children: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 88: Incorrect memo with Impure Component
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Incorrect memo with Impure Component', 'See why memo cannot help an impure component.', 'Recognise an impure component.
Make the data flow explicit.', '## What this lesson covers

See why memo cannot help an impure component.

- A component that reads changing external data cannot be memoised safely.
- Its output depends on something outside its props and state.
- Pass the value as a prop so memo can compare it.

## Practice
Create a component that reads a module-level variable inside render, memoise it and observe the stale UI, then pass the value as a prop.', 'A component that reads changing external data cannot be memoised safely.
Its output depends on something outside its props and state.
Pass the value as a prop so memo can compare it.', 'orrme2ydRfs', 5, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise an impure component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Make the data flow explicit.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=orrme2ydRfs'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Incorrect memo with Impure Component','https://www.youtube.com/results?search_query=Incorrect+memo+with+Impure+Component'),(@lesson,'React docs: Keeping components pure','https://react.dev/learn/keeping-components-pure');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Incorrect memo with Impure Component','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why does memo fail for an impure component?','Memo assumes output depends on props.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Its output depends on data outside props and state',1,0),(@q,'memo only works in classes',0,1),(@q,'It throws an error',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A pure component returns the same output for the same props and state.','That is what makes memo reliable.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Incorrect memo with Impure Component','Practise: See why memo cannot help an impure component','Create a component that reads a module-level variable inside render, memoise it and observe the stale UI, then pass the value as a prop.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Incorrect memo with Impure Component: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 89: Incorrect memo with props Reference
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Incorrect memo with props Reference', 'See why memo fails when object or function props are recreated.', 'Reproduce the failing case.
Stabilise props with useMemo and useCallback.', '## What this lesson covers

See why memo fails when object or function props are recreated.

- Inline object and arrow function props get a new reference on each parent render.
- Shallow comparison then reports a change and the child renders.
- Memoise those props, or pass primitives instead.

## Key code
```jsx
const style = useMemo(() => ({ padding: 8 }), []);
const onClick = useCallback(() => save(id), [id]);
<Row style={style} onClick={onClick} />;
```

## Practice
Pass an inline object to a memo child, log renders, then wrap the object in useMemo and confirm renders stop.', 'Inline object and arrow function props get a new reference on each parent render.
Shallow comparison then reports a change and the child renders.
Memoise those props, or pass primitives instead.', 'df6OFeIl2l0', 7, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reproduce the failing case.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Stabilise props with useMemo and useCallback.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=df6OFeIl2l0'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Incorrect memo with props Reference','https://www.youtube.com/results?search_query=Incorrect+memo+with+props+Reference'),(@lesson,'React docs: memo and references','https://react.dev/reference/react/memo');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Incorrect memo with props Reference','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why does an inline object prop break memo?','Shallow comparison uses references for objects.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It has a new reference on each render',1,0),(@q,'Objects are not comparable',0,1),(@q,'React copies objects',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Passing primitive props avoids the reference problem.','Primitives compare by value.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Incorrect memo with props Reference','Practise: See why memo fails when object or function props are recreated','Pass an inline object to a memo child, log renders, then wrap the object in useMemo and confirm renders stop.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Incorrect memo with props Reference: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 90: useMemo and useCallback Render
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useMemo and useCallback Render', 'Use useMemo and useCallback to keep props stable for memo.', 'Cache values with useMemo.
Cache functions with useCallback.
Keep dependencies correct.', '## What this lesson covers

Use useMemo and useCallback to keep props stable for memo.

- React.memo needs stable prop references to work.
- useMemo returns the same object until its dependencies change.
- useCallback does the same for functions.

## Practice
Take the failing memo example and fix it with useMemo for an object prop and useCallback for a handler, logging renders to prove it.', 'React.memo needs stable prop references to work.
useMemo returns the same object until its dependencies change.
useCallback does the same for functions.', 'v3J9hYAMVPc', 4, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Cache values with useMemo.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Cache functions with useCallback.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep dependencies correct.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=v3J9hYAMVPc'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useMemo and useCallback Render','https://www.youtube.com/results?search_query=useMemo+and+useCallback+Render'),(@lesson,'React docs: useCallback','https://react.dev/reference/react/useCallback');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useMemo and useCallback Render','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which pair keeps object and function props stable?','They memoise values and functions.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'useMemo and useCallback',1,0),(@q,'useState and useRef',0,1),(@q,'memo and forwardRef',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Memoising a prop is only useful if the child is memoised too.','Otherwise the child renders anyway.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useMemo and useCallback Render','Practise: Use useMemo and useCallback to keep props stable for memo','Take the failing memo example and fix it with useMemo for an object prop and useCallback for a handler, logging renders to prove it.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useMemo and useCallback Render: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 91: Context Rendering
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Context Rendering', 'Understand how context changes trigger renders.', 'Explain which components re-render.
Recognise when a value object changes each render.', '## What this lesson covers

Understand how context changes trigger renders.

- Every component that reads a context re-renders when the value changes.
- A new object value created on each provider render counts as a change.
- Consumers far from the update still re-render.

## Practice
Build a provider that passes an object literal and log consumer renders as unrelated state changes in the provider.', 'Every component that reads a context re-renders when the value changes.
A new object value created on each provider render counts as a change.
Consumers far from the update still re-render.', 'QIhKdivu0ok', 11, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain which components re-render.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Recognise when a value object changes each render.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=QIhKdivu0ok'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Context Rendering','https://www.youtube.com/results?search_query=Context+Rendering'),(@lesson,'React docs: useContext','https://react.dev/reference/react/useContext');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Context Rendering','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which components re-render when a context value changes?','Consumers depend on the value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Every consumer of that context',1,0),(@q,'Only the provider',0,1),(@q,'All components in the app',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An object literal passed as a context value is a new value on every render.','It is created fresh each time.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Context Rendering','Practise: Understand how context changes trigger renders','Build a provider that passes an object literal and log consumer renders as unrelated state changes in the provider.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Context Rendering: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 92: Context and memo
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Context and memo', 'Combine context and memo to limit re-renders.', 'Memoise the context value.
Memoise consumers where it helps.
Split contexts by concern.', '## What this lesson covers

Combine context and memo to limit re-renders.

- useMemo around the provider value stops consumers re-rendering for unrelated provider state.
- Wrap expensive consumers in memo so unchanged props skip renders.
- Separate contexts for state and actions reduce coupling.

## Practice
Wrap a provider value in useMemo, memoise a consumer and log renders while updating unrelated provider state.', 'useMemo around the provider value stops consumers re-rendering for unrelated provider state.
Wrap expensive consumers in memo so unchanged props skip renders.
Separate contexts for state and actions reduce coupling.', 'OyW9wL1jf3A', 4, 1, 1, 9, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Memoise the context value.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Memoise consumers where it helps.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Split contexts by concern.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=OyW9wL1jf3A'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Context and memo','https://www.youtube.com/results?search_query=Context+and+memo'),(@lesson,'React docs: Optimising context','https://react.dev/reference/react/useContext#optimizing-re-renders-when-passing-objects-and-functions');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Context and memo','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does memoising a context value fix?','A stable value keeps consumers stable.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Consumers re-rendering because the value object is new',1,0),(@q,'Slow CSS',0,1),(@q,'Missing keys',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Splitting state and dispatch into different contexts can reduce renders.','Each context change notifies only its consumers.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Context and memo','Practise: Combine context and memo to limit re-renders','Wrap a provider value in useMemo, memoise a consumer and log renders while updating unrelated provider state.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Context and memo: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 93: Context and Same Element Reference
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Context and Same Element Reference', 'Combine context with the same element reference trick.', 'Pass memoised children through a provider.
Keep consumers from re-rendering.', '## What this lesson covers

Combine context with the same element reference trick.

- Passing children as props means a provider re-render does not re-create the child element.
- React can skip rendering that subtree.
- Combine with memoised context values for the biggest effect.

## Practice
Build a themed provider that re-renders frequently and pass the content as children from above, comparing renders before and after.', 'Passing children as props means a provider re-render does not re-create the child element.
React can skip rendering that subtree.
Combine with memoised context values for the biggest effect.', 'C5ORrpny8Nw', 4, 1, 1, 10, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass memoised children through a provider.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Keep consumers from re-rendering.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=C5ORrpny8Nw'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Context and Same Element Reference','https://www.youtube.com/results?search_query=Context+and+Same+Element+Reference'),(@lesson,'React docs: Context performance','https://react.dev/reference/react/useContext#optimizing-re-renders-when-passing-objects-and-functions');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Context and Same Element Reference','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why can children skip a provider re-render?','A stable element reference lets React bail out.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The children element is created by the parent, not the provider',1,0),(@q,'Children never re-render',0,1),(@q,'Because of keys',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Passing children into a provider is a common performance pattern.','It keeps state updates local.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Context and Same Element Reference','Practise: Combine context with the same element reference trick','Build a themed provider that re-renders frequently and pass the content as children from above, comparing renders before and after.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Context and Same Element Reference: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 4: React TypeScript =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'React TypeScript','Type props, events, state, hooks, refs and components, including advanced patterns such as generic and polymorphic components.',3);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'React TypeScript');

-- Module: Typing Props
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Typing Props',0);
SET @module=LAST_INSERT_ID();

-- Lesson 94: React TypeScript Introduction
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'React TypeScript Introduction', 'Meet TypeScript in React and the problems it solves.', 'Explain what TypeScript adds to JavaScript.
Name three benefits in React.
Describe a typical setup.', '## What this lesson covers

Meet TypeScript in React and the problems it solves.

- TypeScript adds static types that are checked before the code runs.
- In React it catches wrong prop names, missing props and unsafe state updates.
- Editors then offer accurate autocomplete and refactoring for components.

## Practice
Write down three bugs you have hit in React that a type checker would have caught before running the app.', 'TypeScript adds static types that are checked before the code runs.
In React it catches wrong prop names, missing props and unsafe state updates.
Editors then offer accurate autocomplete and refactoring for components.', 'TiSGujM22OI', 3, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what TypeScript adds to JavaScript.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Name three benefits in React.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe a typical setup.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=TiSGujM22OI'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: React TypeScript Introduction','https://www.youtube.com/results?search_query=React+TypeScript+Introduction'),(@lesson,'TypeScript docs: Why TypeScript','https://www.typescriptlang.org/docs/handbook/typescript-from-scratch.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: React TypeScript Introduction','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','When does TypeScript report a type error?','Types are checked ahead of time.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'While you write or build the code',1,0),(@q,'Only in the browser at runtime',0,1),(@q,'Only in tests',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','TypeScript checks prop types of React components when they are declared.','Typed props catch mistakes before runtime.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: React TypeScript Introduction','Practise: Meet TypeScript in React and the problems it solves','Write down three bugs you have hit in React that a type checker would have caught before running the app.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','React TypeScript Introduction: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 95: TypeScript Getting Started
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'TypeScript Getting Started', 'Create a typed React project and read the generated config.', 'Scaffold a TypeScript React project.
Explain tsconfig strict mode.
Use .tsx files.', '## What this lesson covers

Create a typed React project and read the generated config.

- The Vite template react-ts scaffolds a typed project.
- strict turns on the strictest checks, including noImplicitAny.
- Components that contain JSX use the .tsx extension.

## Key code
```bash
npm create vite@latest my-app -- --template react-ts
cd my-app && npm install && npm run dev
```

## Practice
Create a project with npm create vite@latest my-app -- --template react-ts, run it and find where strict is enabled in tsconfig.', 'The Vite template react-ts scaffolds a typed project.
strict turns on the strictest checks, including noImplicitAny.
Components that contain JSX use the .tsx extension.', 'Kt4PQlcLHco', 5, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Scaffold a TypeScript React project.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain tsconfig strict mode.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use .tsx files.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=Kt4PQlcLHco'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: TypeScript Getting Started','https://www.youtube.com/results?search_query=TypeScript+Getting+Started'),(@lesson,'React docs: TypeScript','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: TypeScript Getting Started','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which extension do React components use in TypeScript?','JSX inside TypeScript requires tsx files.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'.tsx',1,0),(@q,'.jsx',0,1),(@q,'.ts',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','strict mode makes the type checker more permissive.','Strict mode enables stronger checks.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: TypeScript Getting Started','Practise: Create a typed React project and read the generated config','Create a project with npm create vite@latest my-app -- --template react-ts, run it and find where strict is enabled in tsconfig.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','TypeScript Getting Started: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 96: Typing Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Typing Props', 'Annotate component props with a type.', 'Declare a type for props.
Annotate the component parameter.
Read the error for a missing prop.', '## What this lesson covers

Annotate component props with a type.

- A type alias describes the shape of the props object.
- The parameter annotation makes the component typed everywhere it is used.
- Passing the wrong prop name or forgetting a required one becomes a compile error.

## Key code
```tsx
type CardProps = { title: string; price: number };

function Card({ title, price }: CardProps) {
  return <h3>{title} - {price}</h3>;
}
```

## Practice
Create a typed Greeting component with a required name prop, use it correctly, then remove the prop and read the error.', 'A type alias describes the shape of the props object.
The parameter annotation makes the component typed everywhere it is used.
Passing the wrong prop name or forgetting a required one becomes a compile error.', 'KpA6oEaCHtk', 6, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Declare a type for props.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Annotate the component parameter.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the error for a missing prop.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=KpA6oEaCHtk'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Typing Props','https://www.youtube.com/results?search_query=Typing+Props'),(@lesson,'React docs: Typing props','https://react.dev/learn/typescript#typing-props');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Typing Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you type a function component props object?','The parameter annotation types the props.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Annotate the parameter: function Card({ title }: CardProps)',1,0),(@q,'Add a comment',0,1),(@q,'Use PropTypes',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','TypeScript reports a missing required prop at compile time.','That is the main benefit of typed props.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Typing Props','Practise: Annotate component props with a type','Create a typed Greeting component with a required name prop, use it correctly, then remove the prop and read the error.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Typing Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 97: Basic Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Basic Props', 'Type basic props: strings, numbers, booleans and optionals.', 'Use primitive types for props.
Mark optional props with a question mark.', '## What this lesson covers

Type basic props: strings, numbers, booleans and optionals.

- string, number and boolean cover most props.
- A question mark makes a prop optional and its type includes undefined.
- Use a default value in destructuring for optional props.

## Key code
```tsx
type BadgeProps = {
  label: string;
  count: number;
  active: boolean;
  tone?: "blue" | "green";
};
```

## Practice
Type a Badge component with label (string), count (number), active (boolean) and an optional tone.', 'string, number and boolean cover most props.
A question mark makes a prop optional and its type includes undefined.
Use a default value in destructuring for optional props.', 'mDu54a5U3OU', 8, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use primitive types for props.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Mark optional props with a question mark.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=mDu54a5U3OU'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Basic Props','https://www.youtube.com/results?search_query=Basic+Props'),(@lesson,'React docs: Basic props','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Basic Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type allows a prop to be left out?','The question mark marks the property optional.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Optional props declared with a question mark',1,0),(@q,'any',0,1),(@q,'unknown',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An optional prop can be undefined at runtime.','Give it a default value when you need one.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Basic Props','Practise: Type basic props: strings, numbers, booleans and optionals','Type a Badge component with label (string), count (number), active (boolean) and an optional tone.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Basic Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 98: Advanced Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Advanced Props', 'Type unions, object props, arrays and literal types.', 'Use union types for limited values.
Type object and array props.', '## What this lesson covers

Type unions, object props, arrays and literal types.

- A union lists the allowed values, such as "sm" | "md" | "lg".
- Object props need their own type; arrays use Item[].
- Literal unions give autocomplete and catch typos.

## Key code
```tsx
type ButtonProps = {
  variant: "primary" | "secondary" | "danger";
  tags: string[];
  meta: { createdAt: string };
};
```

## Practice
Type a Button component whose variant accepts only "primary", "secondary" or "danger", and whose tags prop is string[].', 'A union lists the allowed values, such as "sm" | "md" | "lg".
Object props need their own type; arrays use Item[].
Literal unions give autocomplete and catch typos.', 'zLyeWSfTMa8', 10, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use union types for limited values.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type object and array props.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=zLyeWSfTMa8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Advanced Props','https://www.youtube.com/results?search_query=Advanced+Props'),(@lesson,'React docs: Advanced props','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Advanced Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type allows only the strings primary and danger?','A literal union restricts the allowed values.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'"primary" | "danger"',1,0),(@q,'string',0,1),(@q,'any',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','An array prop is typed as Item[].','The brackets describe an array of that type.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Advanced Props','Practise: Type unions, object props, arrays and literal types','Type a Button component whose variant accepts only "primary", "secondary" or "danger", and whose tags prop is string[].

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Advanced Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 99: Event Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Event Props', 'Type event handler props.', 'Type a click handler prop.
Read the event type members.
Type a change handler for inputs.', '## What this lesson covers

Type event handler props.

- Event handlers are typed with React event types such as React.MouseEvent<HTMLButtonElement>.
- The generic parameter names the element so currentTarget is typed.
- Change handlers use React.ChangeEvent<HTMLInputElement> and event.target.value.

## Key code
```tsx
type SearchBarProps = {
  onSubmit: (event: React.FormEvent<HTMLFormElement>) => void;
  onChange: (event: React.ChangeEvent<HTMLInputElement>) => void;
  onSelect: (id: number) => void;
};
```

## Practice
Type a SearchBar component that accepts onSearch, a handler receiving the query string, and onSubmit, which receives a form event.', 'Event handlers are typed with React event types such as React.MouseEvent<HTMLButtonElement>.
The generic parameter names the element so currentTarget is typed.
Change handlers use React.ChangeEvent<HTMLInputElement> and event.target.value.', 'xNSIHFi8o2M', 7, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type a click handler prop.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the event type members.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type a change handler for inputs.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=xNSIHFi8o2M'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Event Props','https://www.youtube.com/results?search_query=Event+Props'),(@lesson,'React docs: Event props','https://react.dev/learn/typescript#typing-event-handlers');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Event Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type fits a click handler on a button element?','The React event types include the element generic.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React.MouseEvent<HTMLButtonElement>',1,0),(@q,'MouseEvent',0,1),(@q,'React.FormEvent',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','event.target.value is typed string for an input change event.','The generic makes target typed for that element.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Event Props','Practise: Type event handler props','Type a SearchBar component that accepts onSearch, a handler receiving the query string, and onSubmit, which receives a form event.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Event Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 100: Style Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Style Props', 'Type the style prop and CSS custom properties.', 'Use React.CSSProperties.
Allow custom CSS variables with a cast.', '## What this lesson covers

Type the style prop and CSS custom properties.

- The style prop expects an object matching React.CSSProperties.
- Property names are camelCase versions of CSS properties.
- Custom properties such as --gap need a small type assertion.

## Key code
```tsx
type BoxProps = {
  style?: React.CSSProperties;
  gap?: number;
};

<div style={{ ...style, "--gap": `${gap ?? 8}px` } as React.CSSProperties} />;
```

## Practice
Create a Box component that accepts a style prop typed as React.CSSProperties plus an optional gap value applied as a CSS variable.', 'The style prop expects an object matching React.CSSProperties.
Property names are camelCase versions of CSS properties.
Custom properties such as --gap need a small type assertion.', 'FNfHtujZE4k', 4, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use React.CSSProperties.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Allow custom CSS variables with a cast.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=FNfHtujZE4k'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Style Props','https://www.youtube.com/results?search_query=Style+Props'),(@lesson,'React docs: Style props','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Style Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type matches the style prop?','React exports the CSSProperties type.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React.CSSProperties',1,0),(@q,'CSSStyleDeclaration',0,1),(@q,'string',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','CSS property names in the style object use camelCase.','backgroundColor, not background-color.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Style Props','Practise: Type the style prop and CSS custom properties','Create a Box component that accepts a style prop typed as React.CSSProperties plus an optional gap value applied as a CSS variable.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Style Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 101: Prop Types and Tips
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Prop Types and Tips', 'Apply prop typing tips that keep components easy to use.', 'Reuse prop types instead of repeating them.
Avoid any.
Prefer small, specific types.', '## What this lesson covers

Apply prop typing tips that keep components easy to use.

- Export shared prop types so callers can reuse them.
- any disables checking; use unknown and narrow it instead.
- A discriminated union makes impossible combinations unrepresentable.

## Practice
Extract the props type of an existing component into its own exported type and reuse it in a wrapper component.', 'Export shared prop types so callers can reuse them.
any disables checking; use unknown and narrow it instead.
A discriminated union makes impossible combinations unrepresentable.', '4Ml7Lp_QcSo', 4, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reuse prop types instead of repeating them.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Avoid any.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Prefer small, specific types.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=4Ml7Lp_QcSo'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Prop Types and Tips','https://www.youtube.com/results?search_query=Prop+Types+and+Tips'),(@lesson,'TypeScript docs: Everyday types','https://www.typescriptlang.org/docs/handbook/2/everyday-types.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Prop Types and Tips','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why avoid the any type?','any turns off the safety net.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It removes type checking for that value',1,0),(@q,'It is slow at runtime',0,1),(@q,'It breaks JSX',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Exporting a component props type helps callers build wrappers.','The type can be imported and reused.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Prop Types and Tips','Practise: Apply prop typing tips that keep components easy to use','Extract the props type of an existing component into its own exported type and reuse it in a wrapper component.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Prop Types and Tips: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Typing Hooks
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Typing Hooks',1);
SET @module=LAST_INSERT_ID();

-- Lesson 102: useState with TypeScript
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState with TypeScript', 'Type the useState hook.', 'Let TypeScript infer simple state.
Annotate when the initial value is not enough.', '## What this lesson covers

Type the useState hook.

- useState(0) infers number; the setter only accepts numbers.
- Pass a generic when the value can start empty, such as useState<User | null>(null).
- Typed setters prevent storing the wrong shape.

## Key code
```tsx
type User = { id: number; name: string };
const [user, setUser] = useState<User | null>(null);
```

## Practice
Build a typed form with useState for a user object and confirm the editor rejects an assignment missing a required field.', 'useState(0) infers number; the setter only accepts numbers.
Pass a generic when the value can start empty, such as useState<User | null>(null).
Typed setters prevent storing the wrong shape.', '2NKNjeB0WVs', 5, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Let TypeScript infer simple state.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Annotate when the initial value is not enough.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=2NKNjeB0WVs'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState with TypeScript','https://www.youtube.com/results?search_query=useState+with+TypeScript'),(@lesson,'React docs: useState with TypeScript','https://react.dev/learn/typescript#typing-usestate');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState with TypeScript','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which declaration allows a user that starts as null?','The generic states both possibilities.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'useState<User | null>(null)',1,0),(@q,'useState(null)',0,1),(@q,'useState<any>(null)',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','TypeScript infers the state type from the initial value.','You only need a generic when inference is too narrow.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState with TypeScript','Practise: Type the useState hook','Build a typed form with useState for a user object and confirm the editor rejects an assignment missing a required field.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState with TypeScript: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 103: useState Future Value
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState Future Value', 'Handle state whose value arrives later.', 'Type state that starts empty.
Narrow the value before using it.', '## What this lesson covers

Handle state whose value arrives later.

- A future value is often T | null or T | undefined.
- Narrow with a condition or optional chaining before reading fields.
- Avoid non-null assertions on data that may not exist.

## Key code
```tsx
const [product, setProduct] = useState<Product | null>(null);

if (!product) return <p>Loading...</p>;
return <h1>{product.name}</h1>;
```

## Practice
Fetch a product into state typed Product | null and render a placeholder until it arrives, without using the non-null assertion.', 'A future value is often T | null or T | undefined.
Narrow with a condition or optional chaining before reading fields.
Avoid non-null assertions on data that may not exist.', 'LNpWuRUIR5A', 6, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type state that starts empty.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Narrow the value before using it.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=LNpWuRUIR5A'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState Future Value','https://www.youtube.com/results?search_query=useState+Future+Value'),(@lesson,'React docs: Typing state','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState Future Value','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type is right for data that arrives after a request?','The value is absent until the request finishes.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Product | null',1,0),(@q,'Product',0,1),(@q,'any',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Type narrowing inside a condition lets you use the value safely.','A truthiness check narrows the union.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState Future Value','Practise: Handle state whose value arrives later','Fetch a product into state typed Product | null and render a placeholder until it arrives, without using the non-null assertion.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState Future Value: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 104: useState Type Assertion
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useState Type Assertion', 'Use type assertions carefully when state is set later.', 'Write an assertion with as.
Prefer generics over assertions.
Know the risks.', '## What this lesson covers

Use type assertions carefully when state is set later.

- A type assertion tells the compiler to trust you and is not checked at runtime.
- Assertions hide mistakes, so use them only when the type is genuinely known.
- useState<T>() with an explicit generic is usually safer than asserting.

## Practice
Rewrite a useState call that asserts a type into the generic form and explain which version you would keep.', 'A type assertion tells the compiler to trust you and is not checked at runtime.
Assertions hide mistakes, so use them only when the type is genuinely known.
useState<T>() with an explicit generic is usually safer than asserting.', 'U3UizPM4aSk', 2, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Write an assertion with as.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Prefer generics over assertions.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Know the risks.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=U3UizPM4aSk'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useState Type Assertion','https://www.youtube.com/results?search_query=useState+Type+Assertion'),(@lesson,'TypeScript docs: Type assertions','https://www.typescriptlang.org/docs/handbook/2/everyday-types.html#type-assertions');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useState Type Assertion','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a type assertion do?','Assertions are compile-time only.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Tells the compiler the type without a runtime check',1,0),(@q,'Validates data at runtime',0,1),(@q,'Converts values',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A type assertion throws an error if the value is wrong at runtime.','It has no runtime effect.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useState Type Assertion','Practise: Use type assertions carefully when state is set later','Rewrite a useState call that asserts a type into the generic form and explain which version you would keep.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useState Type Assertion: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 105: useReducer with TypeScript
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useReducer with TypeScript', 'Type a reducer state and its actions.', 'Type the state parameter.
Type the action parameter.
Type the dispatch calls.', '## What this lesson covers

Type a reducer state and its actions.

- The reducer signature is (state: State, action: Action) => State.
- A typed action union makes dispatch calls checked.
- The initial state must satisfy the state type.

## Key code
```tsx
type State = { items: string[] };
type Action = { type: "add"; item: string } | { type: "clear" };

function reducer(state: State, action: Action): State {
  switch (action.type) {
    case "add": return { items: [...state.items, action.item] };
    case "clear": return { items: [] };
    default: return state;
  }
}
```

## Practice
Convert the cart reducer to TypeScript with a state type and an action union of add, remove and clear, then break a dispatch to see the error.', 'The reducer signature is (state: State, action: Action) => State.
A typed action union makes dispatch calls checked.
The initial state must satisfy the state type.', 'lSh9RyYcnPA', 7, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type the state parameter.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type the action parameter.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type the dispatch calls.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=lSh9RyYcnPA'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useReducer with TypeScript','https://www.youtube.com/results?search_query=useReducer+with+TypeScript'),(@lesson,'React docs: useReducer with TypeScript','https://react.dev/learn/typescript#typing-usereducer');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useReducer with TypeScript','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What is the reducer return type?','A reducer returns the next state.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The state type',1,0),(@q,'void',0,1),(@q,'The action type',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A typed action union catches wrong dispatch payloads.','The compiler checks each case.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useReducer with TypeScript','Practise: Type a reducer state and its actions','Convert the cart reducer to TypeScript with a state type and an action union of add, remove and clear, then break a dispatch to see the error.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useReducer with TypeScript: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 106: useReducer Strict Action Types
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useReducer Strict Action Types', 'Make impossible actions unrepresentable with strict action types.', 'Use a discriminated union for actions.
Read the payload only after narrowing.', '## What this lesson covers

Make impossible actions unrepresentable with strict action types.

- Each action member carries its own payload shape.
- TypeScript narrows the union inside the matching switch case.
- Requesting a payload in the wrong case is a compile error.

## Practice
Add an edit action with an id and a patch object, then try reading patch inside the delete case to see the compiler stop you.', 'Each action member carries its own payload shape.
TypeScript narrows the union inside the matching switch case.
Requesting a payload in the wrong case is a compile error.', 'bcmes6hUO3U', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use a discriminated union for actions.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the payload only after narrowing.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=bcmes6hUO3U'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useReducer Strict Action Types','https://www.youtube.com/results?search_query=useReducer+Strict+Action+Types'),(@lesson,'TypeScript docs: Discriminated unions','https://www.typescriptlang.org/docs/handbook/2/narrowing.html#discriminated-unions');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useReducer Strict Action Types','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What makes a discriminant useful?','The literal type selects the member.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'A shared literal field such as type that narrows the union',1,0),(@q,'The order of the members',0,1),(@q,'The payload size',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Strict action unions remove the need for runtime checks entirely.','Server data still needs validation.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useReducer Strict Action Types','Practise: Make impossible actions unrepresentable with strict action types','Add an edit action with an id and a patch object, then try reading patch inside the delete case to see the compiler stop you.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useReducer Strict Action Types: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 107: useContext with TypeScript
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useContext with TypeScript', 'Type context values with useContext.', 'Create a typed context.
Provide a default that makes sense.
Read the value with types.', '## What this lesson covers

Type context values with useContext.

- createContext takes a type parameter and a default value.
- A common pattern is a nullable default plus a hook that throws when the provider is missing.
- Typed context gives autocomplete for the value shape.

## Key code
```tsx
type Theme = { theme: string; toggle: () => void };
const ThemeContext = createContext<Theme | null>(null);

export function useTheme() {
  const ctx = useContext(ThemeContext);
  if (!ctx) throw new Error("useTheme must be used inside ThemeProvider");
  return ctx;
}
```

## Practice
Create a ThemeContext typed to { theme: string; toggle: () => void } with a custom useTheme hook that throws outside its provider.', 'createContext takes a type parameter and a default value.
A common pattern is a nullable default plus a hook that throws when the provider is missing.
Typed context gives autocomplete for the value shape.', 'rbtTb9hLYS8', 7, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create a typed context.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Provide a default that makes sense.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read the value with types.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=rbtTb9hLYS8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useContext with TypeScript','https://www.youtube.com/results?search_query=useContext+with+TypeScript'),(@lesson,'React docs: useContext with TypeScript','https://react.dev/learn/typescript#typing-usecontext');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useContext with TypeScript','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Why use a custom hook around useContext?','A guard turns a silent null into an obvious error.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It can throw a clear error when the provider is missing',1,0),(@q,'It makes context faster',0,1),(@q,'It is required',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','createContext requires a default value.','The default is used when no provider is above.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useContext with TypeScript','Practise: Type context values with useContext','Create a ThemeContext typed to { theme: string; toggle: () => void } with a custom useTheme hook that throws outside its provider.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useContext with TypeScript: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 108: useContext Future Value
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useContext Future Value', 'Type a context whose value is not known at creation time.', 'Model a future value.
Pass the factory instead of a placeholder.', '## What this lesson covers

Type a context whose value is not known at creation time.

- Sometimes the real value only exists inside the provider.
- Pass a function that creates the value, and type the context with the expected shape.
- This avoids a fake default object that hides bugs.

## Practice
Create a SessionContext with createContext<Session | undefined>(undefined) and initialise the real value inside the provider.', 'Sometimes the real value only exists inside the provider.
Pass a function that creates the value, and type the context with the expected shape.
This avoids a fake default object that hides bugs.', '9726Yq3Scjk', 12, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Model a future value.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass the factory instead of a placeholder.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=9726Yq3Scjk'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useContext Future Value','https://www.youtube.com/results?search_query=useContext+Future+Value'),(@lesson,'React docs: Context with TypeScript','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useContext Future Value','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which approach avoids a fake default context value?','A guard forces the provider to exist.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Typed undefined default plus a guard in a custom hook',1,0),(@q,'An empty object cast',0,1),(@q,'any',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A context default value is used only when no provider is present.','Providers override it.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useContext Future Value','Practise: Type a context whose value is not known at creation time','Create a SessionContext with createContext<Session | undefined>(undefined) and initialise the real value inside the provider.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useContext Future Value: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 109: useRef with TypeScript
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'useRef with TypeScript', 'Type refs for DOM elements and mutable values.', 'Type a DOM ref.
Type a mutable value ref.', '## What this lesson covers

Type refs for DOM elements and mutable values.

- A DOM ref is useRef<HTMLInputElement | null>(null).
- A mutable value ref holds any value and does not cause renders.
- Attaching a null-typed ref to focusable elements keeps the editor happy.

## Key code
```tsx
const inputRef = useRef<HTMLInputElement | null>(null);
const timerRef = useRef<number | null>(null);
inputRef.current?.focus();
```

## Practice
Type an input ref and a timer id ref in one component, then call focus through optional chaining.', 'A DOM ref is useRef<HTMLInputElement | null>(null).
A mutable value ref holds any value and does not cause renders.
Attaching a null-typed ref to focusable elements keeps the editor happy.', 'hA4i1RTbZ2A', 7, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type a DOM ref.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type a mutable value ref.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=hA4i1RTbZ2A'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: useRef with TypeScript','https://www.youtube.com/results?search_query=useRef+with+TypeScript'),(@lesson,'React docs: useRef with TypeScript','https://react.dev/learn/typescript#typing-useref');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: useRef with TypeScript','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type fits a ref attached to an input element?','The element type gives you access to its DOM members.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'useRef<HTMLInputElement | null>(null)',1,0),(@q,'useRef<string>(null)',0,1),(@q,'useRef<any>()',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','ref.current can be null before the element mounts.','Use optional chaining or a null check.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: useRef with TypeScript','Practise: Type refs for DOM elements and mutable values','Type an input ref and a timer id ref in one component, then call focus through optional chaining.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','useRef with TypeScript: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Module: Typing Components
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Typing Components',2);
SET @module=LAST_INSERT_ID();

-- Lesson 110: Class Component with TypeScript
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Class Component with TypeScript', 'Type class components with props and state generics.', 'Declare the generics on React.Component.
Type state and methods.', '## What this lesson covers

Type class components with props and state generics.

- React.Component<Props, State> types both this.props and this.state.
- State can be omitted with a second empty type when unused.
- Typed methods keep event handling safe.

## Key code
```tsx
type Props = { start?: number };
type State = { count: number };

class Counter extends React.Component<Props, State> {
  state: State = { count: this.props.start ?? 0 };
  render() { return <button>{this.state.count}</button>; }
}
```

## Practice
Write a typed Counter class with a state type and an onClick handler typed for a button element.', 'React.Component<Props, State> types both this.props and this.state.
State can be omitted with a second empty type when unused.
Typed methods keep event handling safe.', 'JOhIMtMxjpU', 4, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Declare the generics on React.Component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type state and methods.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=JOhIMtMxjpU'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Class Component with TypeScript','https://www.youtube.com/results?search_query=Class+Component+with+TypeScript'),(@lesson,'React docs: Class components with TypeScript','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Class Component with TypeScript','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which generic order does React.Component use?','Props come first in the type parameters.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Props first, then state',1,0),(@q,'State first, then props',0,1),(@q,'Only props',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Class components can be fully typed.','Generics type props and state.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Class Component with TypeScript','Practise: Type class components with props and state generics','Write a typed Counter class with a state type and an onClick handler typed for a button element.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Class Component with TypeScript: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 111: Component Prop
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Component Prop', 'Type props that receive components or elements.', 'Use React.ComponentType for component props.
Use React.ReactNode for renderable content.', '## What this lesson covers

Type props that receive components or elements.

- ComponentType accepts a function or class component.
- ReactNode covers anything renderable: elements, strings, numbers, null and arrays.
- Never use JSX.Element for children; ReactNode is broader and correct.

## Key code
```tsx
type CardProps = {
  title: string;
  icon: React.ComponentType<{ size?: number }>;
  children: React.ReactNode;
};
```

## Practice
Build a typed Card component that accepts a title, an icon component and children.', 'ComponentType accepts a function or class component.
ReactNode covers anything renderable: elements, strings, numbers, null and arrays.
Never use JSX.Element for children; ReactNode is broader and correct.', 'qvdnTfyv7y8', 5, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use React.ComponentType for component props.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use React.ReactNode for renderable content.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=qvdnTfyv7y8'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Component Prop','https://www.youtube.com/results?search_query=Component+Prop'),(@lesson,'React docs: Component props','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Component Prop','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type describes renderable children?','ReactNode covers every renderable value.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React.ReactNode',1,0),(@q,'string',0,1),(@q,'JSX.Element only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','React.ComponentType can hold a class or function component.','It covers both component kinds.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Component Prop','Practise: Type props that receive components or elements','Build a typed Card component that accepts a title, an icon component and children.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Component Prop: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 112: Generic Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Generic Props', 'Write generic components that keep their prop types.', 'Declare a generic type parameter.
Pass the item type through props.', '## What this lesson covers

Write generic components that keep their prop types.

- A generic component infers its type from usage.
- Generic lists keep item types in callbacks such as renderItem and onSelect.
- Constrain the generic when the component needs certain fields.

## Key code
```tsx
type ListProps<T> = {
  items: T[];
  renderItem: (item: T) => React.ReactNode;
};

function List<T>({ items, renderItem }: ListProps<T>) {
  return <ul>{items.map((item, i) => <li key={i}>{renderItem(item)}</li>)}</ul>;
}
```

## Practice
Build a generic List<T> component with items, renderItem and an optional onSelect, then use it with two different record types.', 'A generic component infers its type from usage.
Generic lists keep item types in callbacks such as renderItem and onSelect.
Constrain the generic when the component needs certain fields.', 'xFNk2nfDh4M', 9, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Declare a generic type parameter.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Pass the item type through props.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=xFNk2nfDh4M'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Generic Props','https://www.youtube.com/results?search_query=Generic+Props'),(@lesson,'TypeScript docs: Generic functions','https://www.typescriptlang.org/docs/handbook/2/generics.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Generic Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a generic component infer from usage?','Type inference works from the call site.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'The type parameter from the props you pass',1,0),(@q,'The CSS class names',0,1),(@q,'The state values',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','A generic component can constrain its type parameter.','Constraints such as T extends { id: number } are allowed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Generic Props','Practise: Write generic components that keep their prop types','Build a generic List<T> component with items, renderItem and an optional onSelect, then use it with two different record types.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Generic Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 113: Restricting Props
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Restricting Props', 'Restrict props so only one variant can be passed.', 'Build a union of prop shapes.
Forbid the other props with never.', '## What this lesson covers

Restrict props so only one variant can be passed.

- A discriminated union of prop types lets a component accept exactly one configuration.
- Setting the other options to never makes wrong combinations compile errors.
- This pattern suits components that are either a link or a button.

## Key code
```tsx
type ButtonProps =
  | { href: string; onClick?: never }
  | { href?: never; onClick: () => void };
```

## Practice
Type a Button component that is either { href: string } or { onClick: () => void }, never both and never neither.', 'A discriminated union of prop types lets a component accept exactly one configuration.
Setting the other options to never makes wrong combinations compile errors.
This pattern suits components that are either a link or a button.', 'yqn9Fkv7f2M', 6, 1, 1, 3, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build a union of prop shapes.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Forbid the other props with never.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=yqn9Fkv7f2M'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Restricting Props','https://www.youtube.com/results?search_query=Restricting+Props'),(@lesson,'TypeScript docs: Unions and never','https://www.typescriptlang.org/docs/handbook/2/narrowing.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Restricting Props','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','How do you forbid a prop inside one variant?','never makes the property impossible to set.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Declare it as never in that variant',1,0),(@q,'Make it optional',0,1),(@q,'Use any',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Restricting props improves error messages for callers.','The union explains exactly what is allowed.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Restricting Props','Practise: Restrict props so only one variant can be passed','Type a Button component that is either { href: string } or { onClick: () => void }, never both and never neither.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Restricting Props: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 114: Template Literals and Exclude
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Template Literals and Exclude', 'Use template literal types and Exclude to generate prop options.', 'Create template literal types.
Remove values with Exclude.', '## What this lesson covers

Use template literal types and Exclude to generate prop options.

- Template literal types build strings from other types, such as `${Size}-${Tone}`.
- Exclude removes union members you do not want.
- Generated options stay in sync when the source types change.

## Key code
```tsx
type Size = "sm" | "md" | "lg";
type Tone = "solid" | "ghost";
type Variant = `${Size}-${Tone}`;
```

## Practice
Derive a class name type from size and tone unions with a template literal, then exclude one invalid combination.', 'Template literal types build strings from other types, such as `${Size}-${Tone}`.
Exclude removes union members you do not want.
Generated options stay in sync when the source types change.', 'jrnIh0RPeCw', 6, 1, 1, 4, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Create template literal types.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Remove values with Exclude.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=jrnIh0RPeCw'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Template Literals and Exclude','https://www.youtube.com/results?search_query=Template+Literals+and+Exclude'),(@lesson,'TypeScript docs: Template literal types','https://www.typescriptlang.org/docs/handbook/2/template-literal-types.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Template Literals and Exclude','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does Exclude<string | number, number> give?','Exclude removes the listed members.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'string',1,0),(@q,'number',0,1),(@q,'never',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Template literal types can build string unions automatically.','They compose existing string types.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Template Literals and Exclude','Practise: Use template literal types and Exclude to generate prop options','Derive a class name type from size and tone unions with a template literal, then exclude one invalid combination.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Template Literals and Exclude: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 115: Wrapping HTML Elements
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Wrapping HTML Elements', 'Wrap native HTML elements while keeping their props typed.', 'Extend the native props type.
Spread the rest props.', '## What this lesson covers

Wrap native HTML elements while keeping their props typed.

- React.ComponentPropsWithoutRef<"button"> gives the native button props.
- Destructure your extra props and spread the rest onto the element.
- This keeps onClick, type, disabled and aria attributes typed.

## Key code
```tsx
type ButtonProps = React.ComponentPropsWithoutRef<"button"> & {
  variant?: "primary" | "secondary";
};

function Button({ variant = "primary", className, ...rest }: ButtonProps) {
  return <button className={`btn-${variant} ${className ?? ""}`} {...rest} />;
}
```

## Practice
Build a Button component that adds a variant prop while forwarding every native button prop, including disabled and type.', 'React.ComponentPropsWithoutRef<"button"> gives the native button props.
Destructure your extra props and spread the rest onto the element.
This keeps onClick, type, disabled and aria attributes typed.', '4GchlC06ca0', 8, 1, 1, 5, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Extend the native props type.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Spread the rest props.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=4GchlC06ca0'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Wrapping HTML Elements','https://www.youtube.com/results?search_query=Wrapping+HTML+Elements'),(@lesson,'TypeScript docs: Utility types','https://www.typescriptlang.org/docs/handbook/utility-types.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Wrapping HTML Elements','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which type gives the props of a native button?','The utility extracts the element props type.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React.ComponentPropsWithoutRef<"button">',1,0),(@q,'React.ButtonHTMLAttributes only',0,1),(@q,'HTMLButtonElement',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Spreading rest props keeps native attributes working.','Callers can still pass onClick and aria labels.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Wrapping HTML Elements','Practise: Wrap native HTML elements while keeping their props typed','Build a Button component that adds a variant prop while forwarding every native button prop, including disabled and type.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Wrapping HTML Elements: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 116: Extracting a Components Prop Types
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Extracting a Components Prop Types', 'Extract a components prop types instead of redefining them.', 'Use React.ComponentProps of a component.
Reuse the extracted type in wrappers.', '## What this lesson covers

Extract a components prop types instead of redefining them.

- React.ComponentProps<typeof Card> gives the props of your own component.
- React.ComponentProps<"input"> works for native elements.
- ReturnType extracts the type a function returns, useful for utility functions.

## Practice
Extract the props of an existing Card component with ComponentProps and reuse them in a HighlightedCard wrapper.', 'React.ComponentProps<typeof Card> gives the props of your own component.
React.ComponentProps<"input"> works for native elements.
ReturnType extracts the type a function returns, useful for utility functions.', 'AHadSDk7i6s', 3, 1, 1, 6, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Use React.ComponentProps of a component.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Reuse the extracted type in wrappers.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=AHadSDk7i6s'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Extracting a Components Prop Types','https://www.youtube.com/results?search_query=Extracting+a+Components+Prop+Types'),(@lesson,'TypeScript docs: typeof type operator','https://www.typescriptlang.org/docs/handbook/2/typeof-types.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Extracting a Components Prop Types','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which expression gives the props type of your Card component?','ComponentProps reads the props from the component type.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'React.ComponentProps<typeof Card>',1,0),(@q,'typeof Card',0,1),(@q,'React.FC<Card>',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Reusing extracted prop types keeps wrappers in sync with the original.','One change updates every consumer.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Extracting a Components Prop Types','Practise: Extract a components prop types instead of redefining them','Extract the props of an existing Card component with ComponentProps and reuse them in a HighlightedCard wrapper.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Extracting a Components Prop Types: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 117: Polymorphic Components
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Polymorphic Components', 'Build a polymorphic component with an as prop.', 'Accept an as prop naming the element.
Type the props from that element.', '## What this lesson covers

Build a polymorphic component with an as prop.

- A polymorphic component renders a different element depending on as.
- Generic as props keep the correct attributes typed for each element.
- This pattern powers design systems where Text can be a span, p or h2.

## Key code
```tsx
type TextProps<E extends React.ElementType> = {
  as?: E;
  children: React.ReactNode;
} & Omit<React.ComponentPropsWithoutRef<E>, "as" | "children">;

function Text<E extends React.ElementType = "span">({ as, children, ...rest }: TextProps<E>) {
  const Tag = as ?? "span";
  return <Tag {...rest}>{children}</Tag>;
}
```

## Practice
Build a Text component with an as prop limited to span, p and h2 that keeps the matching props typed.', 'A polymorphic component renders a different element depending on as.
Generic as props keep the correct attributes typed for each element.
This pattern powers design systems where Text can be a span, p or h2.', 'uZ8GZm5KEXY', 10, 1, 1, 7, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Accept an as prop naming the element.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Type the props from that element.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=uZ8GZm5KEXY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Polymorphic Components','https://www.youtube.com/results?search_query=Polymorphic+Components'),(@lesson,'TypeScript docs: Generics with components','https://www.typescriptlang.org/docs/handbook/2/generics.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Polymorphic Components','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does an as prop let a component do?','The element changes, the API stays.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Render as a different element while keeping its props typed',1,0),(@q,'Change its CSS file',0,1),(@q,'Skip rendering',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Polymorphic components are common in design systems.','They keep markup semantic without duplicating components.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Polymorphic Components','Practise: Build a polymorphic component with an as prop','Build a Text component with an as prop limited to span, p and h2 that keeps the matching props typed.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Polymorphic Components: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 118: TypeScript Wrapping up
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'TypeScript Wrapping up', 'Wrap up the TypeScript section and plan what to practise next.', 'Summarise the typing techniques covered.
Choose a project to apply them.', '## What this lesson covers

Wrap up the TypeScript section and plan what to practise next.

- You can now type props, events, state, reducers, context, refs and native element wrappers.
- The next step is applying these patterns in a real project with strict mode on.
- Keep types close to the component and export the reusable ones.

## Practice
Type an existing JavaScript component with strict mode enabled and write down the errors the compiler found.', 'You can now type props, events, state, reducers, context, refs and native element wrappers.
The next step is applying these patterns in a real project with strict mode on.
Keep types close to the component and export the reusable ones.', 'YmATkdc-5NY', 2, 1, 1, 8, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Summarise the typing techniques covered.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Choose a project to apply them.',1);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=YmATkdc-5NY'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: TypeScript Wrapping up','https://www.youtube.com/results?search_query=TypeScript+Wrapping+up'),(@lesson,'React docs: TypeScript','https://react.dev/learn/typescript');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: TypeScript Wrapping up','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Which habit keeps TypeScript React code healthy?','Strict typing catches mistakes early.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Keep strict mode on and type props explicitly',1,0),(@q,'Use any to silence errors',0,1),(@q,'Disable the type checker',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Types are removed from the JavaScript shipped to the browser.','TypeScript is compiled away.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: TypeScript Wrapping up','Practise: Wrap up the TypeScript section and plan what to practise next','Type an existing JavaScript component with strict mode enabled and write down the errors the compiler found.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','TypeScript Wrapping up: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);
SET @prev_stage=@stage;

-- ===== STAGE 5: Interviews and Final Projects =====
INSERT INTO stages(path_id,title,description,position) VALUES(@path,'Interviews and Final Projects','Prepare for interviews, meet react-admin, then build two complete projects.',4);
SET @stage=LAST_INSERT_ID();
INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(@stage,@prev_stage);
SET @prev_lesson=NULL;
INSERT INTO skill_nodes(path_id,stage_id,label) VALUES(@path,@stage,'Interviews and Final Projects');

-- Module: Interviews and Beyond
INSERT INTO modules(stage_id,title,position) VALUES(@stage,'Interviews and Beyond',0);
SET @module=LAST_INSERT_ID();

-- Lesson 119: React Interview Questions
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'React Interview Questions', 'Prepare for React interview questions with a structured plan.', 'List the core topics interviewers ask about.
Practise explaining trade-offs.
Build answers from real work.', '## What this lesson covers

Prepare for React interview questions with a structured plan.

- Common topics are the virtual DOM, keys, reconciliation, hooks rules, memoisation, context and state management.
- Interviewers value reasoning about trade-offs more than memorised definitions.
- Prepare two or three real stories about bugs you fixed and performance work you did.

## Practice
Write short answers to ten likely questions, including why keys matter, when to use memo and how you would structure a data layer.', 'Common topics are the virtual DOM, keys, reconciliation, hooks rules, memoisation, context and state management.
Interviewers value reasoning about trade-offs more than memorised definitions.
Prepare two or three real stories about bugs you fixed and performance work you did.', 'tfPq0iCJioQ', 8, 1, 1, 0, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List the core topics interviewers ask about.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Practise explaining trade-offs.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Build answers from real work.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=tfPq0iCJioQ'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: React Interview Questions','https://www.youtube.com/results?search_query=React+Interview+Questions'),(@lesson,'React docs: Learn React','https://react.dev/learn');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: React Interview Questions','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What do most React interviews test?','Reasoning matters more than definitions.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Understanding of core concepts and trade-offs',1,0),(@q,'Memorising the React source',0,1),(@q,'CSS speed',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Explaining when NOT to use a technique is a strong interview answer.','Trade-off awareness shows experience.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: React Interview Questions','Practise: Prepare for React interview questions with a structured plan','Write short answers to ten likely questions, including why keys matter, when to use memo and how you would structure a data layer.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','React Interview Questions: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 120: Learn react-admin in 30 minutes
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Learn react-admin in 30 minutes', 'Build an admin panel quickly with react-admin.', 'Explain what react-admin provides.
Describe resources and data providers.
Sketch a typical admin screen.', '## What this lesson covers

Build an admin panel quickly with react-admin.

- react-admin gives ready-made list, edit, create and show screens for CRUD data.
- A data provider connects it to your API; resources map your entities to screens.
- It is a strong choice for internal dashboards built on an existing API.

## Key code
```tsx
import { Admin, Resource, ListGuesser } from "react-admin";
import jsonServerProvider from "ra-data-json-server";

<Admin dataProvider={jsonServerProvider("https://api.example.com")}>
  <Resource name="courses" list={ListGuesser} />
</Admin>;
```

## Practice
Sketch the resources you would need for a course admin panel and note what each list, edit and create screen would show.', 'react-admin gives ready-made list, edit, create and show screens for CRUD data.
A data provider connects it to your API; resources map your entities to screens.
It is a strong choice for internal dashboards built on an existing API.', 'vYnk_SxVJKE', 26, 1, 1, 1, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Explain what react-admin provides.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Describe resources and data providers.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Sketch a typical admin screen.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch on YouTube','https://www.youtube.com/watch?v=vYnk_SxVJKE'),(@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Learn react-admin in 30 minutes','https://www.youtube.com/results?search_query=Learn+react-admin+in+30+minutes'),(@lesson,'react-admin docs: Tutorial','https://marmelab.com/react-admin/Tutorial.html');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Quiz: Learn react-admin in 30 minutes','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','What does a data provider do in react-admin?','The provider adapts your API to react-admin.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'Connects the admin screens to your API',1,0),(@q,'Styles the tables',0,1),(@q,'Handles routing only',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','react-admin includes list, edit, create and show screens.','Those screens are generated from resources.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',1,0),(@q,'False',0,1);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Assignment: Learn react-admin in 30 minutes','Practise: Build an admin panel quickly with react-admin','Sketch the resources you would need for a course admin panel and note what each list, edit and create screen would show.

Submit a live URL, a repository link, a screenshot or PDF, or paste your code in the text box.','Learn react-admin in 30 minutes: apply what the lesson showed.',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Task completed as described',50),(@assign,'Clean, readable, working code',30),(@assign,'Short explanation of what you did',20);

-- Lesson 121: Final Project Briefing
INSERT INTO lessons(module_id,title,description,objectives,content,takeaways,youtube_id,duration_minutes,require_checklist,required,position,status) VALUES(@module,'Final Project Briefing', 'Plan the final projects and check that you are ready to build them.', 'Read both project briefs.
Sketch the component tree and the state each part needs.
List the hooks and patterns you will use.', '## What this lesson covers

Plan the final projects and check that you are ready to build them.

- A complete React app combines components, props, state, effects, context and custom hooks.
- Plan where state lives before writing components; lifting state too late causes rewrites.
- Measure renders with the Profiler instead of guessing what is slow.

## Practice
Sketch the component tree for both projects, mark where state lives in each branch and list the custom hooks you will write. Submit the sketch with your notes.', 'A complete React app combines components, props, state, effects, context and custom hooks.
Plan where state lives before writing components; lifting state too late causes rewrites.
Measure renders with the Profiler instead of guessing what is slow.', NULL, 12, 1, 1, 2, 'published');
SET @lesson=LAST_INSERT_ID();
INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(@lesson,@prev_lesson);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Read both project briefs.',0);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'Sketch the component tree and the state each part needs.',1);
INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(@lesson,'List the hooks and patterns you will use.',2);
INSERT INTO lesson_resources(lesson_id,title,url) VALUES (@lesson,'Watch the full playlist','https://www.youtube.com/@Codevolution/playlists'),(@lesson,'Search YouTube: Final Project Briefing','https://www.youtube.com/results?search_query=Final+Project+Briefing');
SET @prev_lesson=@lesson;
INSERT INTO quizzes(stage_id,lesson_id,title,instructions,passing_score,status,required) VALUES(@stage,@lesson,'Final review quiz','Check what you learned. You need 70% to pass and you can retry as many times as you like.',70,'published',1);
SET @quiz=LAST_INSERT_ID();
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'single','Where should shared state live?','Lift state to the nearest shared ancestor, then consider context.',1,0);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'In the closest common parent, or in context when many distant components need it',1,0),(@q,'In every component',0,1),(@q,'In CSS',0,2);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'boolean','Every piece of state should go into a global context.','Local state stays local; context is for widely shared values.',1,1);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'True',0,0),(@q,'False',1,1);
INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(@quiz,'multiple','Which are signs that a component is worth memoising?','Memoise measured, expensive components with stable props.',2,2);
SET @q=LAST_INSERT_ID();
INSERT INTO answer_options(question_id,label,is_correct,position) VALUES (@q,'It renders often with the same props',1,0),(@q,'It is expensive to render',1,1),(@q,'It has no props at all',0,2),(@q,'It is measured as slow in the Profiler',1,3);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 1: Habit tracker with hooks and context','Build and publish a complete React application using hooks, context and custom hooks.','Build a habit tracker with React (JavaScript or TypeScript).
Requirements: a component tree with presentational and container components, state for the habit list held with useState or useReducer, a controlled form to add a habit with validation and form error messages, a toggle to mark a habit done for the day, a delete action with confirmation, a custom hook that stores data in localStorage so habits survive a refresh, a ThemeContext with a toggle supplied through context, a memoised list row that only re-renders when its own habit changes, useMemo for a weekly progress calculation, and a loading skeleton while the saved data is read.
Keep reducers pure, keep state immutable and show renders in the console only in development.

Submit a live URL (Netlify, Vercel or GitHub Pages) or a repository link, plus a short note on one render problem you found and fixed.','Build a complete app with hooks, context, custom hooks and memo',100,60,1,1,1,1,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'All habit features work: add, validate, complete, delete, persist',30),(@assign,'State structure and immutable updates are correct',20),(@assign,'Custom hook, context and memo used appropriately',20),(@assign,'Code quality: component split, naming, no unnecessary re-renders',20),(@assign,'Live link and reflection note',10);
INSERT INTO assignments(stage_id,lesson_id,title,description,instructions,objectives,max_score,passing_score,allow_text,allow_url,allow_file,required,status) VALUES(@stage,@lesson,'Final Project 2: Typed dashboard (optional challenge)','Rebuild a feature in TypeScript with strict mode, or build an admin panel with react-admin.','Choose one option.
Option A: take your habit tracker and convert it to TypeScript with strict mode on. Type props, events, state, the reducer actions, context and refs. Add a generic List component and a Button that forwards native props.
Option B: build a react-admin panel over a public API with at least two resources, a list, an edit form and a create form.
Option C: build a small dashboard that fetches data with useEffect and useReducer, with loading, error and empty states for every request.

Submit a live URL or repository link and a short note explaining your design decisions.','Apply advanced patterns: typed components, admin scaffolding or async state',100,60,1,1,1,0,'published');
SET @assign=LAST_INSERT_ID();
INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES (@assign,'Chosen option is complete and working',30),(@assign,'Types and state are correct and consistent',25),(@assign,'Loading, error and empty states handled',20),(@assign,'Code quality and structure',15),(@assign,'Live link and note',10);
SET @prev_stage=@stage;

COMMIT;
SELECT 'React.js for Beginners installed' AS result,(SELECT COUNT(*) FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=@path) AS lessons,(SELECT COUNT(*) FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE s.path_id=@path) AS quizzes,(SELECT COUNT(*) FROM assignments a JOIN stages s ON s.id=a.stage_id WHERE s.path_id=@path) AS assignments;
