`import Ember from 'ember'`
`import DS from 'ember-data'`
`import $ from 'jquery'`

Adapter = DS.ActiveModelAdapter.extend
  namespace: '/api/v2'
  headers: Ember.computed(->
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  ).volatile()

`export default Adapter`
