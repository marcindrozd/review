import Ember from 'ember';

export default Ember.TextField.extend({
  attributeBindings: ['readonly', 'size'],
  readonly: true,
  size: 44,
  mouseUp() {
    return this.$().select();
  }
});
