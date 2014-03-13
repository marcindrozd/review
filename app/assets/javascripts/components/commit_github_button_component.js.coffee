Review.CommitGithubButtonComponent = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons']
  COMMIT_PREVIEW = { width: 1035, height: 600 }

  showCommitInModal: ()->
    url = @get('commit.remoteUrl')
    window.open(url, '', "width = " + COMMIT_PREVIEW.width + ", height = " + COMMIT_PREVIEW.height)

  actions:
    viewCommit: ()-> @showCommitInModal()
