import Ember from 'ember';
var Controller;

Controller = Ember.Controller.extend({
  errorMessage: Ember.computed.or('model.message', 'model.responseText')
});

export default Controller;
