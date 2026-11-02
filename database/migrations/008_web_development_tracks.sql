-- 008: Skill areas, web-development tracks (roadmaps), track gating and community group chat.
-- Safe to run more than once: every statement is idempotent (IF NOT EXISTS / INSERT IGNORE).
-- Run it in phpMyAdmin with your database selected, or with: php bin/migrate.php

CREATE TABLE IF NOT EXISTS skill_area_info (category_id BIGINT UNSIGNED PRIMARY KEY, availability ENUM('available','coming_soon') NOT NULL DEFAULT 'coming_soon', tagline VARCHAR(190) NOT NULL DEFAULT '', summary VARCHAR(500) NOT NULL DEFAULT '', article MEDIUMTEXT NOT NULL, position SMALLINT UNSIGNED NOT NULL DEFAULT 0, FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS tracks (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, category_id BIGINT UNSIGNED NOT NULL, slug VARCHAR(120) NOT NULL UNIQUE, title VARCHAR(120) NOT NULL, summary VARCHAR(500) NOT NULL, article MEDIUMTEXT NOT NULL, position SMALLINT UNSIGNED NOT NULL DEFAULT 0, FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS track_items (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, track_id BIGINT UNSIGNED NOT NULL, step SMALLINT UNSIGNED NOT NULL, position SMALLINT UNSIGNED NOT NULL DEFAULT 0, label VARCHAR(120) NOT NULL, note VARCHAR(255) NOT NULL DEFAULT '', path_slug VARCHAR(190) NULL, requires_label VARCHAR(120) NULL, UNIQUE KEY uq_track_item(track_id,step,label), FOREIGN KEY(track_id) REFERENCES tracks(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS user_tracks (user_id BIGINT UNSIGNED NOT NULL, track_id BIGINT UNSIGNED NOT NULL, chosen_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(user_id,track_id), FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE, FOREIGN KEY(track_id) REFERENCES tracks(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS chat_messages (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, category_id BIGINT UNSIGNED NOT NULL, user_id BIGINT UNSIGNED NULL, kind ENUM('message','level','achievement','course','joined') NOT NULL DEFAULT 'message', body VARCHAR(1000) NOT NULL, hidden TINYINT(1) NOT NULL DEFAULT 0, created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, INDEX idx_chat_room(category_id,id), FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE, FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;

INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Web Development','web-development','Build useful things for the web.','code','orange',1);
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Mobile App Development','mobile-app-development','Build apps for phones and tablets.','phone','blue',0);
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Artificial Intelligence & Machine Learning','artificial-intelligence-machine-learning','Understand how machines learn from data.','chart','purple',0);
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('AI Automation','ai-automation','Automate repetitive work with AI tools.','bolt','green',0);
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('AI Chatbot Development','ai-chatbot-development','Build chatbots that help real people.','message','pink',0);
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Data Science','data-science','Turn data into decisions.','chart','green',0);
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Blockchain & Web3','blockchain-web3','Understand decentralised technology.','globe','orange',0);
INSERT IGNORE INTO categories(name,slug,description,icon,color,active) VALUES('Cloud Computing','cloud-computing','Run software on the cloud.','globe','blue',0);
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'available','Build websites and web apps from scratch.','Choose frontend, backend or full-stack and follow a clear roadmap of courses.','## Build for the web
Web development is the craft of building websites and web applications. Everything you use online, from a school portal to a banking app, is made by combining a visual side people interact with and a hidden side that stores data and applies rules.

## Choose your direction
There are three common directions. Frontend developers build what people see and use in the browser. Backend developers build the servers, databases and APIs behind it. Full-stack developers do both.

## One step at a time
Each direction is a roadmap of courses taken in order. You unlock the next course by completing the one before it, so you always build on solid ground. Open a direction below to see every course and what comes next.

## Ready to start?
Create a free account, pick a direction and start with HTML. Courses that are still being prepared are marked Coming soon.',1 FROM categories WHERE slug='web-development';
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'coming_soon','Build apps people carry everywhere.','Design, build and ship apps for Android and iOS.','## Apps in everyone''s pocket
Mobile apps put your work in the hands of people all day long. In this path you will learn how apps are structured, how screens and navigation work, how to store data, call APIs and publish to the app stores.

## What to expect
You will start with the fundamentals of mobile interfaces, then move into a cross-platform toolkit so one codebase can serve Android and iOS. Practical projects will help you build a portfolio of real apps.

## Status
This path is being prepared. Create a free account now and you will be able to see it the moment it opens.',2 FROM categories WHERE slug='mobile-app-development';
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'coming_soon','Learn how machines learn.','From data and models to real machine-learning projects.','## How machines learn
Artificial intelligence and machine learning power search, recommendations, translation and more. This path will explain the ideas clearly, starting with data, statistics and Python, before moving into training and evaluating models.

## What to expect
Expect guided lessons, practical notebooks and projects that show how a model goes from raw data to a useful prediction, along with an honest look at limits and bias.

## Status
This path is being prepared. Create a free account to be ready when it launches.',3 FROM categories WHERE slug='artificial-intelligence-machine-learning';
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'coming_soon','Let smart tools do the repetitive work.','Connect apps and AI services to automate real tasks.','## Work smarter
Automation connects the tools you already use so repetitive work runs by itself. In this path you will learn to design workflows, connect services through APIs and add AI steps that classify, summarise and decide.

## What to expect
You will build practical automations for email, spreadsheets, forms and customer messages, and learn how to test and monitor them so they stay reliable.

## Status
This path is being prepared. Create a free account to see it when it opens.',4 FROM categories WHERE slug='ai-automation';
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'coming_soon','Build assistants that talk back.','Design, build and deploy chatbots for websites and messaging apps.','## Conversations as an interface
Chatbots answer questions, guide customers and handle simple tasks at any hour. This path will cover conversation design, language-model APIs, prompts, memory and connecting a bot to a website or messaging app.

## What to expect
You will build chatbots step by step, learn how to keep answers grounded and safe, and publish a working assistant you can show others.

## Status
This path is being prepared. Create a free account to be notified in your learning space.',5 FROM categories WHERE slug='ai-chatbot-development';
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'coming_soon','Find the story in the numbers.','Collect, clean, analyse and present data with Python and SQL.','## Decisions backed by data
Data science combines programming, statistics and storytelling. This path will take you from spreadsheets and SQL to Python, data cleaning, visualisation and simple predictive models.

## What to expect
Each stage uses real datasets and ends with a project you can add to your portfolio, so you learn to ask good questions and explain your findings clearly.

## Status
This path is being prepared. Create a free account to see it when it launches.',6 FROM categories WHERE slug='data-science';
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'coming_soon','Learn how decentralised apps work.','Blockchain basics, wallets, smart contracts and decentralised apps.','## Beyond the hype
Blockchains record data in a way that many parties can verify without a central owner. This path will explain how they work, how wallets and transactions behave and how smart contracts power decentralised applications.

## What to expect
You will learn the concepts first, then build and test a simple smart contract and connect it to a web interface, with a clear focus on security and risk.

## Status
This path is being prepared. Create a free account to see it when it opens.',7 FROM categories WHERE slug='blockchain-web3';
INSERT IGNORE INTO skill_area_info(category_id,availability,tagline,summary,article,position) SELECT id,'coming_soon','Learn how modern software is hosted.','Servers, storage, networking and deployment on major cloud platforms.','## Computing as a service
Cloud platforms let you rent servers, storage and databases by the hour instead of buying hardware. This path will teach core concepts such as virtual machines, storage, networking, identity, scaling and cost control.

## What to expect
You will deploy real applications, learn how to keep them secure and observable, and understand what happens when something goes wrong.

## Status
This path is being prepared. Create a free account to see it when it launches.',8 FROM categories WHERE slug='cloud-computing';
INSERT IGNORE INTO tracks(category_id,slug,title,summary,article,position) SELECT id,'frontend-development','Frontend Development','Build everything users see and interact with.','## What frontend developers do
Frontend development covers everything a visitor sees and touches in the browser: layout, colours, text, buttons, forms, animation and how the page responds on a phone or laptop.

## What you will learn
You start with HTML for structure, then CSS for style, a CSS toolkit such as Bootstrap or Tailwind for speed, JavaScript for behaviour, React for building larger interfaces and Next.js for complete, fast web applications.

## Who it suits
It suits people who enjoy design, visual detail and seeing results immediately in the browser.',1 FROM categories WHERE slug='web-development';
INSERT IGNORE INTO tracks(category_id,slug,title,summary,article,position) SELECT id,'backend-development','Backend Development','Build the servers, databases and APIs behind the scenes.','## What backend developers do
Backend development covers the parts users never see: servers, databases, business rules, authentication, payments and the APIs that frontends talk to.

## What you will learn
You begin with basic HTML and CSS, choose one programming language (PHP, Python, Node.js or Go), learn its main framework, then study databases, APIs, advanced backend engineering, security, software testing and DevOps.

## Who it suits
It suits people who enjoy logic, problem solving, data and making systems reliable and secure.',2 FROM categories WHERE slug='web-development';
INSERT IGNORE INTO tracks(category_id,slug,title,summary,article,position) SELECT id,'fullstack-development','Full-Stack Development','Learn both sides and build complete web applications.','## Frontend plus backend
A full-stack developer can build a complete product alone: the interface people use and the server and database behind it. That makes full-stack skills valuable for startups, freelancers and small teams.

## What you will learn
The full-stack roadmap runs through the whole frontend track first, then the whole backend track, so you finish able to design, build, secure and deploy a complete web application.

## Who it suits
It suits people who want the full picture and are ready for a longer journey.',3 FROM categories WHERE slug='web-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,1,0,'HTML','Structure every web page.','html-for-beginners',NULL FROM tracks WHERE slug='frontend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,2,0,'CSS','Style and lay out pages.','css-for-beginners',NULL FROM tracks WHERE slug='frontend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'Bootstrap','Pick Bootstrap or Tailwind CSS: either one unlocks JavaScript.','bootstrap-for-beginners',NULL FROM tracks WHERE slug='frontend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'Tailwind CSS','Pick Bootstrap or Tailwind CSS: either one unlocks JavaScript.','tailwind-css-for-beginners',NULL FROM tracks WHERE slug='frontend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,4,0,'JavaScript','Make pages interactive.','javascript-for-beginners',NULL FROM tracks WHERE slug='frontend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,5,0,'React.js','Build modern interfaces from components.','reactjs-for-beginners',NULL FROM tracks WHERE slug='frontend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,6,0,'Next.js','Build fast, complete React applications.','nextjs-for-beginners',NULL FROM tracks WHERE slug='frontend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,1,0,'HTML','Basic HTML, then CSS.','html-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,2,0,'CSS','Basic HTML, then CSS.','css-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'PHP','Pick one language. Your choice decides your framework.','php-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'Python','Pick one language. Your choice decides your framework.','python-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'Node.js','Pick one language. Your choice decides your framework.','nodejs-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'Go','Pick one language. Your choice decides your framework.','go-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,4,0,'Laravel','The main framework for PHP.','laravel-for-beginners','PHP' FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,4,0,'Django','The main framework for Python.','django-for-beginners','Python' FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,4,0,'Express.js','The main framework for Node.js.','expressjs-for-beginners','Node.js' FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,4,0,'Gin','The main framework for Go.','gin-for-beginners','Go' FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,5,0,'Database Management','Design and query databases.','database-management',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,6,0,'APIs','Build and consume web APIs.','apis-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,7,0,'Advanced Backend Engineering','Architecture, performance and scale.','advanced-backend-engineering',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,8,0,'Security','Protect applications and data.','web-security',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,9,0,'Software Testing','Prove your code works.','software-testing',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,10,0,'DevOps','Deploy and operate software.','devops-for-beginners',NULL FROM tracks WHERE slug='backend-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,1,0,'HTML','Structure every web page.','html-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,2,0,'CSS','Style and lay out pages.','css-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'Bootstrap','Pick Bootstrap or Tailwind CSS: either one unlocks JavaScript.','bootstrap-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,3,0,'Tailwind CSS','Pick Bootstrap or Tailwind CSS: either one unlocks JavaScript.','tailwind-css-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,4,0,'JavaScript','Make pages interactive.','javascript-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,5,0,'React.js','Build modern interfaces from components.','reactjs-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,6,0,'Next.js','Build fast, complete React applications.','nextjs-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,7,0,'PHP','Pick one language. Your choice decides your framework.','php-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,7,0,'Python','Pick one language. Your choice decides your framework.','python-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,7,0,'Node.js','Pick one language. Your choice decides your framework.','nodejs-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,7,0,'Go','Pick one language. Your choice decides your framework.','go-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,8,0,'Laravel','The main framework for PHP.','laravel-for-beginners','PHP' FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,8,0,'Django','The main framework for Python.','django-for-beginners','Python' FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,8,0,'Express.js','The main framework for Node.js.','expressjs-for-beginners','Node.js' FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,8,0,'Gin','The main framework for Go.','gin-for-beginners','Go' FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,9,0,'Database Management','Design and query databases.','database-management',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,10,0,'APIs','Build and consume web APIs.','apis-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,11,0,'Advanced Backend Engineering','Architecture, performance and scale.','advanced-backend-engineering',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,12,0,'Security','Protect applications and data.','web-security',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,13,0,'Software Testing','Prove your code works.','software-testing',NULL FROM tracks WHERE slug='fullstack-development';
INSERT IGNORE INTO track_items(track_id,step,position,label,note,path_slug,requires_label) SELECT id,14,0,'DevOps','Deploy and operate software.','devops-for-beginners',NULL FROM tracks WHERE slug='fullstack-development';
