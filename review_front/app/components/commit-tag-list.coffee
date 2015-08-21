`import Ember from 'ember'`

Component = Ember.Component.extend
  orderedTags: Ember.computed 'tags.[]', ->
    Ember.A(@get('tags')?.sort())
  actions:
    action: (name)->
      @sendAction("action", name)

`export default Component`
