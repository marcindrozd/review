`import Ember from 'ember'`

ProjectsIndexController = Ember.Controller.extend

  queryParams: ['page', 'perPage', 'pageNumber']
  pageBinding: 'content.page'
  perPageBinding: 'content.perPage'

  page: 1
  perPage: 25

`export default ProjectsIndexController`
