import Ember from 'ember';
var LogoutButton;

LogoutButton = Ember.Component.extend({
  tagName: 'button',
  classNames: 'btn btn-danger',
  click() {
    return Ember.$.post('/auth/signout', {
      _method: 'delete'
    }, function(data, status, xhr) {
      var location;
      location = xhr.getResponseHeader('Location');
      return window.location = location;
    });
  }
});

export default LogoutButton;
