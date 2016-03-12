import Ember from 'ember';
var COMMIT_PREVIEW, CommitGithubButton;

CommitGithubButton = Ember.Component.extend({
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons'],
  classNameBindings: ['currentUsersCommit']
}, COMMIT_PREVIEW = {
  width: 1024,
  height: 768
}, {
  url: Ember.computed.oneWay('commit.remoteUrl'),
  currentUsersCommit: Ember.computed('currentUser', function() {
    return this.currentUserIsCommitAuthor();
  }),
  showCommitInModal: function() {
    var commit_prev, left, top, url;
    url = this.get('url');
    left = screen.width / 2 - COMMIT_PREVIEW.width / 2 + screen.availLeft;
    top = screen.height / 2 - COMMIT_PREVIEW.height / 2 + screen.availTop;
    commit_prev = window.open(url, 'commit_preview', "width=" + COMMIT_PREVIEW.width + ", height=" + COMMIT_PREVIEW.height + ", top=" + top + ", left=" + left + ", scrollbars=yes");
    return commit_prev.focus();
  },
  currentUserIsCommitAuthor: function() {
    if (!this.get('currentUser')) {
      return false;
    }
    return this.get('currentUser').get('nickname') === this.get('commit').get('author').get('username');
  },
  changeCommitStateTo: function(state) {
    if (this.currentUserIsCommitAuthor()) {
      return;
    }
    return this.get('commit').setProperties({
      state: state,
      reviewer: this.get('currentUser')
    }).save();
  },
  actions: {
    viewCommit: function() {
      return this.showCommitInModal();
    },
    acceptCommit: function() {
      return this.changeCommitStateTo('accepted');
    },
    passCommit: function() {
      return this.changeCommitStateTo('passed');
    },
    rejectCommit: function() {
      return this.changeCommitStateTo('rejected');
    }
  }
});

export default CommitGithubButton;
