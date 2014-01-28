Review.ProjectCommitsRoute = Ember.Route.extend

  model: ->
    project = @modelFor('project')
    Review.Commit.find project_id: project.get('id')
