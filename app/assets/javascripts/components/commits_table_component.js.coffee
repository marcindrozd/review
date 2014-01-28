Review.CommitsTableComponent = Ember.Component.extend
  tagName: 'article'
  classNames: ['commits']

  actions:
    acceptCommit: (commit)->
      commit.set('state', 'accepted')
      commit.get('store').commit()

    passCommit: (commit)->
      commit.set('state', 'passed')
      commit.get('store').commit()

    rejectCommit: (commit)->
      commit.set('state', 'rejected')
      commit.get('store').commit()
