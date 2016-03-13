import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['page', 'query'],
  totalPagesBinding: "users.totalPages",
  projects: Ember.computed.alias('model.projects'),
  users: Ember.computed.alias('model.users'),
  currentUserId: Ember.computed.alias('model.currentUserId'),
  page: 1,
  query: "",

  actions: {
    pageClicked(page) {
      this.setProperties({ page });
    },
    searchInputChanged(value) {
      this.setProperties({ page: 1, query: value });
    }
  }
});
