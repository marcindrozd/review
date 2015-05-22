Review.AdminCellComponent = Ember.Component.extend
  tagName: 'th'
  classNames: ['text-center']
  classNameBindings: ['user.isAdmin:danger:success']

  actions:
    setAdmin: (user)->
      user.set('admin', true).save()

    removeAdmin: (user)->
      user.set('admin', false).save()
