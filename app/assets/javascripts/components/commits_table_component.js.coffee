Review.CommitsTableComponent = Ember.Component.extend
  tagName:    'article'
  classNames: ['commits']
  page:           1
  perPage:        10

  hideAccepted: true

  filteredContent: (->
    content = @get('commits')
    return content if !content or !@get('hideAccepted')
    content.filter((item)-> item.get('state') != 'accepted')
  ).property('commits.[]', 'hideAccepted')

  paginatedContent: (->
    page    = @get('page')
    perPage = @get('perPage')
    start   = (page - 1) * perPage
    end     = page * perPage
    @get('filteredContent')
  ).property('commits.[]', 'page', 'perPage', 'hideAccepted')

  pages: (->
    result = parseInt(@get('filteredContent.length') / @get('perPage'))
    ++result if @get('filteredContent.length') % @get('perPage') > 0
    result
  ).property('content.[]', 'perPage', 'hideAccepted')
