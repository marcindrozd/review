`import Ember from 'ember'`

AdminIndex = Ember.Route.extend
  redirect: ->
    @transitionTo('users')

`export default AdminIndex`
