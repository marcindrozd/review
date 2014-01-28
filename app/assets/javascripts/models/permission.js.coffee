Review.Permission = DS.Model.extend
  allowed: DS.attr('boolean')
  user: DS.belongsTo('Review.User')
  project: DS.belongsTo('Review.Project')

  isAllowed: (()->
    @get('allowed') == true
  ).property('allowed')

  isDenied: (()->
    @get('allowed') == false
  ).property('allowed')
