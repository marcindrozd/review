import Ember from 'ember';
import config from './config/environment';
var Router;

Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('projects', function() {
    return this.resource('project', {
      path: '/:name'
    }, function() {
      return this.route('commits');
    });
  });
  this.resource('tickets', function() {
    return this.resource('ticket', {
      path: '/:ticket_id'
    }, function() {
      return this.route('commits');
    });
  });
  this.resource('admin', function() {
    this.resource('invitations', function() {
      return this.route('new');
    });
    return this.resource('users', function() {
      return this.route('edit', {
        path: '/:nickname'
      });
    });
  });
  return this.route('catchall', {
    path: '/*wildcard'
  });
});

export default Router;
