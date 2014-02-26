Review.CopyToClipboardComponent = Ember.Component.extend
  tagName: 'button'
  classNames: ['btn', 'btn-default', 'btn-xs']

  text: ''

  bindCopyButton: (()->
    clip = new ZeroClipboard(@get('element'))
    clip.on 'complete', (client, args)=> client.setText(@get('text'))
  ).on('didInsertElement')
