`import Ember from 'ember'`

UserController = Ember.Controller.extend

  user: Ember.computed.alias('model.user')
  userRoles: Ember.computed.alias('model.user.roles')
  projects: Ember.computed.alias('model.projects')
  roles: Ember.computed.alias('model.roles')

`export default UserController`
