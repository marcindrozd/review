`import Ember from 'ember';`

Route = Ember.Route.extend
  model: ->
    @store.find('project')

`export default Route;`
