import Ember from 'ember';
var ProjectsProjectCommitsRoute;

ProjectsProjectCommitsRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('commit');
  }
});

export default ProjectsProjectCommitsRoute;
