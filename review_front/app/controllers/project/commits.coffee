`import Ember from 'ember'`

ProjectCommitsController = Ember.ArrayController.extend

  hideAccepted: true

  searchResults: Ember.computed 'page', 'hideAccepted', 'model', ->
    searchInput = null
    @get("model").then (model) =>
      searchInput = model
    if !searchInput or !(@get('hideAccepted'))
      @get("arrangedContent")
    else
      @get("arrangedContent").filter((item)-> !item.get('isAccepted'))

  actions:
    toggleAccepted: ->
      @set 'hideAccepted', !@get('hideAccepted')

  getSearchInput: ->
    @get("model").then (model) =>
      searchInput = model
      return searchInput

  queryParams: ['page']
  pageBinding: 'content.page'
  page: null



`export default ProjectCommitsController`
