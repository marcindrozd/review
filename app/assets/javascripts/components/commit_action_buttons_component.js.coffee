Review.CommitActionButtonsComponent = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons']
  COMMIT_PREVIEW = { width: 1035, height: 600 }

  changeCommitStateTo: (state)->
    commit = @get('commit')
    commit.set('state', state)
    commit.get('store').commit()

  showCommitInModal: ()->
    url = @get('commit.remoteUrl')
    window.open(@get('commit.remoteUrl'), '', "width = #{COMMIT_PREVIEW.width}, height = #{COMMIT_PREVIEW.height}")

  actions:
    viewCommit: ()-> @showCommitInModal()
    acceptCommit: ()-> @changeCommitStateTo('accepted')
    passCommit: ()-> @changeCommitStateTo('passed')
    rejectCommit: ()-> @changeCommitStateTo('rejected')
