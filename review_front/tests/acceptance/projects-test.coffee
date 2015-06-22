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
    visit '/projects'
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()
    return

test 'visiting /projects', (assert) ->
  assert.equal currentPath(), 'projects.index'

test 'displays table with projects', (assert) ->
  assert.equal find('.table-bordered tr:eq(1) a:first').text(), 'firstProject'
  assert.equal find('.table-bordered tr:eq(2) a:first').text(), 'secondProject'

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
    find(".table-bordered tr:eq(1) td:eq(5) .glyphicon.glyphicon-ok.text-success")

  assert.equal findFirstProjectRejected(), '2'
  assert.equal findFirstProjectPending(), '6'
  assert.equal findFirstProjectAccepted(), '1'
  assert.equal findFirstProjectTotal(), '10'
  assert.equal findFirstProjectStatus().length, 1

test "find github links", (assert) ->
  assert.equal find(".glyphicon.glyphicon-link").length, 2
