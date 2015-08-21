`import Ember from 'ember'`

Component = Ember.Component.extend
  tagName: 'span'
  classNames: ['label']
  attributeBindings: ['style']

  style: Ember.computed "name", ->
    "background-color: red;"

`export default Component`
