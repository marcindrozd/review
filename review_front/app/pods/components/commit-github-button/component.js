import Ember from 'ember';

const COMMIT_PREVIEW = {
  width: 1024,
  height: 768
};

export default Ember.Component.extend({
  classNames: ['btn-group', 'btn-group-xs', 'commit-action-buttons'],
  classNameBindings: ['currentUsersCommit'],
  url: Ember.computed.oneWay('commit.remoteUrl'),
  currentUsersCommit: Ember.computed('currentUser', function() {
    return this.currentUserIsCommitAuthor();
  }),

  showCommitInModal() {
    var commit_prev, left, top, url;
    url = this.get('url');
    left = screen.width / 2 - COMMIT_PREVIEW.width / 2 + screen.availLeft;
    top = screen.height / 2 - COMMIT_PREVIEW.height / 2 + screen.availTop;
    commit_prev = window.open(url, 'commit_preview', "width=" + COMMIT_PREVIEW.width + ", height=" + COMMIT_PREVIEW.height + ", top=" + top + ", left=" + left + ", scrollbars=yes");
    return commit_prev.focus();
  },
  currentUserIsCommitAuthor() {
    if (!this.get('currentUser')) {
      return false;
    }
    return this.get('currentUser').get('nickname') === this.get('commit').get('author').get('username');
  },
  changeCommitStateTo(state) {
    if (this.currentUserIsCommitAuthor()) {
      return;
    }
    const commit = this.get('commit');
    commit.setProperties({
      state: state,
      reviewer: this.get('currentUser')
    });
    commit.save();
  },

  actions: {
    viewCommit() {
      return this.showCommitInModal();
    },
    acceptCommit() {
      return this.changeCommitStateTo('accepted');
    },
    passCommit() {
      return this.changeCommitStateTo('passed');
    },
    rejectCommit() {
      return this.changeCommitStateTo('rejected');
    }
  }
});
