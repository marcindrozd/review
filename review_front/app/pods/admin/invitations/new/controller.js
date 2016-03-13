import Ember from 'ember';

export default Ember.Controller.extend({
  flashMessages: Ember.inject.service(),
  projects: Ember.computed.alias('model.projects'),
  selectedRole: null,
  email: null,
  selectedProjects: [],
  roleOptions: [
    { name: 'admin' },
    { name: 'developer' },
    { name: 'contractor' }
  ],

  roleName: Ember.computed.alias('selectedRole.name'),
  isContractor: Ember.computed.equal('roleName', "contractor"),
  projectIds: Ember.computed('selectedProjects.[]', 'isContractor', function() {
    if (this.get('isContractor')) {
      return this.get('selectedProjects').mapBy("id");
    } else {
      return null;
    };
  }),
  invitationDidChange: Ember.observer('model', function() {
    this.set('email', null);
    this.set('selectedRole', null);
    return this.set('selectedProjects', []);
  }),
  actions: {
    create() {
      const flashMessages = this.get('flashMessages');
      const invitation = this.get("model.invitation");
      invitation.setProperties({
        email: this.get('email'),
        role: this.get('roleName'),
        projectIds: this.get('projectIds')
      });
      invitation.save().then(function() {
        flashMessages.success('Your message was sent!');
      }).catch(function() {
        flashMessages.danger('Incorrect email address!');
      });
    }
  }
});
