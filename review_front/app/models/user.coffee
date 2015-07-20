`import DS from 'ember-data'`

User = DS.Model.extend {
  imageUrl: DS.attr('string')
  name: DS.attr('string')
  nickname: DS.attr('string')
  email: DS.attr('string')
  admin: DS.attr('boolean')
  person: DS.belongsTo('author')
  token: DS.attr('string')
  roles: DS.hasMany('role')
  role: DS.attr('string')
  projectIds: DS.attr('object')

  isAdmin: Ember.computed('admin', ->
    @get('admin') == true
  )

  allRoles: Ember.computed('roles', ->
    @get('roles').getEach('name')
  )

  userRole: Ember.computed.uniq('allRoles')
}

`export default User`
