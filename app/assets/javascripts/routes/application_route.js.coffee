Review.ApplicationRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set('current_user', @store.find('user', 'me'))
