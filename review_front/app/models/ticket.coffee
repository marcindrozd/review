`import DS from 'ember-data'`

Ticket = DS.Model.extend
  remoteId: DS.attr('string')
  remoteUrl: DS.attr('string')
  color: DS.attr('string')

  style: Ember.computed('color', ->
    "background-color: #{@get('color')}"
  )

`export default Ticket`
