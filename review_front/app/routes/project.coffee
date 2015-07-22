`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

Project = Ember.Route.extend RouteMixin,

  model: (params)->
    @store.find('project', { name:  params.name })
      .then (project)->
        project.get("firstObject")


  setupController: (controller, model) ->
    controller.set('model', model.get("firstObject"))

`export default Project`
