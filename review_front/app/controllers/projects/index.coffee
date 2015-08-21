`import Ember from 'ember'`

ProjectsIndexController = Ember.Controller.extend
  queryParams: ['page', 'query']
  pageBinding: 'model.page'
  perPageBinding: 'model.perPage'
  totalPagesBinding: 'model.totalPages'

  page: 1
  perPage: 25
  query: ""

  actions:
    searchInputChanged: (value)->
      @set("query", value)

`export default ProjectsIndexController`
