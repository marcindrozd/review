module 'admin users page',
  setup: ->
    Review.buildRegistry()
    Review.reset()

    Ember.run ->
      Review.User.FIXTURES = [
        {
          admin: true, id: 'me'
        },
        {
          id: 5
          image_url: "adas1.jpg"
          name: "mariusz"
          nickname: "mariuszDusielak"
          admin: true
          permissions: [1,2]
        }
      ]
      Review.Project.FIXTURES = [
        {
          id: 1
          name: 'firstP'
          grade: "grade1"
          permission: [1]
        },
        {
          id: 2
          name: 'SecondP'
          grade: "grade2"
          permission: [2]
        }
      ]
      Review.Permission.FIXTURES = [
        {
        id: 1
        user_id: 5
        project_id: 1
        allowed: true
        },
        {
          id: 2
          user_id: 5
          project_id: 2
          allowed: true
        }
      ]

test "displays a table with user", ->
  visit '/admin/users'
  andThen ->
    ok find("tr.user").length == 1, "user"

test "displays a table with projects", ->
  visit '/admin/users'
  andThen ->
    ok find("th.project").length == 2, "projects"

test "displays a table with permissions", ->
  visit '/admin/users'
  andThen ->
    ok find('.permissions').length == 2, "permissions"

test "displays links to allow access", ->
  visit '/admin/users'
  andThen ->
    ok find("a:contains('Allow')").length == 2, "Allow access"

test "doesn't show a link to deny access", ->
  visit '/admin/users'
  andThen ->
    ok find("a:contains('Deny')").length == 0, "Deny access"
