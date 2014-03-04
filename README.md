# Review

[![Code Climate](https://codeclimate.com/github/netguru/review.png)](https://codeclimate.com/github/netguru/review)

![Circle CI](https://circleci.com/gh/netguru/review/tree/master.png?circle-token=f05c3dd432a61a6c0fe4fc4b20d5f7b6468868c9)

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

## Testing
