Review.AdminIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo('admin.users')
