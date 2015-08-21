`import Ember from 'ember'`

CommitTag = Ember.Component.extend
  tagName:    'div'
  displayForm: false

  actions:
    displayTagsForm: ->
      @toggleProperty('displayForm')

`export default CommitTag`
