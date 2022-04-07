
# SYSC4806
- Notion https://www.notion.so/SYSC-4806-Project-a9e49531d8364814aff20f7801e1a080. Notion was used to organize and store the meeting notes, the tech docs, the roadmap, and much more. 

**ALL OTHER DOCUMENTATION CAN BE FOUND HERE https://github.com/AashnaNarang/SYSC4806/wiki**

Ruby version = 3.0.3
Rails version = 7.0.2.2
Node Version = any 
Python version = 2.7.18
PostgreSQL version = 14.2

## Setup Instructions
1. Go to https://nodejs.org/en/download/ and install node js
2. Follow the instructions here to install yarn https://classic.yarnpkg.com/lang/en/docs/install/#windows-stable
3. Go to https://rubyinstaller.org/downloads/ and install Ruby version 3.0.3 with dev kit
4. Check that the version is correct by running `ruby --version` in a terminal in your IDE
5. Run `bundle install` in the project root folder to download all the required gems locally
6. Run `yarn install` in the project root folder to download the required modules locally
    1. If you run into any issues with python not being found, please follow the solution described here https://stackoverflow.com/questions/45801457/node-js-python-not-found-exception-due-to-node-sass-and-node-gyp
7. Run `rails db:migrate` in the project root folder
    1. Note: If you don't see any output after running this command try running `bin/rails db:migrate` instead. 
8. Run `rails s` and navigate to localhost:3000

## Project State
- [March 7th, 2022]
- As of now, the project repo is setup, a project roadmap has been created, and a database schema has been completed.
- The project has all of the database tables from our design
![SYSC4806 Database Diagram](https://user-images.githubusercontent.com/46693188/157083897-56cc62a5-d83e-4f1f-9736-e3ae6a6e06b2.png)
- The project has apis to create, update, and delete surveys and create, update, and delete text questions, but they have not been merged in due to an external issue with the unit tests
- **Update** [April 7th, 2022]
- As of now, the project is complete. All of the required backend APIs exist and all of the pages we planned to create have been created. There is a homepage where you can view all of the existing surveys and a button to navigate to the /createSurvey page. For each survey on the homepage, you can view all of the survey information and view a list of actions. These actions include responding to a survey and closing a survey **if the survey is live** and viewing the survey metrics **if the survey has been closed**. If you click on the Create Survey button, you will be navigated to the /createSurvey page where you can create a new survey, add open ended text questions, and add multiple choice questions. Once you submit, you will be given a link you can use to share the survey. You can respond to a survey by using the given link or by clicking "Respond to" for a specific survey on the homepage. This page lets users fill in their answers then submit their answers. You can close a specific survey from the homepage. Once the survey is closed you wil be redirected to the survey metrics page. This page displays all of the open-ended responses to the survey and a pie chart of the responses to multiple choice questions. If a user navigates to the link used to respond to a survey but the survey is not live, an error message pops up saying that the survey is now closed and redirects them back to the homepage.
- Here is the updated database schema. The overall structure is the exact same, but the columsn were renamed to use a underscore naming convention since that is the standard for Ruby on Rails. Three new columns have been added which is explained in the diagram below.
- ![SYSC4806 Database Diagram - Copy of Page 1](https://user-images.githubusercontent.com/46693188/162253259-44f75431-dfeb-4f24-a9df-27e6eb19cdb1.png)
- Lastly, the project has auto-deploy enabled for heroku. You can find the deployed website here: https://sysc4806-surveys.herokuapp.com/. The project also has CircleCI integrated which runs all of the rspec unit tests for every pull request. 

## Sprints
### Sprint 1 - February 11 - 25
- **Plan**: The team worked together to setup the project as per the Project Rules document on Brightspace, create a database schema, and set up the project roadmap.
- **Accomplished**: A repo that is ready to develop in, repo setup instructions, a complete database schema, and a project roadmap. 
- **Carryover**: setup CircleCI and Heroku

### Sprint 2 - February 25 - March 8th
- **Plan**: The team plans to finish setting up CircleCI, Heroku, and finish majority of the Create Survey feature [https://github.com/AashnaNarang/SYSC4806/issues/12]. 
- **Accomplished**: Finished majority of the Create Survey feature, setup Heroku and CircleCI

### Sprint 3 - March 8th - March 25th
- **Plan**: The team plans to finish the Create Survey feature, make it so CircleCI runs our unit tests, and finish the Use Survey feature  [https://github.com/AashnaNarang/SYSC4806/issues/29].
- **Accomplished**: The team finished the Create Survey feature and the Use Survey feature

### Sprint 4 - March 25th - April 8th
- **Plan**: The team plans to create a dashboard where you can see all the surveys that you can respond to, a button to create a survey, and end a survey+ see stats. The team also plans to finish a stats page for each survey.
- **Accomplished**: The team successfully finished both the dashboard and metrics features. This allowed the team to complete all of the features we planned to create. We had some tasks that we wanted to finish but decided they were out of scope because of time restrictions and because they are not needed to use the app. These out of scope tasks include adding more error handling in the frontend and adding back buttons. 
