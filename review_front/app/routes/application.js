import Ember from 'ember';
var ApplicationRoute;

ApplicationRoute = Ember.Route.extend({
  setupController(controller) {
    return controller.set('current_user', this.store.find('user', 'me'));
  }
});

export default ApplicationRoute;
