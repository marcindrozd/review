import Ember from 'ember';

export default Ember.Route.extend({
  model(params) {
    return Ember.RSVP.hash({
      user: this.store.findRecord('user', params.nickname),
      projects: this.store.findAll('project')
    });
  },
  deactivate() {
    if (this.currentModel.user.get('hasDirtyAttributes')) {
      return this.currentModel.user.rollbackAttributes();
    }
  }
});
