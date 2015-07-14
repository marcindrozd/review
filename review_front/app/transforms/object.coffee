`import DS from 'ember-data'`

ObjectTransform = DS.Transform.extend
  deserialize: (serialized) ->
    serialized

  serialize: (deserialized) ->
    deserialized

`export default ObjectTransform`
