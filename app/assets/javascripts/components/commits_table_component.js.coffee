Review.CommitsTableComponent = Ember.Component.extend
  tagName:    'article'
  classNames: ['commits']

  hideAccepted: true

  filteredContent: (->
    content = @get('commits')
    return content if !content or !@get('hideAccepted')
    content.filter((item)-> item.get('state') != 'accepted')
  ).property('commits.[]', 'hideAccepted')
