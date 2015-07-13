`import Ember from 'ember'`

User = Ember.Route.extend
  model: (params) ->
    user: @store.find('user', params.nickname)
    projects: @store.find('project')
    roles: @store.find('role')

`export default User`
