import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  imageUrl: DS.attr('string'),
  name: DS.attr('string'),
  nickname: DS.attr('string'),
  email: DS.attr('string'),
  admin: DS.attr('boolean'),
  person: DS.belongsTo('author', { async: false }),
  token: DS.attr('string'),
  roles: DS.hasMany('role', { async: false }),
  role: DS.attr('string'),
  projectIds: DS.attr('object'),

  isAdmin: Ember.computed.bool("admin"),
  allRoles: Ember.computed.mapBy("roles", "name"),
  userRole: Ember.computed.uniq("allRoles")
});
