import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  remoteId: DS.attr('string'),
  message: DS.attr('string'),
  state: DS.attr('string'),
  remoteUrl: DS.attr('string'),
  project: DS.belongsTo('project', { async: false }),
  tag: DS.attr('array'),
  expiresAt: DS.attr('date'),
  createdAt: DS.attr('date'),
  authoredAt: DS.attr('date'),
  author: DS.belongsTo('author', { async: false }),
  reviewer: DS.belongsTo('user'),
  fixesFor: DS.attr('object'),
  fixedBy: DS.attr('object'),
  fix: DS.hasMany('commit', { inverse: 'fixed' }),
  fixed: DS.hasMany('commit', { inverse: 'fix' }),

  isRejected: Ember.computed.equal('state', "rejected"),
  isPassed: Ember.computed.equal('state', "passed"),
  isFixed: Ember.computed.equal('state', "fixed"),
  isAccepted: Ember.computed.equal('state', "accepted"),
  hasReviewer: Ember.computed.notEmpty('reviewer.id'),

  shortHash: Ember.computed('remoteId', function() {
    return this.get('remoteId').substr(0, 6);
  }),
  hasExpiration: Ember.computed('state', function() {
    return !['accepted', 'fixed'].contains(this.get('state'));
  }),
  isRejectedOrAutoRejected: Ember.computed('state', function() {
    return ['rejected', 'auto_rejected'].contains(this.get('state'));
  }),
});
