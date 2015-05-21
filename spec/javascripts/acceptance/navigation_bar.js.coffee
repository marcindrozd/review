module 'navigation bar',
  setup: ->
    Review.registry = Review.buildRegistry()
    Review.reset()

test "shows a link to Projects", ->
  visit '/'

  andThen ->
    ok find("a:contains('Projects')").length, "should have a link to Projects"

test "shows a link to admin, if user is admin", ->

  Ember.run ->
    store.createRecord(admin: true, id: 'me')

  visit '/'

  andThen ->
    ok find("a:contains('Admin')").length, "should have a link to Admin panel"

test "doesn't show a link to admin if user is not and admin", ->

  Ember.run ->
    store.createRecord(admin: false, id: 'me')

  visit '/'

  andThen ->
    ok find("a:contains('Admin')").length == 0, "should not have a link to Admin panel"
