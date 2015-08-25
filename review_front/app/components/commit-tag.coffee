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
      @set('tagNames', '')

  createTagsArray: (commit, tags)->
    currentTags = commit.get('tag')
    addedTags = tags.split(',')

    @uniqueTags(currentTags.concat(addedTags))

  uniqueTags: (tags) ->
    unique = []
    i = 0

    while i < tags.length
      if unique.indexOf(tags[i]) == -1
        unique.push tags[i]
      i++

    unique

`export default CommitTag`
