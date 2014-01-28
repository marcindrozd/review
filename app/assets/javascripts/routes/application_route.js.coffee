Review.ApplicationRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set('current_user', Review.User.find('me'))
