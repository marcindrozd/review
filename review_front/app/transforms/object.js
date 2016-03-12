import DS from 'ember-data';
var ObjectTransform;

ObjectTransform = DS.Transform.extend({
  deserialize: function(serialized) {
    return serialized;
  },
  serialize: function(deserialized) {
    return deserialized;
  }
});

export default ObjectTransform;
