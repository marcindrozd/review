`import Ember from 'ember'`

Commits = Ember.Route.extend
  model: ->
    @store.find('commit')

`export default Commits`
