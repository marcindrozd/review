Review.ProjectCommitsRoute = Ember.Route.extend
  model: ->
    project = @modelFor('project')
    @store.find('commit', project_id: project.get('id'))
