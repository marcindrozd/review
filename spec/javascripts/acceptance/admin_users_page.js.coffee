module 'admin users page',
  setup: -> Review.reset()

test "displays a table with", ->

  Ember.run ->
    Review.User.createRecord(admin: true, id: 'me')

  visit '/admin/users'

  andThen ->
    ok find("tr.user").length == Review.User.FIXTURES.length, "users"
    ok find("th.project").length == Review.Project.FIXTURES.length, "projects"
    ok find('.permissions').length == 6, "permissions"

test "displays links to", ->

  Ember.run ->
    Review.User.createRecord(admin: true, id: 'me')

  visit '/admin/users'

  andThen ->
    ok find("a:contains('Allow')").length == 6, "Allow access"
    ok find("a:contains('Deny')").length == 0, "Deny access"


test "click on the allow link", ->

  Ember.run ->
    Review.User.createRecord(admin: true, id: 'me')

  visit '/admin/users'
  click "a.allow:first"

  andThen ->
    ok find("a:contains('Allow')").length == 5, "change count of allow links"
    ok find("a:contains('Deny')").length == 1, "change count of deny links"
