# Review

[![Code Climate](https://codeclimate.com/github/netguru/review.png)](https://codeclimate.com/github/netguru/review)

![Circle CI](https://circleci.com/gh/netguru/review/tree/master.png?circle-token=f05c3dd432a61a6c0fe4fc4b20d5f7b6468868c9)

## Initial setup
Pull the repository from github:
`git clone git@github.com:netguru/review.git`

Install required gems:
```
bundle install
```

## Database
Make sure you have postgress installed and running on your machine.
Copy the sample database.yml to your main folder by:
```
cp database.yml.sample database.yml
```

Edit the user name in the copied file to adjust it to your database setup.
Setup the database by:
```
rake db:setup
```
Then migrate your db schema from rails:
```
rake db:migrate
```

## Setting up secrets
Generate a secret token:
```
rake secret
```
Paste it in the sec_config.yml file for the development enviroment and do the
same for the test enviroment with a different key.

## Example data
This app is heavily using github webhooks. Everytime someone pushes commit, Review will receive a payload - json data with relevant event information. Check out an example payload in `db/fixtures/payload.json`. Based on this data, projects and commits are created. If this concept is new to you - head over to [github api documentation](https://developer.github.com/webhooks/).

Run a dedicated task to see this in action: `bundle exec rake hook:test` (make sure your local server is running)

## Troubleshooting
Should you have problems with installing `therubyracer` gem
try running the following:
```
brew install v8
gem install libv8 -v 3.16.14.3  -- --with-system-v8
gem install therubyracer
```

## Deploying app on Heroku
You can read how to deploy the app on heroku [here](https://devcenter.heroku.com/articles/git)

If you need help setting up database, you can check [here](https://devcenter.heroku.com/articles/heroku-postgresql)

Below you will find environment variables you will need to [setup](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application):

  * SECRET_KEY_BASE
  * GITHUB_APPKEY
  * GITHUB_SECRET

Setting up these variables is not required:

  * ROLLBAR_TOKEN
  * GOOGLE_A_ID
  * REVIEW_DOMAIN
  * REVIEW_TOKEN

## Testing
