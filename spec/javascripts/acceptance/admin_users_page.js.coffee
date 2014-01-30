module 'admin users page',
  setup: -> Review.reset()

test "displays a table with", ->

  Ember.run ->
    Review.User.createRecord(admin: true, id: 'me')

  visit '/admin/users'

  andThen ->
    ok find("tr.user").length == 2, "users"
    ok find("th.project").length == 3, "projects"
    ok find('.permissions').length == 6, "permissions"
