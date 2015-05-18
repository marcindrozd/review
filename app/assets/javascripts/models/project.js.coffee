Review.Project = DS.Model.extend
  name: DS.attr('string')
  rejected: DS.attr('number')
  pending: DS.attr('number')
  accepted: DS.attr('number')
  total: DS.attr('number')
  grade: DS.attr('string')
  token: DS.attr('string')
  permission: DS.hasMany('permission', { async: true} )
