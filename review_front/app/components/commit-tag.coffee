`import Ember from 'ember'`

CommitLanguageTag = Ember.Component.extend
  tagName: 'span'
  classNames: ['label', 'label-info']
  classNameBindings: ['labelClass']

`export default CommitLanguageTag`
