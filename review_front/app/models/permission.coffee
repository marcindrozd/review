`import DS from 'ember-data'`

Permission = DS.Model.extend {
  allowed: DS.attr('boolean')
  user: DS.belongsTo('user')
  project: DS.belongsTo('project')

  isAllowed: (()->
    @get('allowed') == true
  ).property('allowed')}

`export default Permission`
