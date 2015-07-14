`import Ember from 'ember'`

UserController = Ember.Controller.extend

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
      role.id
  )

  roleOptions: [
      { name: 'admin' }
      { name: 'developer' }
      { name: 'contractor' }
    ]

  actions:
    update: ->
      @get('model.user').setProperties(@get('userForm'))
        .setProperties({projectIds: @get('projectIds'), role: @get('roleName')}).save()

`export default UserController`
