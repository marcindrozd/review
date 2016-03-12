import { test, moduleForModel } from 'ember-qunit';
moduleForModel('ticket', {
  needs: []
});

test('it exists', function(assert) {
  var model;
  model = this.subject();
  return assert.ok(!!model);
});
