import Ember from 'ember';
var DropdownItem;

DropdownItem = Ember.Component.extend({
  tagName: 'li',
  classNameBindings: 'active',
  active: Ember.computed('childViews.@each.active', function() {
    return this.get('childViews').isAny('active');
  })
});

export default DropdownItem;
