`import Ember from 'ember'`

LogoutButtonViewView = Ember.View.extend
  tagName: 'button'
  click: ->
    $.post '/auth/signout', _method: 'delete', (data, status, xhr)->
      location = xhr.getResponseHeader('Location')
      window.location = location

`export default LogoutButtonViewView`
