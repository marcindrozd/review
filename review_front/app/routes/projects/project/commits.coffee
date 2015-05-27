`import Ember from 'ember'`

ProjectCommits = Ember.Route.extend
  model: ->
    @store.find('commit')

`export default ProjectCommits`
