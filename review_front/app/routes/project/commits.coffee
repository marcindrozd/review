`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

Route = Ember.Route.extend RouteMixin,
  queryParams:
    q:
      refreshModel: true
      state_not_in: ['accepted', 'fixed']

  model: (params) ->
    project = @modelFor('project')
    params.project_id = project.get('id')
    @findPaged 'commit', params

  setupController: (controller, model)->
    controller.set('current_user', @store.find('user', 'me'))
    controller.set('model', model)

`export default Route`
