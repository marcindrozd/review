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
    const modelsHash = {
      currentUser: this.store.findRecord('user', 'me'),
      project: this.store.findRecord('project', params.name),
      commits: this.findPaged('commit', params)
    };
    return Ember.RSVP.hash(modelsHash);
  }
});

export default ProjectCommitsRoute;
