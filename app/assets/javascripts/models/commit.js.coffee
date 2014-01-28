Review.Commit = DS.Model.extend
  remoteId: DS.attr('string')
  message: DS.attr('string')
  state: DS.attr('string')
  remoteUrl: DS.attr('string')
  project: DS.belongsTo('Review.Project')
  tickets: DS.hasMany('Review.Ticket')

  shortHash: (()->
    @get('remoteId').substr(0,6)
  ).property('remoteId')

  isRejected: (()->
    @get('state') == 'rejected'
  ).property('state')

  isPassed: (()->
    @get('state') == 'passed'
  ).property('state')

  isAccepted: (()->
    @get('state') == 'accepted'
  ).property('state')
