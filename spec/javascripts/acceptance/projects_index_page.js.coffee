module 'projects index page',
  beforeEach: ->
  setup: ->
    Review.buildRegistry()
    Review.reset()

    Ember.run ->
      Review.User.reopenClass({
        FIXTURES: [
          {
            admin: true
            id: "me"
          },
          {
            id: 5
            image_url: "adas1.jpg"
            name: "mariusz"
            nickname: "mariuszDusielak"
            admin: true
            permission_ids: [1,2]
          },
        ]
      })
      Review.Project.reopenClass({
        FIXTURES: [
          {
            id: 1
            accepted: 1
            rejected: 2
            pending: 3
            total: 6
            name: "firstProject"
            grade: "good"
            permission: [1]
          },
          {
            id: 2
            name: "secondProject"
            grade: "grade2"
            permission: [2]
          }
        ]
      })
      Review.Commit.reopenClass({
        FIXTURES: [
          {
            id: 1
            authored_at: "2013-09-12T17:09:27.000Z"
            created_at: "2015-05-14T12:13:31.537Z"
            expires_at: "2015-05-16T12:13:31.540Z"
            fix_ids: []
            fixed_ids: []
            id: 1
            message: "add Konf 55e5a7b12d413ea605dda91b5911d5a27cafdfd6"
            project_id: 1
            remote_id: "2222222222222222222222222222222222222222"
            state: "pending"
            ticket_ids: [1]
          }
        ]
      })
      Review.Author.reopenClass({
        FIXTURES:[
          id: 1
          image_url: "http://www.gravatar.com/avatar/566bb0159f81b9bcc68aa94d79c94e77"
          name: "John Kovalsky"
        ]
      })
      Review.Permission.reopenClass({
        FIXTURES: [
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
      })
test "displays table with projects", ->
  visit '/projects'
  andThen ->
    equal(find('.table-bordered a:first').text(), 'firstProject')
    equal(find('.table-bordered a:last').text(), 'secondProject')

test "click on project name directs to commits", ->
  visit '/projects'
  andThen ->
    click(".table-bordered a:last")
    andThen ->
      equal(currentPath(), 'projects.project.commits')

test "click on Admin in nav bar directs to admin", ->
  visit '/projects'
  click('.navbar-left a:last')
  andThen ->
    equal(currentPath(), 'admin.users')

test "checks correct values for project", ->
  findFirstProjectRejected = ->
    find(".table-bordered tr:eq(1) td:eq(1)").text()

  findFirstProjectPending = ->
    find(".table-bordered tr:eq(1) td:eq(2)").text()

  findFirstProjectAccepted = ->
    find(".table-bordered tr:eq(1) td:eq(3)").text()

  findFirstProjectTotal = ->
    find(".table-bordered tr:eq(1) td:eq(4)").text()

  findFirstProjectStatus = ->
    find(".table-bordered tr:eq(1) td:eq(5)").text()

  visit '/projects'
  andThen ->
    equal(findFirstProjectRejected(), '2')
    equal(findFirstProjectPending(), '3')
    equal(findFirstProjectAccepted(), '1')
    equal(findFirstProjectTotal(), '6')
    equal(findFirstProjectStatus(), 'good')
