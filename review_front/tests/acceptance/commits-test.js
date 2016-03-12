import Ember from 'ember';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';
import Server from '../mocks/server';
var application, server;

application = null;

server = null;

module('Acceptance: ProjectCommits', {
  beforeEach: function() {
    application = startApp();
    server = Server.create();
    visit('projects/1/commits');
  },
  afterEach: function() {
    Ember.run(application, 'destroy');
    server.shutdown();
  }
});

test('find pagination button', function(assert) {
  return assert.ok(find('.pagination'));
});

test('find correct page nameber', function(assert) {
  assert.ok(find('.pagination .page-number:active'));
  return assert.ok(find('.pagination a:contains("1")'));
});
