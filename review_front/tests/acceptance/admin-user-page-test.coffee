`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`
`import Server from '../mocks/server'`

application = null
server = null

module 'Acceptance: AdminUserPage',
  beforeEach: ->
    application = startApp()
    server = Server.create()
    visit '/'
    click('.navbar-left a:last')
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()

test 'visiting /admin-user-page', (assert) ->
  assert.equal currentURL(), '/admin/users'

test "displays a table with user", (assert) ->
  assert.equal find("tr.user").length, 2

test "displays a table with projects", (assert) ->
  assert.equal find("th.project").length, 2

test "displays a table with permissions", (assert) ->
  assert.equal find('.permissions').length, 4

test "displays links to allow access", (assert) ->
  andThen ->
    assert. equal find("a:contains('Allow')").length, 4

test "doesn't show a link to deny access", (assert) ->
  assert.equal find("a:contains('Deny')").length, 0

test "after clicking on projects, drects to projects", (assert) ->
  click(".navbar-left a:eq(0)")
  andThen ->
    assert.equal currentPath(), 'projects.index'
