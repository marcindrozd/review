import Ember from 'ember';
var AdminRoute;

AdminRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('user', 'me');
  },
  afterModel: function(model, transition) {
    if (!model.get('admin')) {
      return this.transitionTo('index');
    }
  }
});

export default AdminRoute;
