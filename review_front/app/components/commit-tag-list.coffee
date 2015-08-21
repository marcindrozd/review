`import Ember from 'ember'`

Component = Ember.Component.extend
  orderedTags: Ember.computed 'tags.[]', ->
    Ember.A(@get('tags').sort())

`export default Component`
