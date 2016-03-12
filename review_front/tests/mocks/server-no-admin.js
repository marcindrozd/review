import Ember from 'ember';
import Pretender from 'pretender';
var ServerNoAdmin;

ServerNoAdmin = Ember.Object.extend({
  init: function() {
    return this.set('server', this._makePretender());
  },
  shutdown: function() {
    return this.get('server').shutdown();
  },
  _makePretender: function() {
    return new Pretender(function() {
      this.get('api/v2/users', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            users: [
              {
                id: 1,
                admin: false
              }
            ]
          })
        ];
      });
      return this.get('/api/v2/users/me', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            user: {
              id: 1,
              admin: false
            }
          })
        ];
      });
    });
  }
});

export default ServerNoAdmin;
