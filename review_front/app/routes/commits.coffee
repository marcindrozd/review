`import Ember from 'ember'`

CommitsRoute = Ember.Route.extend
  model: ->
    @store.find('commit')

`export default CommitsRoute`
