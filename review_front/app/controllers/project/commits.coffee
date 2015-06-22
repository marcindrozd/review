`import Ember from 'ember'`

ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']

  hideAccepted: true

  searchResults: Ember.computed.oneWay('arrangedContent')

  filteredContent: Ember.observer('model', 'hideAccepted', 'page', ->
    searchInput = @get('model')
    if !searchInput or !@get('hideAccepted')
      @set 'searchResults', @get("arrangedContent")
    else
      @set 'searchResults', @get("arrangedContent").filter((item)-> !item.get('isAccepted'))
    return
  )

  actions:
    toggleAccepted: ->
      @set 'hideAccepted', !(@get('hideAccepted'))

  queryParams: ['page']
  pageBinding: 'content.page'
  page: 1


`export default ProjectCommitsController`
