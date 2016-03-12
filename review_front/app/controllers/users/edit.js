import Ember from 'ember';
var UsersEditController;

UsersEditController = Ember.Controller.extend({
  user: Ember.computed.alias('model.user'),
  userRoles: Ember.computed.alias('model.user.roles'),
  projects: Ember.computed.alias('model.projects'),
  selectedRole: Ember.computed('roleNameFromModel', function() {
    return {
      name: this.get('roleNameFromModel')
    };
  }),
  userForm: {},
  modelObserver: (function() {
    return this.set('userForm', this.get('model.user'));
  }).observes('model'),
  roleNameFromModel: Ember.computed('userRoles', function() {
    var roles;
    roles = this.get('userRoles').getEach('name');
    return roles.uniq().get('firstObject');
  }),
  roleName: Ember.computed('selectedRole', function() {
    return this.get('selectedRole').name;
  }),
  isContractor: Ember.computed('selectedRole', function() {
    return this.get('selectedRole').name === 'contractor';
  }),
  selectedProjects: Ember.computed('userRoles', function() {
    return this.get('userRoles').map((function(_this) {
      return function(role) {
        return _this.store.getById('project', role.get('resourceId'));
      };
    })(this));
  }),
  projectIds: Ember.computed('selectedProjects', 'roleName', function() {
    if (this.get('roleName') !== 'contractor') {
      return null;
    }
    return this.get('selectedProjects').map(function(role) {
      if (role) {
        return role.id;
      }
    });
  }),
  roleOptions: [
    {
      name: 'admin'
    }, {
      name: 'developer'
    }, {
      name: 'contractor'
    }
  ],
  actions: {
    update: function() {
      var flashMessages;
      flashMessages = Ember.get(this, 'flashMessages');
      return this.get('model.user').setProperties(this.get('userForm')).setProperties({
        projectIds: this.get('projectIds'),
        role: this.get('roleName')
      }).save().then(function() {
        return flashMessages.success('Successfully saved!');
      });
    }
  }
});

export default UsersEditController;
