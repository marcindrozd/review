import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';
var ProjectCommitsRoute;

ProjectCommitsRoute = Ember.Route.extend(RouteMixin, {
  queryParams: {
    q: {
      refreshModel: true,
      state_not_in: ['accepted', 'fixed']
    },
    tag: {
      refreshModel: true
    }
  },
  model(params) {
    var modelsHash, project;
    project = this.modelFor('project');
    params = Ember.merge(params, {
      name: project.get("name")
    });
    modelsHash = {
      currentUser: this.store.find('user', 'me'),
      project: this.modelFor('project'),
      commits: this.findPaged('commit', params)
    };
    return Ember.RSVP.hash(modelsHash);
  }
});

export default ProjectCommitsRoute;
