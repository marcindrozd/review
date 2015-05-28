`import Ember from 'ember'`

CommitActionButtons = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons']

  changeCommitStateTo: (state)->
    commit = @get('commit')
    commit.set('state', state).save()

  actions:
    acceptCommit: ()-> @changeCommitStateTo('accepted')
    passCommit: ()-> @changeCommitStateTo('passed')
    rejectCommit: ()-> @changeCommitStateTo('rejected')

`export default CommitActionButtons`
