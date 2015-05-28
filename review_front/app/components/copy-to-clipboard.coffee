`import Ember from 'ember'`

CopyToClipboard = Ember.Component.extend
  tagName: 'button'
  classNames: ['btn', 'btn-default', 'btn-xs', 'copy-to-clipboard']

  justCopied: false
  notificationClearDelay: 1500

  text: ''

  bindCopyButton: (()->
    @setupClipboard()
    @get('clip').on 'dataRequested', (client, args)=>
      client.setText(@get('text'))
      @triggerCopiedNotification()
  ).on('didInsertElement')

  unbindCopyButton: (()->
    @get('clip').destroy()
  ).on('willClearRender')

  setupClipboard: ()->
    clip = new ZeroClipboard(@get('element'))
    @set('clip', clip)

  triggerCopiedNotification: ()->
    @set('justCopied', true)
    callback = (=> @set('justCopied', false))
    setTimeout callback, @get('notificationClearDelay')

`export default CopyToClipboard`
