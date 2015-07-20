`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @resource 'projects', ->
    @resource 'project', path: '/:name', ->
      @route 'commits'
  @resource 'tickets', ->
    @resource 'ticket', path: '/:ticket_id', ->
      @route 'commits'
  @resource 'admin', ->
    @resource 'invitations', ->
      @route 'new'
    @resource 'users', ->
      @route 'user', path: '/:nickname'

`export default Router`
