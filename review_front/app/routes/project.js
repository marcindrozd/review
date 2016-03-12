import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';
var Project;

Project = Ember.Route.extend(RouteMixin, {
  model: function(params) {
    return this.store.find('project', {
      name: params.name
    }).then(function(project) {
      return project.get("firstObject");
    });
  },
  setupController: function(controller, model) {
    return controller.set('model', model.get("firstObject"));
  }
});

export default Project;
