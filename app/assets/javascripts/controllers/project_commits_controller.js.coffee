Review.ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']
  sortAscending: true

  hideAccepted: true

  filteredContent: (->
    content = @get('model')
    return content if !content or !@get('hideAccepted')
    content.filter((item)-> !item.get('isAccepted'))
  ).property('model.[]', 'hideAccepted')
