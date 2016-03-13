import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('projects');
  this.route('project', { path: 'projects/:name/commits' });
  this.route('admin', function() {
    this.route('invitations', { resetNamespace: true }, function() {
      this.route('new');
    });
    this.route('users', { resetNamespace: true }, function() {
      this.route('edit', { path: '/:nickname' });
    });
  });
  this.route('catchall', { path: '/*wildcard' });
});

export default Router;
