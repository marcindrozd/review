`import Ember from 'ember'`
`import pagedArray from 'ember-cli-pagination/computed/paged-array'`

ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']

  hideAccepted: true


  searchFilter: Ember.computed 'model', 'hideAccepted', 'page', ->
    if @get('hideAccepted') == false
      @get('model')
    else
      @get('model').filterProperty('isAccepted', false)

  actions:
    toggleAccepted: ->
      @toggleProperty('hideAccepted')

  pagedContent: pagedArray('searchFilter', perPage: 25)

  queryParams: ['page']
  pageBinding: 'pagedContent.page'
  perPageBinding: 'pagedContent.perPage'
  totalPagesBinding: 'pagedContent.totalPages'
  page: 1


`export default ProjectCommitsController`
