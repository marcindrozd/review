`import Ember from 'ember'`

CopyToClipboard = Ember.Component.extend
  attributeBindings: [
    'title'
    'data-clipboard-text'
    'data-clipboard-target'
  ]
  title: 'Copy to clipboard'
  tagName: 'button'
  classNames: ['btn', 'btn-default', 'btn-xs', 'copy-to-clipboard']
  justCopied: false

  justCopiedToggle: ->
    @set 'justCopied', !@justCopied
  didInsertElement: ->
    client = new ZeroClipboard(@get('element'), moviePath: "http://coderberry.me/assets/ZeroClipboard/ZeroClipboard.swf")
    #bind aftercopy to an ember event
    client.on 'aftercopy', ((event) ->
      @justCopiedToggle()
      Ember.run.later @, (->
        @justCopiedToggle()
      ), 1500
      return
    ).bind(this)
    return
  'data-clipboard-text': (->
    @get 'text'
  ).property('text')
  'data-clipboard-target': (->
    @get 'cbTarget'
  ).property('cbTarget')


`export default CopyToClipboard`
