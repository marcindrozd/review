Review.AdminUsersRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      projects: @store.find('project')
      users: @store.find('user')
      permissions: @store.find('permission')
