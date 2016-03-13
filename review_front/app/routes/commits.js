import Ember from 'ember';
var CommitsRoute;

CommitsRoute = Ember.Route.extend({
  model() {
    return this.store.find('commit');
  }
});

export default CommitsRoute;
