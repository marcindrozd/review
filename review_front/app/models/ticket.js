import Ember from 'ember';
import DS from 'ember-data';
var Ticket;

Ticket = DS.Model.extend({
  remoteId: DS.attr('string'),
  remoteUrl: DS.attr('string'),
  color: DS.attr('string'),
  style: Ember.computed('color', function() {
    const style = "background-color: " + (this.get('color'));
    return new Ember.Handlebars.SafeString(style);
  })
});

export default Ticket;
