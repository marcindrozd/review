import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('projects');
  this.route('project', { path: 'projects/:name' }, function() {
    this.route('commits');
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
