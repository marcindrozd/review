Review.User = DS.Model.extend
  image_url: DS.attr('string')
  name: DS.attr('string')
  nickname: DS.attr('string')
  admin: DS.attr('boolean')
  permissions: DS.hasMany('permission')
  person: DS.belongsTo('author')
  token: DS.attr('string')

  isMe: Ember.computed('id', ->
    @get('id') == 'me'
  )

  isAdmin: Ember.computed('admin', ->
    @get('admin') == true
  )
