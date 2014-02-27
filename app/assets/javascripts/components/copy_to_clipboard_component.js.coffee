Review.CopyToClipboardComponent = Ember.Component.extend
  tagName: 'button'
  classNames: ['btn', 'btn-default', 'btn-xs', 'copy-to-clipboard']

  text: ''

  bindCopyButton: (()->
    @setupClipboard()
    @get('clip').on 'dataRequested', (client, args)=> client.setText(@get('text'))
  ).on('didInsertElement')

  unbindCopyButton: (()->
    @get('clip').destroy()
  ).on('willClearRender')

  setupClipboard: ()->
    clip = new ZeroClipboard(@get('element'))
    @set('clip', clip)
