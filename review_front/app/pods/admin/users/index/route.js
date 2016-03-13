import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';

export default Ember.Route.extend(RouteMixin, {
  queryParams: {
    query: { refreshModel: true }
  },
  model(params) {
    return Ember.RSVP.hash({
      projects: this.store.findAll('project'),
      users: this.findPaged('user', params),
      currentUserId: this.store.findRecord('user', 'me').then(function(result) {
        return result.get('id');
      })
    });
  }
});
