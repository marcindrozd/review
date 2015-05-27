`import Ember from 'ember'`

AdminUsers = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      projects: @store.find('project')
      users: @store.find('user')
      permissions: @store.find('permission')

`export default AdminUsers`
