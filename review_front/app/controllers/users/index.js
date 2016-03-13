import Ember from 'ember';
var UsersIndexController;

UsersIndexController = Ember.Controller.extend({
  queryParams: ['page', 'query'],
  totalPagesBinding: "users.totalPages",
  projects: Ember.computed.alias('model.projects'),
  users: Ember.computed.alias('model.users'),
  currentUserId: Ember.computed.alias('model.currentUserId'),
  page: 1,
  query: "",
  actions: {
    pageClicked(page) {
      this.setProperties({ page: page });
    },
    searchInputChanged(value) {
      this.set("page", 1);
      return this.set("query", value);
    }
  }
});

export default UsersIndexController;
