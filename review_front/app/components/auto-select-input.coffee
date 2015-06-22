`import Ember from 'ember'`

AutoSelectInput = Ember.TextField.extend
  attributeBindings: ['readonly', 'size']
  readonly: true
  size: 40

  mouseUp: ->
    @$().select()

`export default AutoSelectInput`
