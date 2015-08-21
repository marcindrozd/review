`import Ember from 'ember'`

Component = Ember.Component.extend
  orderedTags: Ember.computed 'tags.[]', ->
    Ember.A(@get('tags')?.sort())
  actions:
    filterByTag: (name)->
      @sendAction("filterByTag", name)

`export default Component`
