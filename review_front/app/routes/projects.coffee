`import Ember from 'ember'`

Projects = Ember.Route.extend
  model: ->
    @store.find('project')

`export default Projects`
