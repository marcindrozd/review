import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';
var ProjectsIndexRoute;

ProjectsIndexRoute = Ember.Route.extend(RouteMixin, {
  queryParams: {
    query: {
      refreshModel: true
    }
  },
  model(params) {
    return this.findPaged("project", params);
  }
});

export default ProjectsIndexRoute;
