`import Ember from 'ember';`

Route = Ember.Route.extend
  model: ->
    @modelFor('projects')

`export default Route;`
