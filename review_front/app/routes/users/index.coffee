`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

Route = Ember.Route.extend RouteMixin,
  queryParams:
    query:
      refreshModel: true

  model: (params)->
    Ember.RSVP.hash
      projects: @store.find('project')
      users: @findPaged 'user', params
      currentUserId: @store.find('user', 'me').then (result) -> result.get('id')

`export default Route`
