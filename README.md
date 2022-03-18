
# SYSC4806
- Notion https://www.notion.so/SYSC-4806-Project-a9e49531d8364814aff20f7801e1a080

Ruby version = 3.0.3
Rails version = 7.0.2.2
Node Version = any 
Python version = 2.7.18

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

## Current Project State
- [March 7th, 2022]
- As of now, the project repo is setup, a project roadmap has been created, and a database schema has been completed.
- The project has all of the database tables from our design
![SYSC4806 Database Diagram](https://user-images.githubusercontent.com/46693188/157083897-56cc62a5-d83e-4f1f-9736-e3ae6a6e06b2.png)
- The project has apis to create, update, and delete surveys and create, update, and delete text questions, but they have not been merged in due to an external issue with the unit tests

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

