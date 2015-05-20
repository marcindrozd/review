Review.AdminUsersRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set('model', @store.find('project'))
    controller.set('model.users', @store.find('user'))
    controller.set('model.permissions', @store.find('permission'))
