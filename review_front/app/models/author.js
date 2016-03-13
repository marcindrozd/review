import DS from 'ember-data';

export default DS.Model.extend({
  username: DS.attr('string'),
  name: DS.attr('string'),
  imageUrl: DS.attr('string')
});
