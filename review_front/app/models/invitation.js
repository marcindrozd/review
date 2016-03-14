import DS from 'ember-data';

export default DS.Model.extend({
  email: DS.attr('string'),
  role: DS.attr('string'),
  date: DS.attr('string'),
  status: DS.attr('string'),
  projectIds: DS.attr('object')
});
