import DS from 'ember-data';
var Commit;

Commit = DS.Model.extend({
  remoteId: DS.attr('string'),
  message: DS.attr('string'),
  state: DS.attr('string'),
  remoteUrl: DS.attr('string'),
  project: DS.belongsTo('project'),
  tag: DS.attr('array'),
  expiresAt: DS.attr('date'),
  createdAt: DS.attr('date'),
  authoredAt: DS.attr('date'),
  author: DS.belongsTo('author'),
  tickets: DS.hasMany('ticket'),
  reviewer: DS.belongsTo('user', {
    async: true
  }),
  fixesFor: DS.attr('object'),
  fixedBy: DS.attr('object'),
  fix: DS.hasMany('commit', {
    inverse: 'fixed'
  }, {
    async: true
  }),
  fixed: DS.hasMany('commit', {
    inverse: 'fix'
  }, {
    async: true
  }),
  shortHash: Ember.computed('remoteId', function() {
    return this.get('remoteId').substr(0, 6);
  }),
  isRejected: Ember.computed('state', function() {
    return this.get('state') === 'rejected';
  }),
  isRejectedOrAutoRejected: Ember.computed('state', function() {
    return ['rejected', 'auto_rejected'].contains(this.get('state'));
  }),
  isPassed: Ember.computed('state', function() {
    return this.get('state') === 'passed';
  }),
  isFixed: Ember.computed('state', function() {
    return this.get('state') === 'fixed';
  }),
  isAccepted: Ember.computed('state', function() {
    return this.get('state') === 'accepted';
  }),
  hasExpiration: Ember.computed('state', function() {
    return this.get('state') !== 'fixed' && this.get('state') !== 'accepted';
  }),
  hasReviewer: Ember.computed.notEmpty('reviewer.id')
});

export default Commit;
