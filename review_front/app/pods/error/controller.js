import Ember from 'ember';

export default Ember.Controller.extend({
  errorMessage: Ember.computed.or('model.message', 'model.responseText')
});
