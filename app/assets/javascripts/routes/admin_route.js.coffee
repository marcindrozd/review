Review.AdminRoute = Ember.Route.extend
  model: ->
    @store.find('user', 'me')

  afterModel: (model, transition)->
    model.set('admin', true)
    @transitionTo('index') unless model.get('admin')
