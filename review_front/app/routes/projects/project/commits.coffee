`import Ember from 'ember'`

ProjectsProjectCommitsRoute = Ember.Route.extend
  model: ->
    @store.find('commit')

`export default ProjectsProjectCommitsRoute`
