`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

ProjectsIndex = Ember.Route.extend RouteMixin,
  model: (params) ->
    @modelFor('projects')

`export default ProjectsIndex`
