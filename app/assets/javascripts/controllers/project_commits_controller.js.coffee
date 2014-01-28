Review.ProjectCommitsController = Ember.ArrayController.extend

  unacceptedCommits: (()->
    @get('model').filter((commit)-> commit.get('state') != 'accepted' )
  ).property('model.@each.state')
