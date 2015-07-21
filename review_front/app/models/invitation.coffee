`import DS from 'ember-data'`

Invitation = DS.Model.extend {
  email: DS.attr('string')
  role: DS.attr('string')
  projectIds: DS.attr('object')
}

`export default Invitation`
