import { test, moduleForModel } from 'ember-qunit';
moduleForModel('project', {
  needs: ['model:user']
});

test('it exists', function(assert) {
  var model;
  model = this.subject();
  return assert.ok(!!model);
});
