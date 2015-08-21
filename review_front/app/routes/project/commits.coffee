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
    @findPaged 'commit', params

  setupController: (controller, model)->
    controller.set('current_user', @store.find('user', 'me'))
    controller.set('model', model)
    controller.set('project', @modelFor('project'))

`export default ProjectCommitsRoute`

