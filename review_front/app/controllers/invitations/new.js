import Ember from 'ember';

export default Ember.Controller.extend({
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
  roleName: Ember.computed.alias('selectedRole.name'),
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
      const flashMessages = Ember.get(this, 'flashMessages');
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
