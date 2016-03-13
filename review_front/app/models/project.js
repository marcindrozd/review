import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  rejected: DS.attr('number'),
  pending: DS.attr('number'),
  accepted: DS.attr('number'),
  total: DS.attr('number'),
  grade: DS.attr('string'),
  token: DS.attr('string'),
  url: DS.attr('string'),

  reviewIsGood: Ember.computed.equal("grade", "good")
});
