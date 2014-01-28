Review.CommitsRoute = Ember.Route.extend
  model: ->
    @store.find('commit')
