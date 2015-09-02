`import DS from 'ember-data'`

Author = DS.Model.extend
  username: DS.attr('string')
  name: DS.attr('string')
  imageUrl: DS.attr('string')

`export default Author`
