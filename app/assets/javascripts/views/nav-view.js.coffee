Review.NavView = Ember.View.extend
  tagName: 'li'
  classNameBindings: ['active']
  active: Ember.computed.alias('childViews.firstObject.active')
