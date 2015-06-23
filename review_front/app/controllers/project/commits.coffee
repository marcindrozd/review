`import Ember from 'ember'`

ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']

  hideAccepted: true

  searchResults: Ember.computed 'page', 'hideAccepted', ->
    if @get('hideAccepted') == false
      @get('model')
    else
      @get('model').filterProperty('isAccepted', false)

  actions:
    toggleAccepted: ->
      @set 'hideAccepted', !(@get('hideAccepted'))

  queryParams: ['page']
  pageBinding: 'content.page'
  page: 1


`export default ProjectCommitsController`
