Review.PaginationLinksComponent = Em.Component.extend
  hasPrevious:    (-> @get('page') > 1).property('page')
  hasNext:        (-> @get('page') < @get('pages')).property('page', 'pages')
  showPagination: Em.computed.gt('pages', 1)
  lastPage:       Em.computed.alias('pages')

  visiblePages: (->

    pages = @get('pages')
    page  = @get('page')

    limit = 5
    limit = pages if pages < 5
    finish   = (start,limit)-> start + limit - 1

    start = page - parseInt(limit / 2)
    start = pages - limit + 1 if finish(start,limit) > pages
    start = 1 if start < 1

    [start..finish(start,limit)]
  ).property('page', 'pages')

  actions:
    goToNextPage: ->
      @incrementProperty('controller.page') if @get('hasNext')

    goToPreviousPage: ->
      @decrementProperty('controller.page') if @get('hasPrevious')

    goToPage: (pageNumber) ->
      @set('controller.page', pageNumber) if pageNumber >= 1 && pageNumber <= @get('pages')
