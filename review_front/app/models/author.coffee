`import DS from 'ember-data'`

Author = DS.Model.extend
  name: DS.attr('string')
  imageUrl: DS.attr('string')

`export default Author`
