import Ember from 'ember';

export default Ember.Controller.extend({
  flashMessages: Ember.inject.service(),
  user: Ember.computed.alias('model.user'),
  userRoles: Ember.computed.alias('model.user.roles'),
  projects: Ember.computed.alias('model.projects'),
  selectedRole: Ember.computed('roleNameFromModel', function() {
    return { name: this.get('roleNameFromModel') };
  }),
  userForm: {},
  modelObserver: Ember.observer('model', function() {
    return this.set('userForm', this.get('model.user'));
  }),
  roleNameFromModel: Ember.computed('userRoles', function() {
    const roles = this.get('userRoles').getEach('name');
    return roles.uniq().get('firstObject');
  }),
  roleName: Ember.computed.alias('selectedRole.name'),
  isContractor: Ember.computed.equal('roleName', "contractor"),
  selectedProjects: Ember.computed('userRoles', function() {
    const store = this.store;
    return this.get('userRoles').map(function(role) {
      return store.peekRecord('project', role.get('resourceId'));
    });
  }),
  projectIds: Ember.computed('selectedProjects.[]', 'isContractor', function() {
    if (this.get('isContractor')) {
      return this.get('selectedProjects').mapBy("id");
    } else {
      return null;
    }
  }),
  roleOptions: [
    { name: 'admin' },
    { name: 'developer' },
    { name: 'contractor' }
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
