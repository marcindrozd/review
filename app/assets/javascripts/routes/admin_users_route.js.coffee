Review.AdminUsersRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set('model', {})
    controller.set('projects', @store.find('project'))
    controller.set('users', @store.find('user'))
    controller.set('permissions', @store.find('permission'))
