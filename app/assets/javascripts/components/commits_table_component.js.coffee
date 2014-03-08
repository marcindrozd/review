Review.CommitsTableComponent = Ember.Component.extend
  tagName:    'article'
  classNames: ['commits']
  page:           1
  perPage:        10

  paginatedContent: (->
    page    = @get('page')
    perPage = @get('perPage')
    start   = (page - 1) * perPage
    end     = page * perPage

    @get('commits.content').slice(start, end)
  ).property('arrangedContent.[]', 'page', 'perPage')

  pages: (->
    result = parseInt(@get('commits.content.length') / @get('perPage'))
    ++result if @get('commits.content.length') % @get('perPage') > 0

    result
  ).property('content.[]', 'perPage')
