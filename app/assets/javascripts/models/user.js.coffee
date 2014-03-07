Review.User = DS.Model.extend
  image_url: DS.attr('string')
  name: DS.attr('string')
  nickname: DS.attr('string')
  admin: DS.attr('boolean')
  permissions: DS.hasMany('Review.Permission' )
  person: DS.belongsTo('Review.Author')

  isMe: (()->
    @.get('id') == 'me'
  ).property('id')

  isAdmin: (()->
    @get('admin') == true
  ).property('admin')
