`import Ember from 'ember'`

InvitationsNewController = Ember.Controller.extend

  projects: Ember.computed.alias('model.projects')
  selectedRole: null
  email: null
  selectedProjects: []

  roleOptions: [
    { name: 'admin' }
    { name: 'developer' }
    { name: 'contractor' }
  ]

  isContractor: Ember.computed('selectedRole', ->
    @get('selectedRole').name == 'contractor' if @get('selectedRole')
  )

  roleName: Ember.computed('selectedRole', ->
    @get('selectedRole').name
  )

  projectIds: Ember.computed('selectedProjects', 'roleName', ->
    return null unless @get('roleName') == 'contractor'
    @get('selectedProjects').map (project) ->
      project.id if project
  )

  actions:
    create: ->
      flashMessages = Ember.get(this, 'flashMessages')
      @get('model.invitation').setProperties(
        { email: @get('email'), role: @get('roleName'), projectIds: @get('projectIds') }
      ).save().then ->
        flashMessages.success('Your message was sent!')

`export default InvitationsNewController`
