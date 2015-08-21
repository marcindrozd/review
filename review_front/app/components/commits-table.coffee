`import Ember from 'ember'`

CommitsTable = Ember.Component.extend
  tagName:    'article'
  classNames: ['commits-table']
  actions:
    filterByTag: (name)->
      @sendAction('filterByTag', name)

`export default CommitsTable`
