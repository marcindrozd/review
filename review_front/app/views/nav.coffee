`import Ember from 'ember'`

Nav = Ember.View.extend
  tagName: 'li'
  classNameBindings: ['active']
  active: Ember.computed.alias('childViews.firstObject.active')

`export default Nav`
