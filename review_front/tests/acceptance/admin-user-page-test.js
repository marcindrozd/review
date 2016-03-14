import destroyApp from '../helpers/destroy-app';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';
import Server from '../mocks/server';
var application, server;

application = null;

server = null;

module('Acceptance: AdminUserPage', {
  beforeEach: function() {
    application = startApp();
    server = Server.create();
    visit('/');
    click('.navbar-left a:eq(2)');
  },
  afterEach: function() {
    destroyApp(application);
    return server.shutdown();
  }
});

test('visiting /admin-user-page', function(assert) {
  return assert.equal(currentURL(), '/admin/users');
});

test("displays a table with user", function(assert) {
  return assert.equal(find(".admin-users__row").length, 2);
});

test("after clicking on projects, drects to projects", function(assert) {
  click(".navbar-left a:eq(0)");
  return andThen(function() {
    return assert.equal(currentPath(), 'projects');
  });
});
