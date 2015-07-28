`import Ember from 'ember'`

InvitationsNewRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      invitation: @store.createRecord 'invitation'
      projects: @store.find('project')

`export default InvitationsNewRoute`
