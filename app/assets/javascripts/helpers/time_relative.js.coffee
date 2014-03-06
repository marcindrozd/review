Ember.Handlebars.helper 'timeRelative', (value, options)->
  moment(value).fromNow()
