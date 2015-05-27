`import Ember from 'ember'`

AdminIndex = Ember.Route.extend
  redirect: ->
    @transitionTo('admin.users')

`export default AdminIndex`
