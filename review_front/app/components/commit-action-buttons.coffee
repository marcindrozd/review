`import Ember from 'ember'`

CommitActionButtons = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons']

  changeCommitStateTo: (state)->
    commit = @get('commit')
    currentUser = @get('current_user')
    commitAuthor = @get('commit.author')

    return if commitAuthor.get('name') == currentUser.get('name')

    commit.set('state', state)
    commit.set('reviewer', currentUser).save()

  actions:
    acceptCommit: ()-> @changeCommitStateTo('accepted')
    passCommit: ()-> @changeCommitStateTo('passed')
    rejectCommit: ()-> @changeCommitStateTo('rejected')

`export default CommitActionButtons`
