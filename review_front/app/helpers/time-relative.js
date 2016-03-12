import Ember from 'ember';
var TimeRelativeHelper, timeRelative;

timeRelative = function(value) {
  return moment(value).fromNow();
};

TimeRelativeHelper = Ember.Handlebars.makeBoundHelper(timeRelative);

export { timeRelative };

export default TimeRelativeHelper;
