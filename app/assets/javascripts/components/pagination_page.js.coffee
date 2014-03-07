Review.PaginationPageComponent = Ember.Component.extend
  isCurrent: (-> @get('currentPage') == @get('page')).property('currentPage', 'page')
  tagName: 'li'
  classNameBindings: 'isCurrent:disabled'

  actions:
    pageClicked: ->
      @get('parentView').send('goToPage', @get('page'))
