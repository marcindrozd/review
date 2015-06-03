`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`
`import Server from '../mocks/server'`

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

test 'after click on admin it trnsfers to admin page', (assert) ->
  click("a:contains('Admin')")
  andThen ->
    assert.equal currentPath(), 'admin.users'

test 'from adming page it transfers to projects after click on projects', (assert) ->
  click("a:contains('Admin')")
  andThen ->
    click("a:contains('Projects')")
    andThen ->
      assert.equal currentPath(), 'projects.index'


