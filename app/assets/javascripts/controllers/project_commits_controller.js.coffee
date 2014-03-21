Review.ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']
  sortAscending: true

  hideAccepted: true

  filteredContent: (->
    content = @

    return content if !content or !@get('hideAccepted')

    return Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      sortProperties: self.sortProperties
      content: content.filter((item)-> !item.get('isAccepted'))
  ).property('model.[]', 'hideAccepted', 'sortBy')

  sortNow: (parameter)->
    this.set('sortProperties', [parameter])

  actions:
    sortBy: (parameter)-> @sortNow(parameter)
