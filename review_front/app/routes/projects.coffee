`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

Projects = Ember.Route.extend RouteMixin,
  perPage: 25

  model: (params)->
    @findPaged 'project', params

`export default Projects`
