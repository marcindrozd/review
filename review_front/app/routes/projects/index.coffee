`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

ProjectsIndexRoute = Ember.Route.extend RouteMixin,
  queryParams:
    query:
      refreshModel: true
  model: (params)->
    @findPaged("project", params)

`export default ProjectsIndexRoute`
