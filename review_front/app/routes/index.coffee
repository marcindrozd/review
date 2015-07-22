`import Ember from 'ember'`

ApplicationIndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo('projects')

`export default ApplicationIndexRoute`
