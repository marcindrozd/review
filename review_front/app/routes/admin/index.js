import Ember from 'ember';
var AdminIndexRoute;

AdminIndexRoute = Ember.Route.extend({
  redirect: function() {
    return this.transitionTo('users');
  }
});

export default AdminIndexRoute;
