`import DS from 'ember-data'`

Permission = DS.Model.extend
  allowed: DS.attr('boolean')
  user: DS.belongsTo('user')
  project: DS.belongsTo('project')

  isAllowed: Ember.computed 'allowed', ->
    @get('allowed') == true

`export default Permission`
