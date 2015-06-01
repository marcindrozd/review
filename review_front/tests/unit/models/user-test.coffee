`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'user', {
  # Specify the other units that are required for this test.
  needs: ['model:permission', 'model:author', 'model:project']
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
