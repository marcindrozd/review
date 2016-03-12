import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';
var ProjectsRoute;

ProjectsRoute = Ember.Route.extend(RouteMixin, {
  perPage: 25,
  model: function(params) {
    return this.findPaged('project', params);
  }
});

export default ProjectsRoute;
