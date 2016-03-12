import Ember from 'ember';
import DS from 'ember-data';
import $ from 'jquery';
var Adapter;

Adapter = DS.ActiveModelAdapter.extend({
  namespace: '/api/v2',
  headers: Ember.computed(function() {
    return {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    };
  }).volatile()
});

export default Adapter;
