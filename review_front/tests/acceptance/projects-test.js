import destroyApp from '../helpers/destroy-app';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';
import Server from '../mocks/server';
var application, server;

application = null;

server = null;

module("Acceptance: Projects", {
  beforeEach: function() {
    application = startApp();
    server = Server.create();
    visit("/");
  },
  afterEach: function() {
    destroyApp(application);
    server.shutdown();
  }
});

test("visiting /", function(assert) {
  return assert.equal(currentPath(), "projects");
});

test("displays table with projects", function(assert) {
  assert.equal(find(".table-bordered tr:eq(1) a:first").text(), "firstProject");
  return assert.equal(find(".table-bordered tr:eq(2) a:first").text(), "secondProject");
});

test("checks correct values for project", function(assert) {
  var findFirstProjectAccepted, findFirstProjectPending, findFirstProjectRejected, findFirstProjectStatus, findFirstProjectTotal;
  findFirstProjectRejected = function() {
    return find(".table-bordered tr:eq(1) td:eq(1)").text();
  };
  findFirstProjectPending = function() {
    return find(".table-bordered tr:eq(1) td:eq(2)").text();
  };
  findFirstProjectAccepted = function() {
    return find(".table-bordered tr:eq(1) td:eq(3)").text();
  };
  findFirstProjectTotal = function() {
    return find(".table-bordered tr:eq(1) td:eq(4)").text();
  };
  findFirstProjectStatus = function() {
    return find(".table-bordered tr:eq(1) td:eq(5) .glyphicon.glyphicon-ok.text-success");
  };
  assert.equal(findFirstProjectRejected(), "2");
  assert.equal(findFirstProjectPending(), "6");
  assert.equal(findFirstProjectAccepted(), "1");
  assert.equal(findFirstProjectTotal(), "10");
  return assert.equal(findFirstProjectStatus().length, 1);
});

test("find github links", function(assert) {
  return assert.equal(find(".glyphicon.glyphicon-link").length, 2);
});
