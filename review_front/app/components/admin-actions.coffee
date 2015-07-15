`import Ember from 'ember'`

AdminActions = Ember.Component.extend
  tagName: 'td'

  notMyProfile: Ember.computed('currentUserId', 'user', ->
    @get('user').get('id') != @get('currentUserId')
  )

`export default AdminActions`
