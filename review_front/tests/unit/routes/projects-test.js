import { test, moduleFor } from 'ember-qunit';
moduleFor('route:projects', {});

test('it exists', function(assert) {
  var route;
  route = this.subject();
  return assert.ok(route);
});
