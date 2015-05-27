`import Ember from 'ember'`

# This function receives the params `params, hash`
timeRelative = (value, options) ->
  return moment(value).fromNow()

TimeRelativeHelper = Ember.HTMLBars.makeBoundHelper timeRelative

`export default TimeRelativeHelper`
