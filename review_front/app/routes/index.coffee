`import Ember from 'ember'`

ApplicationIndex = Ember.Route.extend
  redirect: ->
    @transitionTo('projects')

`export default ApplicationIndex`
