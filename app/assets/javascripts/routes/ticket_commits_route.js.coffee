Review.TicketCommitsRoute = Ember.Route.extend

  setupController: (controller, model)->
    ticket = @modelFor('ticket')
    controller.set 'ticket', ticket
    controller.set 'commits', Review.Commit.find ticket_id: ticket.get('id')
