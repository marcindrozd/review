import { test, moduleFor } from 'ember-qunit';
moduleFor('controller:project/commits', {});

test('it exists', function(assert) {
  var controller;
  controller = this.subject();
  return assert.ok(controller);
});
