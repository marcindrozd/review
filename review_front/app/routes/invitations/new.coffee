`import Ember from 'ember'`

InvitationsNewRoute = Ember.Route.extend
  model: ->
    invitation: @store.createRecord 'invitation'
    projects: @store.find('project')

`export default InvitationsNewRoute`
