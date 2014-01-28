Review.Ticket = DS.Model.extend
  remoteId: DS.attr('string')
  remoteUrl: DS.attr('string')
  color: DS.attr('string')

  style: (()->
    "background-color: #{@get('color')}"
  ).property('color')
