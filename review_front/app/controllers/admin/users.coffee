`import Ember from 'ember'`

AdminUsersController = Ember.Controller.extend

  projects: Ember.computed.alias('model.projects')
  users: Ember.computed.alias('model.users')
  permissions: Ember.computed.alias('model.permissions')

  page: 1
  perPage: 25

`export default AdminUsersController`
