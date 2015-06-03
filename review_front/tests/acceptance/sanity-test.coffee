`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`
`import Server from '../mocks/server'`

application = null
server = null

module 'Acceptance: Sanity',
  beforeEach: ->
    application = startApp()
    server = Server.create()
    visit '/'
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()
    return

test 'main template is rendering', (assert) ->
  assert.equal find('.navbar-header').length, 1
