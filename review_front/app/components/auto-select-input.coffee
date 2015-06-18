`import Ember from 'ember'`

AutoSelectInput = Ember.TextField.extend
  attributeBindings: ['readonly']
  readonly: true

  mouseUp: ->
    @$().select()

`export default AutoSelectInput`
