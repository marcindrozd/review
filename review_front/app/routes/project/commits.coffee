`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

Route = Ember.Route.extend RouteMixin,
  model: (params) ->
    project = @modelFor('project')
    params.project_id = project.get('id')
    @findPaged 'commit', params

`export default Route`
