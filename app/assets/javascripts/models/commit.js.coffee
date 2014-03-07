Review.Commit = DS.Model.extend
  remoteId: DS.attr('string')
  message: DS.attr('string')
  state: DS.attr('string')
  remoteUrl: DS.attr('string')
  project: DS.belongsTo('Review.Project')
  expires_at: DS.attr('date')
  author: DS.belongsTo('Review.Author')
  tickets: DS.hasMany('Review.Ticket')

  shortHash: (()->
    @get('remoteId').substr(0,6)
  ).property('remoteId')

  isRejected: (()->
    ['rejected', 'auto_rejected'].contains(@get('state'))
  ).property('state')

  isPassed: (()->
    @get('state') == 'passed'
  ).property('state')

  isAccepted: (()->
    @get('state') == 'accepted'
  ).property('state')
