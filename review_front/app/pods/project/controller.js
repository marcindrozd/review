import Ember from 'ember';

export default Ember.Controller.extend({
  commits: Ember.computed.alias('model.commits'),
  currentUser: Ember.computed.alias('model.currentUser'),
  project: Ember.computed.alias('model.project'),
  hideAccepted: true,
  queryParams: ['page', 'q', 'tag'],
  page: 1,
  totalPagesBinding: 'commits.totalPages',
  tag: "",
  q: { state_not_in: ['accepted', 'fixed'] },
  actions: {
    pageClicked(page) {
      this.setProperties({ page });
    },
    toggleAccepted() {
      this.toggleProperty('hideAccepted');
      if (this.get('hideAccepted')) {
        return this.transitionToRoute({
          queryParams: {
            q: { state_not_in: ['accepted', 'fixed'] },
            page: 1
          }
        });
      } else {
        return this.transitionToRoute({ queryParams: { q: null, page: 1 } });
      }
    }
  }
});
