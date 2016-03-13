import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  resourceId: DS.attr('number'),
  resourceType: DS.attr('string')
});
