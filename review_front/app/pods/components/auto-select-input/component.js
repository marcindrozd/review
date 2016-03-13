import Ember from 'ember';
var AutoSelectInput;

AutoSelectInput = Ember.TextField.extend({
  attributeBindings: ['readonly', 'size'],
  readonly: true,
  size: 44,
  mouseUp() {
    return this.$().select();
  }
});

export default AutoSelectInput;
