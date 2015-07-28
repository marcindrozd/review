`import Ember from "ember"`

LinkView = Ember.LinkView.reopen
  attributeBindings: 'data-toggle'

`export default LinkView`
