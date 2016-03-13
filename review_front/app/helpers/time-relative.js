import Ember from "ember";
import moment from "moment";

const timeRelative = function(value) {
  const [time, _] = value;
  return moment(time).fromNow();
};

const TimeRelativeHelper = Ember.Helper.helper(timeRelative);

export { timeRelative };

export default TimeRelativeHelper;
