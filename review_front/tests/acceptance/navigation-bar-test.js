import destroyApp from '../helpers/destroy-app';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';
import Server from '../mocks/server';
import ServerNoAdmin from '../mocks/server-no-admin';
var application, server;

application = null;

server = null;

module('Acceptance: NavigationBar', {
  beforeEach: function() {
    application = startApp();
    server = Server.create();
    visit('/');
  },
  afterEach: function() {
    destroyApp(application);
    return server.shutdown();
  }
});

test('navigation bar renders', function(assert) {
  return assert.equal(find('.navbar').length, 1);
});

test('shows link to projects page', function(assert) {
  return assert.equal(find("a:contains('Projects')").length, 1);
});

test('shows linkt to admin page if user is admin', function(assert) {
  return assert.equal(find("a:contains('Admin')").length, 1);
});

test('after click on users it trnsfers to admin users page', function(assert) {
  click("a:contains('Users')");
  return andThen(function() {
    return assert.equal(currentPath(), 'admin.users.index');
  });
});

test('after click on invitations it trnsfers to admin invitations page', function(assert) {
  click("a:contains('Invitations')");
  return andThen(function() {
    return assert.equal(currentPath(), 'admin.invitations.index');
  });
});

test('from admin page, it transfers to projects after click on projects', function(assert) {
  click("a:contains('Admin')");
  return andThen(function() {
    click("a:contains('Projects')");
    return andThen(function() {
      return assert.equal(currentPath(), 'projects.index');
    });
  });
});

test('if user is not admin no admin link is shown', function(assert) {
  destroyApp(application);
  server.shutdown();
  application = startApp();
  server = ServerNoAdmin.create();
  return assert.equal(find("a:contains('Admin')").length, 0);
});
