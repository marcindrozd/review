`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

AdminUsers = Ember.Route.extend RouteMixin,
  perPage: 25

  model: (params)->
    Ember.RSVP.hash
      projects: @store.find('project')
      users: @findPaged 'user', params
      permissions: @store.find('permission')

`export default AdminUsers`
