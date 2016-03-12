import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';
var Route;

Route = Ember.Route.extend(RouteMixin, {
  queryParams: {
    query: {
      refreshModel: true
    }
  },
  model: function(params) {
    return Ember.RSVP.hash({
      projects: this.store.find('project'),
      users: this.findPaged('user', params),
      currentUserId: this.store.find('user', 'me').then(function(result) {
        return result.get('id');
      })
    });
  }
});

export default Route;
