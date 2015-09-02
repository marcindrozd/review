`import Ember from 'ember'`

CommitGithubButton = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons']
  classNameBindings: ['currentUsersCommit']
  COMMIT_PREVIEW = { width: 1024, height: 768 }
  url: Ember.computed.oneWay('commit.remoteUrl')
  currentUsersCommit: Ember.computed('currentUser', ->
    @currentUserIsCommitAuthor()
  )

  showCommitInModal: ->
    url = @get('url')

    left = screen.width / 2 - COMMIT_PREVIEW.width / 2 + screen.availLeft
    top = screen.height / 2 - COMMIT_PREVIEW.height / 2 + screen.availTop

    commit_prev = window.open(url, 'commit_preview', "width=#{COMMIT_PREVIEW.width},
      height=#{COMMIT_PREVIEW.height}, top=#{top}, left=#{left}")
    commit_prev.focus()

  currentUserIsCommitAuthor: ->
    return false unless @get('currentUser')
    @get('currentUser').get('nickname') == @get('commit').get('author').get('username')

  changeCommitStateTo: (state)->
    return if @currentUserIsCommitAuthor()

    @get('commit').setProperties({ state: state, reviewer: @get('currentUser') }).save()

  actions:
    viewCommit: ()-> @showCommitInModal()
    acceptCommit: ()-> @changeCommitStateTo('accepted')
    passCommit: ()-> @changeCommitStateTo('passed')
    rejectCommit: ()-> @changeCommitStateTo('rejected')

`export default CommitGithubButton`
