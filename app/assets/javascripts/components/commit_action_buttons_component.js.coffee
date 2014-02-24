Review.CommitActionButtonsComponent = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs']

  changeCommitStateTo: (state)->
      commit = @get('commit')
      commit.set('state', state)
      commit.get('store').commit()

  actions:
    acceptCommit: ()-> @changeCommitStateTo('accepted')
    passCommit: ()-> @changeCommitStateTo('passed')
    rejectCommit: ()-> @changeCommitStateTo('rejected')
