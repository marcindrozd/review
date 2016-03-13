import DS from 'ember-data';
var ObjectTransform;

ObjectTransform = DS.Transform.extend({
  deserialize(serialized) {
    return serialized;
  },
  serialize(deserialized) {
    return deserialized;
  }
});

export default ObjectTransform;
