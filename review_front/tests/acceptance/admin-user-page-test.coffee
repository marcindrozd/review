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
    click('.navbar-left a:eq(2)')
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()

test 'visiting /admin-user-page', (assert) ->
  assert.equal currentURL(), '/admin/users'

test "displays a table with user", (assert) ->
  assert.equal find(".admin-users__row").length, 2

test "after clicking on projects, drects to projects", (assert) ->
  click(".navbar-left a:eq(0)")
  andThen ->
    assert.equal currentPath(), 'projects.index'
