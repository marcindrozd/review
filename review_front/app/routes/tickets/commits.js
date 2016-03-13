import Ember from 'ember';
var TicketsCommitsRoute;

TicketsCommitsRoute = Ember.Route.extend({
  setupController(controller) {
    var commits, ticket;
    ticket = this.modelFor('ticket');
    controller.set('ticket', ticket);
    commits = this.store.query('commit', {
      ticket_id: ticket.get('id')
    });
    return controller.set('commits', commits);
  }
});

export default TicketsCommitsRoute;
