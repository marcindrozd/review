module 'navigation bar',
  setup: ->
    Review.buildRegistry()
    Review.reset()
    Ember.run ->
      Review.User.reopenClass({
        FIXTURES: [
          {
            admin: true
            id: "me"
          }
        ]
      })

test "shows a link to Projects", ->
  visit '/'

  andThen ->
    ok find("a:contains('Projects')").length, "should have a link to Projects"

test "shows a link to admin, if user is admin", ->

  visit '/'

  andThen ->
    ok find("a:contains('Admin')").length, "should have a link to Admin panel"

# test "doesn't show a link to admin if user is not and admin", ->

#   visit '/'

#   andThen ->
#     ok find("a:contains('Admin')").length == 0, "should not have a link to Admin panel"
