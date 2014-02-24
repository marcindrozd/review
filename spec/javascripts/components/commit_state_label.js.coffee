module 'commit state label component',
  setup: -> @component = new Review.CommitStateLabelComponent()

test "'reviewState' has a default value", ->
  ok @component.get('reviewState') == 'unknown', "should have a value of 'unknown'"

test 'uses default label style when unrecognized state provided', ->
  ok @component.get('labelClass') == 'label-default', "should have a class of 'label-default'"

test 'has a specific label style for accepted state', ->
  @component.set('reviewState', 'accepted')
  ok @component.get('labelClass') == 'label-success', "should have a class of 'label-success'"

test 'has a specific label style for pending state', ->
  @component.set('reviewState', 'pending')
  ok @component.get('labelClass') == 'label-info', "should have a class of 'label-info'"

test 'has a specific label style for passed state', ->
  @component.set('reviewState', 'passed')
  ok @component.get('labelClass') == 'label-warning', "should have a class of 'label-warning'"

test 'has a specific label style for rejected state', ->
  @component.set('reviewState', 'rejected')
  ok @component.get('labelClass') == 'label-danger', "should have a class of 'label-danger'"
