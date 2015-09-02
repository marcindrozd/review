`import DS from 'ember-data'`

Commit = DS.Model.extend
  remoteId: DS.attr('string')
  message: DS.attr('string')
  state: DS.attr('string')
  remoteUrl: DS.attr('string')
  project: DS.belongsTo('project')
  tag: DS.attr('array')
  expiresAt: DS.attr('date')
  createdAt: DS.attr('date')
  authoredAt: DS.attr('date')
  author: DS.belongsTo('author')
  tickets: DS.hasMany('ticket')
  reviewer: DS.belongsTo('user', {async: true})
  fixesFor: DS.attr('object')
  fixedBy: DS.attr('object')
  fix: DS.hasMany('commit', {inverse: 'fixed'}, {async: true})
  fixed: DS.hasMany('commit', {inverse: 'fix'}, {async: true})

  shortHash: Ember.computed('remoteId', ->
    @get('remoteId').substr(0,6)
  )

  isRejected: Ember.computed('state', ->
    ['rejected', 'auto_rejected'].contains(@get('state'))
  )

  isPassed: Ember.computed('state', ->
    @get('state') == 'passed'
  )

  isFixed: Ember.computed('state', ->
    @get('state') == 'fixed'
  )

  isAccepted: Ember.computed('state', ->
    @get('state') == 'accepted'
  )

  hasExpiration: Ember.computed('state', ->
    @get('state') != 'fixed' and @get('state') != 'accepted'
  )

  hasReviewer: Ember.computed.notEmpty('reviewer.id')

`export default Commit`
