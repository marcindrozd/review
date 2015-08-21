`import Ember from 'ember'`

ProjectsIndexController = Ember.Controller.extend
  queryParams: ['page']
  pageBinding: 'content.page'
  perPageBinding: 'content.perPage'
  totalPagesBinding: 'content.totalPages'

  page: 1
  perPage: 25

  actions:
    searchInputChanged: (value)->
      console.log(value)

`export default ProjectsIndexController`
