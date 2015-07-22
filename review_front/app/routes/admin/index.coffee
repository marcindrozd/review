`import Ember from 'ember'`

AdminIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo('users')

`export default AdminIndexRoute`
