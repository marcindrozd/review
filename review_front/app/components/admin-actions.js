import Ember from 'ember';
var AdminActions;

AdminActions = Ember.Component.extend({
  tagName: 'td',
  notMyProfile: Ember.computed('currentUserId', 'user', function() {
    return this.get('user').get('id') !== this.get('currentUserId');
  })
});

export default AdminActions;
