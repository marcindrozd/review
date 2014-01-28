module 'rendering main template',
  setup: -> Review.reset()

test "if it works", ->
  visit '/'

  andThen ->
    ok find('.navbar-header').length, 'expected main template to be rendered'
