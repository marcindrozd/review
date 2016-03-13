import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';
var InvitationsRoute;

InvitationsRoute = Ember.Route.extend(RouteMixin, {
  perPage: 25,
  model(params) {
    return this.findPaged('invitation', params);
  }
});

export default InvitationsRoute;
