import Ember from 'ember';
var AdminIndexRoute;

AdminIndexRoute = Ember.Route.extend({
  redirect() {
    return this.transitionTo('users');
  }
});

export default AdminIndexRoute;
