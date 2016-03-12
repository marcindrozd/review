import Ember from 'ember';
var UsersEditRoute;

UsersEditRoute = Ember.Route.extend({
  model: function(params) {
    return Ember.RSVP.hash({
      user: this.store.find('user', params.nickname),
      projects: this.store.find('project')
    });
  },
  deactivate: function() {
    if (this.currentModel.user.get('isDirty')) {
      return this.currentModel.user.rollback();
    }
  }
});

export default UsersEditRoute;
