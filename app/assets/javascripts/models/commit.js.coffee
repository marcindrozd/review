Review.Commit = DS.Model.extend
  remoteId: DS.attr('string')
  message: DS.attr('string')
  state: DS.attr('string')
  remoteUrl: DS.attr('string')
  project: DS.belongsTo('project')
  expiresAt: DS.attr('date')
  createdAt: DS.attr('date')
  authoredAt: DS.attr('date')
  author: DS.belongsTo('author')
  tickets: DS.hasMany('ticket')
  fix: DS.hasMany('commit', {inverse: 'fix'})
  fixed: DS.hasMany('commit', {inverse: 'fixed'})

  shortHash: (()->
    @get('remoteId').substr(0,6)
  ).property('remoteId')

  isRejected: (()->
    ['rejected', 'auto_rejected'].contains(@get('state'))
  ).property('state')

  isPassed: (()->
    @get('state') == 'passed'
  ).property('state')

  isFixed: (()->
    @get('state') == 'fixed'
  ).property('state')

  isAccepted: (()->
    @get('state') == 'accepted'
  ).property('state')

  belongsToMe: (()->
    @store.find('user', 'me').get('person') is @get('author')
  ).property()
