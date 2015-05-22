Review.AdminCellComponent = Ember.Component.extend
  tagName: 'th'
  classNames: ['text-center']
  classNameBindings: ['user.isAdmin:danger:success']

  actions:
    setAdmin: (user)->
      user.set('admin', true)
      user.save()

    removeAdmin: (user)->
      user.set('admin', false)
      user.save()
