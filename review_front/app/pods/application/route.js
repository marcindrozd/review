import Ember from 'ember';
var ApplicationRoute;

ApplicationRoute = Ember.Route.extend({
  model() {
    return this.store.find('user', 'me');
  }
});

export default ApplicationRoute;
