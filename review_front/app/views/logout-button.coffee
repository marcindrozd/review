`import Ember from 'ember'`

LogoutButton = Ember.View.extend
  tagName: 'button'
  click: ->
    $.post '/auth/signout', _method: 'delete', (data, status, xhr)->
      location = xhr.getResponseHeader('Location')
      window.location = location

`export default LogoutButton`
