`import Ember from 'ember'`

UsersIndexController = Ember.Controller.extend
  queryParams: ['page', 'query']
  pageBinding: "users.page",
  perPageBinding: "users.perPage",
  totalPagesBinding: "users.totalPages",

  projects: Ember.computed.alias('model.projects')
  users: Ember.computed.alias('model.users')
  currentUserId: Ember.computed.alias('model.currentUserId')

  page: 1
  perPage: 25
  query: ""

  actions:
    searchInputChanged: (value)->
      @set("page", 1)
      @set("query", value)

`export default UsersIndexController`
