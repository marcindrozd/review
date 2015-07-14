`import Ember from 'ember'`

User = Ember.Route.extend
  model: (params) ->
    Ember.RSVP.hash
      user: @store.find('user', params.nickname)
      projects: @store.find('project')

  deactivate: ->
    @currentModel.user.rollback() if @currentModel.user.get('isDirty')

`export default User`
