import Ember from 'ember';
var Controller;

Controller = Ember.Controller.extend({
  errorMessage: Ember.computed.any('model.message', 'model.responseText')
});

export default Controller;
