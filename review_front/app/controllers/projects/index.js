import Ember from 'ember';
var ProjectsIndexController;

ProjectsIndexController = Ember.Controller.extend({
  queryParams: ['page', 'query'],
  totalPagesBinding: 'model.totalPages',
  page: 1,
  query: "",
  actions: {
    pageClicked(page) {
      this.setProperties({ page: page });
    },
    searchInputChanged: function(value) {
      this.set("page", 1);
      return this.set("query", value);
    }
  }
});

export default ProjectsIndexController;
