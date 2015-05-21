module 'rendering main template',
  setup: ->
    Review.registry = Review.buildRegistry()
    Review.reset()

test "main template is rendered", ->
  visit '/'

  andThen ->
    ok find('.navbar-header').length, 'expected main template to be rendered'
