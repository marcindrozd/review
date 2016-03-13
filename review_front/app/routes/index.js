import Ember from 'ember';
var ApplicationIndexRoute;

ApplicationIndexRoute = Ember.Route.extend({
  redirect() {
    return this.transitionTo('projects');
  }
});

export default ApplicationIndexRoute;
