import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'td',
  notMyProfile: Ember.computed('currentUserId', 'user.id', function() {
    return this.get('user.id') !== this.get('currentUserId');
  })
});
