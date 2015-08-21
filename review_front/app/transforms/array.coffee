`import DS from 'ember-data'`

ArrayTransform = DS.Transform.extend
  deserialize: (value) ->
    if Ember.isArray(value)
      Em.A value
    else
      Em.A()

  serialize: (value) ->
    if Ember.isArray(value)
      Em.A value
    else
      Em.A()

`export default ArrayTransform`
