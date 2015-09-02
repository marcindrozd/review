`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

ProjectCommitsRoute = Ember.Route.extend RouteMixin,
  queryParams:
    q:
      refreshModel: true
      state_not_in: ['accepted', 'fixed']
    tag:
      refreshModel: true

  model: (params) ->
    project = @modelFor('project')
    params = Ember.merge(params, {name: project.get("name")})
    modelsHash =
      currentUser: @store.find('user', 'me')
      project: @modelFor('project')
      commits: @findPaged 'commit', params
    Ember.RSVP.hash(modelsHash)

`export default ProjectCommitsRoute`
