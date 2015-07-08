`import DS from 'ember-data'`

Role = DS.Model.extend {
  name: DS.attr('string')
  resourceId: DS.attr('number')
  resourceType: DS.attr('string')
}

`export default Role`
