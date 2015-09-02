`import Ember from 'ember'`
`import pagedArray from 'ember-cli-pagination/computed/paged-array'`

ProjectCommitsController = Ember.Controller.extend
  sortProperties: ['authoredAt']
  commits: Ember.computed.alias('model.commits')
  currentUser: Ember.computed.alias('model.currentUser')
  project: Ember.computed.alias('model.project')

  hideAccepted: true
  queryParams: ['page', 'q', 'tag']
  pageBinding: 'commits.page'
  perPageBinding: 'commits.perPage'
  totalPagesBinding: 'commits.totalPages'
  page: 1
  tag: ""
  q: { state_not_in: ['accepted','fixed'] }

  actions:
    toggleAccepted: ->
      @toggleProperty('hideAccepted')
      if @get('hideAccepted') == false
        @transitionTo(queryParams:{q: null, page: @page })
      else
        @transitionTo(queryParams:{q: state_not_in: ['accepted','fixed'], page: @page})
    filterByTag: (name) ->
      console.log name

`export default ProjectCommitsController`
