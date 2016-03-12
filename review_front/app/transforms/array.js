import Ember from 'ember';
import DS from 'ember-data';
var ArrayTransform;

ArrayTransform = DS.Transform.extend({
  deserialize: function(value) {
    if (Ember.isArray(value)) {
      return Ember.A(value);
    } else {
      return Ember.A();
    }
  },
  serialize: function(value) {
    if (Ember.isArray(value)) {
      return Ember.A(value);
    } else {
      return Ember.A();
    }
  }
});

export default ArrayTransform;
