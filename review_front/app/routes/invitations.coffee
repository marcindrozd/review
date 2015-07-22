`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

Invitations = Ember.Route.extend RouteMixin,
  perPage: 25

  model: (params)->
    @findPaged 'invitation', params

`export default Invitations`
