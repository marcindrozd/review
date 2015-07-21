`import Ember from 'ember'`

DropdownItem = Ember.Component.extend
  tagName: 'li'
  classNameBindings: 'active'

  active: Ember.computed('childViews.@each.active', ->
    @get('childViews').isAny('active')
  )

`export default DropdownItem`
