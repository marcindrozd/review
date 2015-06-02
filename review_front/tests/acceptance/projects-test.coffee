`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`
`import Server from '../mocks/server'`

application = null
server = null

module 'Acceptance: Projects',
  beforeEach: ->
    application = startApp()
    server = Server.create()
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()
    return

test 'visiting /projects', (assert) ->
  visit '/'

  andThen ->
    assert.equal currentURL(), '/projects'
