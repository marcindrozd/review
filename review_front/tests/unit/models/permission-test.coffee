`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'permission', {
  # Specify the other units that are required for this test.
  needs: ['model:user', 'model:project', 'model:author']
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
