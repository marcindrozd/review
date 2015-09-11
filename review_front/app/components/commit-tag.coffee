`import Ember from 'ember'`

CommitTag = Ember.Component.extend
  idEditing: false

  actions:
    displayTagsForm: ->
      @set('isEditing', true)

    createTag: ->
      tagNames = @get('tagNames')
      commit = @get('commit')

      return if tagNames == undefined || tagNames == ''

      commit.set('tag', @createTagsArray(commit, tagNames)).save()
      @set('isEditing', false)
      @set('tagNames', '')

    dropEdits: ->
      @set("isEditing", false)
      @set('tagNames', '')

    removeTag: (name) ->
      commit = @get('commit')
      currentTags = commit.get('tag')
      index = currentTags.indexOf(name)
      currentTags.splice(index)
      commit.set('tag', currentTags).save()

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
