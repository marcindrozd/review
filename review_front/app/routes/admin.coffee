`import Ember from 'ember'`

AdminRoute = Ember.Route.extend
  model: ->
    @store.find('user', 'me')

  afterModel: (model, transition)->
    @transitionTo('index') unless model.get('admin')

`export default AdminRoute`
