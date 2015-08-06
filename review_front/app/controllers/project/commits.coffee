`import Ember from 'ember'`
`import pagedArray from 'ember-cli-pagination/computed/paged-array'`

ProjectCommitsController = Ember.ArrayController.extend
  sortProperties: ['authoredAt']

  hideAccepted: true
  queryParams: ['page', 'q']
  pageBinding: 'content.page'
  perPageBinding: 'content.perPage'
  totalPagesBinding: 'content.totalPages'
  page: 1
  q: { state_not_in: ['accepted'] }

  actions:
    toggleAccepted: ->
      @toggleProperty('hideAccepted')
      if @get('hideAccepted') == false
        @transitionTo(queryParams:{q: null, page: @page })
      else
        @transitionTo(queryParams:{q: state_not_in: ['accepted'], page: @page})

`export default ProjectCommitsController`
