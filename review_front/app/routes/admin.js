import Ember from 'ember';
var AdminRoute;

AdminRoute = Ember.Route.extend({
  model() {
    return this.store.find('user', 'me');
  },
  afterModel(model) {
    if (!model.get('admin')) {
      return this.transitionTo('index');
    }
  }
});

export default AdminRoute;
