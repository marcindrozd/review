`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

ProjectsRoute = Ember.Route.extend RouteMixin,
  perPage: 25

  model: (params)->
    @findPaged 'project', params

`export default ProjectsRoute`
