Review.TicketCommitsRoute = Ember.Route.extend
  setupController: (controller, model)->
    ticket = @modelFor('ticket')
    controller.set('ticket', ticket)
    commits = @store.find('commit', ticket_id: ticket.get('id'))
    controller.set('commits', commits)
