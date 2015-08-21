`import Ember from 'ember'`

Component = Ember.Component.extend
  search: ""
  onSearchChange: Ember.observer "search", ->
    Ember.run.debounce(this, @processSearchChange, 200)

  processSearchChange: ->
    @sendAction("action", @get("search"))

`export default Component`
