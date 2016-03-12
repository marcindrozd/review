import { timeRelative } from '../../../helpers/time-relative';
import { module, test } from 'qunit';
module('TimeRelativeHelper');

test('it works', function(assert) {
  var result;
  result = timeRelative(42);
  return assert.ok(result);
});
