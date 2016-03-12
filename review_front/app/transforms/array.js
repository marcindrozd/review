import DS from 'ember-data';
var ArrayTransform;

ArrayTransform = DS.Transform.extend({
  deserialize: function(value) {
    if (Ember.isArray(value)) {
      return Em.A(value);
    } else {
      return Em.A();
    }
  },
  serialize: function(value) {
    if (Ember.isArray(value)) {
      return Em.A(value);
    } else {
      return Em.A();
    }
  }
});

export default ArrayTransform;
