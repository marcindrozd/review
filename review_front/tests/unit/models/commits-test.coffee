`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'commits', {
  # Specify the other units that are required for this test.
  needs: ['project']
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
