import Ember from 'ember';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';
import Server from '../mocks/server';
var application, server;

application = null;

server = null;

module('Acceptance: Sanity', {
  beforeEach: function() {
    application = startApp();
    server = Server.create();
    visit('/');
  },
  afterEach: function() {
    Ember.run(application, 'destroy');
    server.shutdown();
  }
});

test('main template is rendering', function(assert) {
  return assert.equal(find('.navbar-header').length, 1);
});
