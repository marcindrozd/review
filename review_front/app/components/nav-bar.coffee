`import Ember from 'ember'`

NavBar = Ember.Component.extend
  tagName: 'li'
  classNameBindings: ['active']
  active: Ember.computed.alias('childViews.firstObject.active')

`export default NavBar `
