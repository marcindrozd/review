`import Ember from 'ember'`

UserController = Ember.Controller.extend

  user: Ember.computed.alias('model.user')
  projects: Ember.computed.alias('model.projects')


`export default UserController`
