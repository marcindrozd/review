`import Ember from 'ember'`

PermissionCell = Ember.Component.extend
  tagName: 'th'
  classNames: ['permissions', 'text-center']
  classNameBindings: ['permission.isAllowed:success:danger']

  permission: Ember.computed 'project', 'user', ->
    user = @get('user')
    project = @get('project')
    permission = user.get('permissions').find (item) ->
      item.get('project.id') == project.get('id')
    permission ||= @createPermission(user, project)

  createPermission: (user, project) ->
    permission = @store.createRecord('permission', {
      allowed: false
      user: user
      project: project
    })

  actions:
    grantAccess: (permission)->
      permission.set('allowed', true).save()

    revokeAccess: (permission)->
      permission.set('allowed', false).save()

`export default PermissionCell`
