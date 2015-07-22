`import Ember from 'ember'`

ProjectsIndexRoute = Ember.Route.extend
  model: ->
    @modelFor('projects')

`export default ProjectsIndexRoute`
