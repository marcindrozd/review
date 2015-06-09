`import Ember from 'ember'`

ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']

  hideAccepted: true

  searchResults: Ember.computed.oneWay('arrangedContent')

  filteredContent: Ember.observer('hideAccepted', ->
    searchInput = @get('model')
    if !searchInput or !@get('hideAccepted')
      @set 'searchResults', @get("arrangedContent")
    else
      @set 'searchResults', @get("arrangedContent").filter((item)-> !item.get('isAccepted'))
    return
  )

  sortNow: (parameter)->
    @set('sortProperties', [parameter])
    @filteredContent()

  actions:
    sortBy: (parameter)-> @sortNow(parameter)
    toggleAccepted: ->
      @set 'hideAccepted', !(@get('hideAccepted'))

  queryParams: ['page', 'pageNumber', 'perPage']
  pageBinding: 'content.page'
  perPageBinding: 'content.perPage'
  page: 1
  perPage: 25

`export default ProjectCommitsController`
