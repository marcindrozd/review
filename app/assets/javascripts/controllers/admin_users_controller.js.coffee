Review.AdminUsersController = Ember.Controller.extend
  projects: Ember.computed.alias('model.projects')
  users: Ember.computed.alias('model.users')
  permissions: Ember.computed.alias('model.permissions')
