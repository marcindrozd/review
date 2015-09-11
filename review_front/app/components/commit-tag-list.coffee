`import Ember from 'ember'`

Component = Ember.Component.extend
  classNames: "commit-tag-list"
  orderedTags: Ember.computed 'tags.[]', ->
    Ember.A(@get('tags')?.sort())

  actions:
    removeTag: (name) ->
      @sendAction("action", name)

`export default Component`
