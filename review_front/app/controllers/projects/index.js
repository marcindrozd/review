import Ember from 'ember';
var ProjectsIndexController;

ProjectsIndexController = Ember.Controller.extend({
  queryParams: ['page', 'query'],
  pageBinding: 'model.page',
  perPageBinding: 'model.perPage',
  totalPagesBinding: 'model.totalPages',
  page: 1,
  perPage: 25,
  query: "",
  actions: {
    searchInputChanged: function(value) {
      this.set("page", 1);
      return this.set("query", value);
    }
  }
});

export default ProjectsIndexController;
