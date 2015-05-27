`import Ember from 'ember'`

Admin = Ember.Route.extend
  model: ->
    @store.find('user', 'me')

  afterModel: (model, transition)->
    @transitionTo('index') unless model.get('admin')

`export default Admin`
