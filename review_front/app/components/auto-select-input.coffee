`import Ember from 'ember'`

AutoSelectInput = Ember.TextField.extend
  attributeBindings: ['readonly', 'size']
  readonly: true
  size: 44

  mouseUp: ->
    @$().select()

`export default AutoSelectInput`
