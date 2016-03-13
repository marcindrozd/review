import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'button',
  classNames: 'btn btn-danger',
  click() {
    return Ember.$.post('/auth/signout', {
      _method: 'delete'
    }, function(data, status, xhr) {
      const location = xhr.getResponseHeader('Location');
      return window.location = location;
    });
  }
});
