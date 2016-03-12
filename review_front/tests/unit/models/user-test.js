import { test, moduleForModel } from 'ember-qunit';
moduleForModel('user', {
  needs: ['model:author', 'model:project', 'model:role']
});

test('it exists', function(assert) {
  var model;
  model = this.subject();
  return assert.ok(!!model);
});
