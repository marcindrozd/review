`import Ember from 'ember'`

Component = Ember.Component.extend
  tagName: 'span'
  classNames: ['label']
  attributeBindings: ['style']

  style: Ember.computed "name", ->
    "background-color: #{ @get("color") };"

  toHash: (string)->
    hash = 0
    for idx in [0..(string.length - 1)]
      hash = string.charCodeAt(idx) + ((hash << 5) - hash)
    Math.abs(hash)

  toColor: (hash)->
    hex = hash.toString(16)
    hex += '000000'
    "##{ hex.substring(0, 6) }"

  color: Ember.computed "name", ->
    @toColor(@toHash(@get("name")))

  click: ->
    @sendAction("action", @get('name'))

`export default Component`
