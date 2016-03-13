import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';
var Project;

Project = Ember.Route.extend(RouteMixin, {
  model(params) {
    return this.store.query('project', {
      name: params.name
    }).then(function(project) {
      return project.get("firstObject");
    });
  },
  setupController(controller, model) {
    return controller.set('model', model.get("firstObject"));
  }
});

export default Project;
