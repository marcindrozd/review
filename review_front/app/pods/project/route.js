import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';

export default Ember.Route.extend(RouteMixin, {
  queryParams: {
    q: {
      refreshModel: true
    },
    tag: {
      refreshModel: true
    }
  },
  model(params) {
    return Ember.RSVP.hash({
      currentUser: this.store.findRecord('user', 'me'),
      project: this.store.findRecord('project', params.name),
      commits: this.findPaged('commit', params)
    });
  }
});
