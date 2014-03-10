Review.CommitsTableComponent = Ember.Component.extend
  tagName:    'article'
  classNames: ['commits']
  page:           1
  perPage:        10

  hideAccepted: true

  filteredContent: (->
    content = @get('commits.content')
    return content if !content or !@get('hideAccepted')
    content.filter((item)-> item.get('state') != 'accepted')
  ).property('commits.content.[]', 'hideAccepted')

  paginatedContent: (->
    page    = @get('page')
    perPage = @get('perPage')
    start   = (page - 1) * perPage
    end     = page * perPage

    @get('filteredContent').slice(start, end)
  ).property('filteredContent.[]', 'page', 'perPage')

  pages: (->
    result = parseInt(@get('commits.filteredContent.length') / @get('perPage'))
    ++result if @get('commits.filteredContent.length') % @get('perPage') > 0

    result
  ).property('filteredContent.[]', 'perPage')
