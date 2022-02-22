
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