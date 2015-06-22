`import DS from 'ember-data'`

Project = DS.Model.extend {
  name: DS.attr('string')
  rejected: DS.attr('number')
  pending: DS.attr('number')
  accepted: DS.attr('number')
  total: DS.attr('number')
  grade: DS.attr('string')
  token: DS.attr('string')
  url: DS.attr('string')
  permission: DS.hasMany('permission', { async: true} )

  reviewIsGood: Ember.computed('grade', ->
    @get('grade') == 'good'
  )
}

`export default Project`
