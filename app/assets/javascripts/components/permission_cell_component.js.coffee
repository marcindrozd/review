Review.PermissionCellComponent = Ember.Component.extend
  tagName: 'th'
  classNames: ['permissions', 'text-center']
  classNameBindings: ['permission.isAllowed:success:danger']
  store = this.get('targetObject.store')

  permission: (() ->
    user = @get('user')
    project = @get('project')
    permission = user.get('permissions').find((item) -> item.get('project.id') == project.get('id'))
    permission ||= @createPermission(user, project)
  ).property('project', 'user')

  createPermission: (user, project) ->
    permission = @store.createRecord({
        allowed: false
        user: user
        project: project
      })

  actions:
    grantAccess: (permission)->
      permission.set('allowed', true)
      permission.get('store').commit()

    revokeAccess: (permission)->
      permission.set('allowed', false)
      permission.get('store').commit()
