`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set('current_user', @store.find('user', 'me'))
  actions:
    error: ->
      @transitionTo('catchall', 'error')


`export default ApplicationRoute`
