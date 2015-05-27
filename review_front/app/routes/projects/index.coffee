`import Ember from 'ember'`

ProjectsIndex = Ember.Route.extend
  model: ->
    @modelFor('projects')

`export default ProjectsIndex`
