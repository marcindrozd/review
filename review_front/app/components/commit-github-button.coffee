`import Ember from 'ember'`

CommitGithubButton = Ember.Component.extend
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons']
  COMMIT_PREVIEW = { width: 1024, height: 768 }
  url: Ember.computed.oneWay('commit.remoteUrl')

  showCommitInModal: ()->
    url = @get('url')

    left = screen.width / 2 - COMMIT_PREVIEW.width / 2 + screen.availLeft
    top = screen.height / 2 - COMMIT_PREVIEW.height / 2 + screen.availTop

    commit_prev = window.open(url, 'commit_preview', "width=#{COMMIT_PREVIEW.width},
      height=#{COMMIT_PREVIEW.height}, top=#{top}, left=#{left}")
    commit_prev.focus()

  actions:
    viewCommit: ()-> @showCommitInModal()

`export default CommitGithubButton`
