`import Ember from 'ember'`

timeRelative = (value, options) ->
  moment(value).fromNow()

TimeRelativeHelper = Ember.Handlebars.makeBoundHelper timeRelative

`export { timeRelative }`
`export default TimeRelativeHelper`
