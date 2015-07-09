`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

Users = Ember.Route.extend RouteMixin,
  perPage: 25

  model: (params)->
    Ember.RSVP.hash
      projects: @store.find('project')
      users: @findPaged 'user', params
      currentUserId: @store.find('user', 'me').then (result) -> result.get('id')

`export default Users`
