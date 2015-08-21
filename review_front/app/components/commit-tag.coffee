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

      commit.set('tag', @createTagsArray(commit, tagNames)).save()
      @toggleProperty('displayForm')

  createTagsArray: (commit, tags)->
    commit.get('tag').contact(tags.split(','))

`export default CommitTag`
