import Ember from 'ember';
var TicketsCommitsRoute;

TicketsCommitsRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    var commits, ticket;
    ticket = this.modelFor('ticket');
    controller.set('ticket', ticket);
    commits = this.store.find('commit', {
      ticket_id: ticket.get('id')
    });
    return controller.set('commits', commits);
  }
});

export default TicketsCommitsRoute;
