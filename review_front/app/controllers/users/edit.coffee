`import Ember from 'ember'`

UsersEditController = Ember.Controller.extend

  user: Ember.computed.alias('model.user')
  userRoles: Ember.computed.alias('model.user.roles')
  projects: Ember.computed.alias('model.projects')
  selectedRole: Ember.computed('roleNameFromModel', ->
    { name: @get('roleNameFromModel') }
  )

  userForm: {}

  modelObserver: ( ->
    @set('userForm', @get('model.user'))
  ).observes('model')

  roleNameFromModel: Ember.computed('userRoles', ->
    roles = @get('userRoles').getEach('name')
    roles.uniq().get('firstObject')
  )

  roleName: Ember.computed('selectedRole', ->
    @get('selectedRole').name
  )

  isContractor: Ember.computed('selectedRole', ->
    @get('selectedRole').name == 'contractor'
  )

  selectedProjects: Ember.computed('userRoles', ->
    @get('userRoles').map (role) =>
      @store.getById('project', role.get('resourceId'))
  )

  projectIds: Ember.computed('selectedProjects', 'roleName', ->
    return null unless @get('roleName') == 'contractor'
    @get('selectedProjects').map (role) ->
      role.id if role
  )

  roleOptions: [
      { name: 'admin' }
      { name: 'developer' }
      { name: 'contractor' }
    ]

  actions:
    update: ->
      flashMessages = Ember.get(this, 'flashMessages')
      @get('model.user').setProperties(@get('userForm'))
        .setProperties({projectIds: @get('projectIds'), role: @get('roleName')}).save().then ->
          flashMessages.success('Successfully saved!')

`export default UsersEditController`
