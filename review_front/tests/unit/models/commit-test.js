import { test, moduleForModel } from 'ember-qunit';
moduleForModel('commit', {
  needs: ['model:project', 'model:author', 'model:user', 'model:role']
});

test('it exists', function(assert) {
  var model;
  model = this.subject();
  return assert.ok(!!model);
});
