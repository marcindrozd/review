import DS from 'ember-data';
var Role;

Role = DS.Model.extend({
  name: DS.attr('string'),
  resourceId: DS.attr('number'),
  resourceType: DS.attr('string')
});

export default Role;
