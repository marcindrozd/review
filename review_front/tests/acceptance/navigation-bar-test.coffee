`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`
`import Server from '../mocks/server'`
`import ServerNoAdmin from '../mocks/server-no-admin'`

application = null
server = null

module 'Acceptance: NavigationBar',
  beforeEach: ->
    application = startApp()
    server = Server.create()
    visit '/'
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()

test 'navigation bar renders', (assert) ->
    assert.equal find('.navbar').length, 1

test 'shows link to projects page', (assert) ->
  assert.equal find("a:contains('Projects')").length, 1

test 'shows linkt to admin page if user is admin', (assert) ->
  assert.equal find("a:contains('Admin')").length, 1

test 'after click on users it trnsfers to admin users page', (assert) ->
  click("a:contains('Users')")
  andThen ->
    assert.equal currentPath(), 'admin.users.index'

test 'after click on invitations it trnsfers to admin invitations page', (assert) ->
  click("a:contains('Invitations')")
  andThen ->
    assert.equal currentPath(), 'admin.invitations.index'

test 'from admin page, it transfers to projects after click on projects', (assert) ->
  click("a:contains('Admin')")
  andThen ->
    click("a:contains('Projects')")
    andThen ->
      assert.equal currentPath(), 'projects.index'

test 'if user is not admin no admin link is shown', (assert) ->
  Ember.run application, 'destroy'
  server.shutdown()
  application = startApp()
  server = ServerNoAdmin.create()
  assert.equal find("a:contains('Admin')").length, 0
