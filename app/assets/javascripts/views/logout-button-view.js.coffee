Review.LogoutButtonView = Ember.View.extend
  tagName: 'button'
  click: ->
    $.post '/auth/signout', _method: 'delete', (data, status, xhr)->
      location = xhr.getResponseHeader('Location')
      window.location = location
