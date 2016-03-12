import { test, moduleForComponent } from 'ember-qunit';
moduleForComponent('commit-state-label', {});

test('it renders', function(assert) {
  var component;
  assert.expect(2);
  component = this.subject();
  assert.equal(component._state, 'preRender');
  this.render();
  return assert.equal(component._state, 'inDOM');
});

test("'reviewState' has a default value", function(assert) {
  return ok(this.subject().get('reviewState') === 'unknown', "should have a value of 'unknown'");
});

test('uses default label style when unrecognized state provided', function() {
  return ok(this.subject().get('labelClass') === 'label-default', "should have a class of 'label-default'");
});

test('has a specific label style for accepted state', function() {
  this.subject().set('reviewState', 'accepted');
  return ok(this.subject().get('labelClass') === 'label-success', "should have a class of 'label-success'");
});

test('has a specific label style for pending state', function() {
  this.subject().set('reviewState', 'pending');
  return ok(this.subject().get('labelClass') === 'label-info', "should have a class of 'label-info'");
});

test('has a specific label style for passed state', function() {
  this.subject().set('reviewState', 'passed');
  return ok(this.subject().get('labelClass') === 'label-warning', "should have a class of 'label-warning'");
});

test('has a specific label style for rejected state', function() {
  this.subject().set('reviewState', 'rejected');
  return ok(this.subject().get('labelClass') === 'label-danger', "should have a class of 'label-danger'");
});
