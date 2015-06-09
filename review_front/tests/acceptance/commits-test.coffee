`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`
`import Server from '../mocks/server'`

application = null
server = null

module 'Acceptance: ProjectCommits',
  beforeEach: ->
    application = startApp()
    server = Server.create()
    visit = '/project/1/commits'
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()
    return

test 'find pagination button', (assert) ->
  assert.ok find('.pagination')

test 'find correct page nameber', (assert) ->
  assert.ok find('.pagination li:class("Active")')
  assert.ok find('.pagination a:contains("1")')
