import Ember from 'ember';
var InvitationsNewRoute;

InvitationsNewRoute = Ember.Route.extend({
  model: function() {
    return Ember.RSVP.hash({
      invitation: this.store.createRecord('invitation'),
      projects: this.store.query('project', {
        'all': 'true'
      })
    });
  }
});

export default InvitationsNewRoute;
