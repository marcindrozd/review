Review.ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ["AuthoredAt"]
  sortAscending: true

  hideAccepted: true

  searchResults: Ember.computed.defaultTo("arrangedContent")

  filteredContent: (->
    searchInput = @get("model")
    if !searchInput or !@get('hideAccepted')
      @set "searchResults", @get("arrangedContent")
    else
      @set "searchResults", @get("arrangedContent").filter((item)-> !item.get('isAccepted'))
    return
  ).observes('hideAccepted')


  sortNow: (parameter)->
    this.set('sortProperties', [parameter])
    @filteredContent()

  actions:
    sortBy: (parameter)-> @sortNow(parameter)
