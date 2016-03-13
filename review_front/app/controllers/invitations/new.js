import Ember from 'ember';
var InvitationsNewController;

InvitationsNewController = Ember.Controller.extend({
  projects: Ember.computed.alias('model.projects'),
  selectedRole: null,
  email: null,
  selectedProjects: [],
  roleOptions: [
    {
      name: 'admin'
    }, {
      name: 'developer'
    }, {
      name: 'contractor'
    }
  ],
  isContractor: Ember.computed('selectedRole', function() {
    if (this.get('selectedRole')) {
      return this.get('selectedRole').name === 'contractor';
    }
  }),
  roleName: Ember.computed('selectedRole', function() {
    return this.get('selectedRole').name;
  }),
  projectIds: Ember.computed('selectedProjects', 'roleName', function() {
    if (this.get('roleName') !== 'contractor') {
      return null;
    }
    return this.get('selectedProjects').map(function(project) {
      if (project) {
        return project.id;
      }
    });
  }),
  invitationDidChange: Ember.observer('model', function() {
    this.set('email', null);
    this.set('selectedRole', null);
    return this.set('selectedProjects', []);
  }),
  actions: {
    create() {
      var flashMessages;
      flashMessages = Ember.get(this, 'flashMessages');
      return this.get('model.invitation').setProperties({
        email: this.get('email'),
        role: this.get('roleName'),
        projectIds: this.get('projectIds')
      }).save().then(function() {
        return flashMessages.success('Your message was sent!');
      })["catch"](function() {
        return flashMessages.danger('Incorrect email address!');
      });
    }
  }
});

export default InvitationsNewController;
