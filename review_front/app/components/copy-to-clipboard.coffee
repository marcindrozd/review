`import Ember from 'ember'`
`import ZeroClipboard from 'ember-cli-zero-clipboard/components/zero-clipboard'`

CopyToClipboard = ZeroClipboard.extend
  tagName: 'button'
  classNames: ['btn', 'btn-default', 'btn-xs', 'copy-to-clipboard']
  justCopied: false

  justCopiedToggle: ->
    @set 'justCopied', !@justCopied

  actions:
    afterCopy: ->
      @justCopiedToggle()
      Ember.run.later @, (->
        @justCopiedToggle()
      ), 1500


`export default CopyToClipboard`
