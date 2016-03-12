import DS from 'ember-data';
var Invitation;

Invitation = DS.Model.extend({
  email: DS.attr('string'),
  role: DS.attr('string'),
  date: DS.attr('string'),
  status: DS.attr('string'),
  projectIds: DS.attr('object')
});

export default Invitation;
