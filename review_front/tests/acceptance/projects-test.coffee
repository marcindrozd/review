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
    visit '/'
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()
    return

test 'visiting /projects', (assert) ->
    assert.equal currentURL(), '/projects'

test 'displays table with projects', (assert) ->
  assert.equal find('.table-bordered a:first').text(), 'firstProject'
  assert.equal find('.table-bordered a:last').text(), 'secondProject'

test "checks correct values for project", (assert) ->
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

  assert.equal(findFirstProjectRejected(), '2')
  assert.equal(findFirstProjectPending(), '6')
  assert.equal(findFirstProjectAccepted(), '1')
  assert.equal(findFirstProjectTotal(), '10')
  assert.equal(findFirstProjectStatus(), 'good')

test "find API key buttons", (assert) ->
  assert.equal find(".copy-to-clipboard").length, 2

