import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return Ember.RSVP.hash({
      invitation: this.store.createRecord('invitation'),
      projects: this.store.findAll('project')
    });
  }
});
