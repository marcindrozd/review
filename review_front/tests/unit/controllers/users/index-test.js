import { test, moduleFor } from 'ember-qunit';
moduleFor('controller:users/index', {});

test('it exists', function(assert) {
  var controller;
  controller = this.subject();
  return assert.ok(controller);
});
