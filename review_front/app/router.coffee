`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @resource 'projects', ->
    @resource 'project', path: '/:project_id', ->
      @route 'commits'
  @resource 'tickets', ->
    @resource 'ticket', path: '/:ticket_id', ->
      @route 'commits'
  @resource 'admin', ->
    @route 'users'


`export default Router`

