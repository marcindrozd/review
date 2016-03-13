import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'li',
  classNameBindings: 'active',
  active: Ember.computed('childViews.@each.active', function() {
    return this.get('childViews').isAny('active');
  })
});
