Review.ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']

  hideAccepted: true

  searchResults: Ember.computed.oneWay('arrangedContent')

  filteredContent: (->
    searchInput = @get('model')
    if !searchInput or !@get('hideAccepted')
      @set 'searchResults', @get("arrangedContent")
    else
      @set 'searchResults', @get("arrangedContent").filter((item)-> !item.get('isAccepted'))
    return
  ).observes('hideAccepted')


  sortNow: (parameter)->
    @set('sortProperties', [parameter])
    @filteredContent()

  actions:
    sortBy: (parameter)-> @sortNow(parameter)
    toggleAccepted: -> @toggleProperty('hideAccepted')
