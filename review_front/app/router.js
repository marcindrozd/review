import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('projects', function() {
    return this.route('project', { resetNamespace: true, path: '/:name' }, function() {
      return this.route('commits');
    });
  });
  this.route('tickets', function() {
    return this.route('ticket', { path: '/:ticket_id' }, function() {
      return this.route('commits');
    });
  });
  this.route('admin', function() {
    this.route('invitations', { resetNamespace: true }, function() {
      return this.route('new');
    });
    return this.route('users', { resetNamespace: true }, function() {
      return this.route('edit', { path: '/:nickname' });
    });
  });
  return this.route('catchall', { path: '/*wildcard' });
});

export default Router;
