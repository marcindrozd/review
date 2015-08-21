`import Ember from 'ember'`

CommitTag = Ember.Component.extend
  tagName: 'div'

  actions:
    displayTagsForm: ->
      @toggleProperty('displayForm')

    createTag: ->
      tagNames = @get('tagNames')
      commit = @get('commit')

      return if tagNames == undefined || tagNames == ''

      commit.set('tags', @createTagsArray(tagNames)).save()
      @toggleProperty('displayForm')

  createTagsArray: (tags)->
    tags.split(',')

`export default CommitTag`
