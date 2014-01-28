Review.PermissionCellComponent = Ember.Component.extend
  tagName: 'th'
  classNames: ['permissions', 'text-center']
  classNameBindings: ['permission.isAllowed:success','permission.isDenied:danger']

  permission: (() ->
    user = @get('user')
    project = @get('project')
    tempPermission = user.get('permissions').filter((item, index, enumerable) ->
      item.get("project.id").match(project.id)
    ).get('firstObject')
    tempPermission ||= @createPermission(user, project)
  ).property('project', 'user')

  createPermission: (user, project) ->
    permission = Review.Permission.createRecord({
        allowed: false
      })
    permission.set('user', user)
    permission.set('project', project)
    permission.save()
    permission

  actions:
    addAccess: (permission)->
      permission.set('allowed', true)
      permission.get('store').commit()

    removeAccess: (permission)->
      permission.set('allowed', false)
      permission.get('store').commit()
