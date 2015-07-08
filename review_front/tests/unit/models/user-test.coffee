`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'user', {
  # Specify the other units that are required for this test.
  needs: ['model:author', 'model:project', 'model:role']
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
