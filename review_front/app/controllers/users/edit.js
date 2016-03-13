import Ember from 'ember';

export default Ember.Controller.extend({
  flashMessages: Ember.inject.service(),
  user: Ember.computed.alias('model.user'),
  userRoles: Ember.computed.alias('model.user.roles'),
  projects: Ember.computed.alias('model.projects'),
  selectedRole: Ember.computed('roleNameFromModel', function() {
    return {
      name: this.get('roleNameFromModel')
    };
  }),
  userForm: {},
  modelObserver: Ember.observer('model', function() {
    return this.set('userForm', this.get('model.user'));
  }),
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
        return _this.store.peekRecord('project', role.get('resourceId'));
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
    update() {
      const flashMessages = this.get("flashMessages");
      const user = this.get("model.user");
      user.setProperties(this.get('userForm'));
      user.setProperties({
        projectIds: this.get('projectIds'),
        role: this.get('roleName')
      });
      user.save().then(function() {
        flashMessages.success('Successfully saved!');
      });
    }
  }
});
