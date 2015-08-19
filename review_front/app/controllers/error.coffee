`import Ember from 'ember'`

Controller = Ember.Controller.extend
  errorMessage: Ember.computed.any('model.message', 'model.responseText')

`export default Controller`
