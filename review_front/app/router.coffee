`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @resource 'projects', ->
    @resource 'project', path: '/:project_id'

`export default Router;`

