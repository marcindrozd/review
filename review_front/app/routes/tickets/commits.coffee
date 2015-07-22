`import Ember from 'ember'`

TicketsCommitsRoute = Ember.Route.extend
  setupController: (controller, model)->
    ticket = @modelFor('ticket')
    controller.set('ticket', ticket)
    commits = @store.find('commit', ticket_id: ticket.get('id'))
    controller.set('commits', commits)

`export default TicketsCommitsRoute`
