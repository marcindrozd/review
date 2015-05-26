`import Ember from 'ember'`

NavViewView = Ember.View.extend
  tagName: 'li'
  classNameBindings: ['active']
  active: Ember.computed.alias('childViews.firstObject.active')


`export default NavViewView`
