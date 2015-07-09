`import Ember from 'ember'`

UsersIndexController = Ember.Controller.extend

  projects: Ember.computed.alias('model.projects')
  users: Ember.computed.alias('model.users')
  currentUserId: Ember.computed.alias('model.currentUserId')

  page: 1
  perPage: 25

`export default UsersIndexController`
