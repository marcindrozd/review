import Ember from 'ember';
var UsersEditRoute;

UsersEditRoute = Ember.Route.extend({
  model(params) {
    return Ember.RSVP.hash({
      user: this.store.find('user', params.nickname),
      projects: this.store.findAll('project')
    });
  },
  deactivate() {
    if (this.currentModel.user.get('hasDirtyAttributes')) {
      return this.currentModel.user.rollback();
    }
  }
});

export default UsersEditRoute;
