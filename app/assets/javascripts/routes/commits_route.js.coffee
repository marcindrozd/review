Review.CommitsRoute = Ember.Route.extend

  setupController: (controller, model)->
    controller.set('model', Review.Commit.find())
