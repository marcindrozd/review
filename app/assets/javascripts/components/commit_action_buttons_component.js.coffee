Review.CommitActionButtonsComponent = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons']
  COMMIT_PREVIEW = { width: 1035, height: 600 }
  url: Ember.computed.oneWay('commit.remoteUrl')

  changeCommitStateTo: (state)->
    commit = @get('commit')
    commit.set('state', state)
    commit.get('store').commit()

  showCommitInModal: ()->
    url = @get('url')
    commit_prev = window.open(url, 'commit_preview', "width = #{COMMIT_PREVIEW.width}, height = #{COMMIT_PREVIEW.height}")
    commit_prev.focus()

  actions:
    viewCommit: ()-> @showCommitInModal()
    acceptCommit: ()-> @changeCommitStateTo('accepted')
    passCommit: ()-> @changeCommitStateTo('passed')
    rejectCommit: ()-> @changeCommitStateTo('rejected')
