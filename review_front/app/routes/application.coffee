`import Ember from 'ember'`

Application = Ember.Route.extend
  setupController: (controller, model)->
    controller.set('current_user', @store.find('user', 'me'))

`export default Application`
