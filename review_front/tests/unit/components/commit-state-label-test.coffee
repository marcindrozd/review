`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'commit-state-label', {
  # Specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
}

test 'it renders', (assert) ->
  assert.expect 2

  # Creates the component instance
  component = @subject()
  assert.equal component._state, 'preRender'

  # Renders the component to the page
  @render()
  assert.equal component._state, 'inDOM'

test "'reviewState' has a default value", (assert) ->
  ok @subject().get('reviewState') == 'unknown', "should have a value of 'unknown'"

test 'uses default label style when unrecognized state provided', ->
  ok @subject().get('labelClass') == 'label-default', "should have a class of 'label-default'"

test 'has a specific label style for accepted state', ->
  @subject().set('reviewState', 'accepted')
  ok @subject().get('labelClass') == 'label-success', "should have a class of 'label-success'"

test 'has a specific label style for pending state', ->
  @subject().set('reviewState', 'pending')
  ok @subject().get('labelClass') == 'label-info', "should have a class of 'label-info'"

test 'has a specific label style for passed state', ->
  @subject().set('reviewState', 'passed')
  ok @subject().get('labelClass') == 'label-warning', "should have a class of 'label-warning'"

test 'has a specific label style for rejected state', ->
  @subject().set('reviewState', 'rejected')
  ok @subject().get('labelClass') == 'label-danger', "should have a class of 'label-danger'"
