Review.CopyToClipboardComponent = Ember.Component.extend
  tagName: 'button'
  classNames: ['btn', 'btn-default', 'btn-xs', 'copy-to-clipboard']

  justCopied: false

  text: ''

  bindCopyButton: (()->
    @setupClipboard()
    @get('clip').on 'dataRequested', (client, args)=>
      client.setText(@get('text'))
      @set('justCopied', true)
  ).on('didInsertElement')

  unbindCopyButton: (()->
    @get('clip').destroy()
  ).on('willClearRender')

  setupClipboard: ()->
    clip = new ZeroClipboard(@get('element'))
    @set('clip', clip)
