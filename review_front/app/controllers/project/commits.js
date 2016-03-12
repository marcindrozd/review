import Ember from 'ember';
var ProjectCommitsController;

ProjectCommitsController = Ember.Controller.extend({
  sortProperties: ['authoredAt'],
  commits: Ember.computed.alias('model.commits'),
  currentUser: Ember.computed.alias('model.currentUser'),
  project: Ember.computed.alias('model.project'),
  hideAccepted: true,
  queryParams: ['page', 'q', 'tag'],
  pageBinding: 'commits.page',
  perPageBinding: 'commits.perPage',
  totalPagesBinding: 'commits.totalPages',
  page: 1,
  tag: "",
  q: {
    state_not_in: ['accepted', 'fixed']
  },
  actions: {
    toggleAccepted: function() {
      this.toggleProperty('hideAccepted');
      if (this.get('hideAccepted') === false) {
        return this.transitionToRoute({
          queryParams: {
            q: null,
            page: this.page
          }
        });
      } else {
        return this.transitionToRoute({
          queryParams: {
            q: {
              state_not_in: ['accepted', 'fixed'],
              page: this.page
            }
          }
        });
      }
    }
  }
});

export default ProjectCommitsController;
