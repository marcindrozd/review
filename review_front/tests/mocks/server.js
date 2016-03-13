import Ember from 'ember';
import Pretender from 'pretender';
var Server;

Server = Ember.Object.extend({
  init: function() {
    return this.set('server', this._makePretender());
  },
  shutdown: function() {
    return this.get('server').shutdown();
  },
  _makePretender: function() {
    return new Pretender(function() {
      this.get('/api/v2/projects', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            projects: [
              {
                id: 1,
                accepted: 1,
                rejected: 2,
                pending: 6,
                total: 10,
                name: 'firstProject',
                grade: 'good',
                permission: [1]
              }, {
                id: 2,
                accepted: 0,
                rejected: 2,
                pending: 4,
                total: 10,
                name: 'secondProject',
                grade: 'good',
                permission: [1]
              }
            ],
            meta: {
              total_pages: 1
            }
          })
        ];
      });
      this.get('api/v2/users', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            users: [
              {
                id: 1,
                admin: true,
                permissions: []
              }, {
                id: 2,
                admin: true,
                permissions: []
              }
            ],
            meta: {
              total_pages: 1
            }
          })
        ];
      });
      this.get('api/v2/invitations', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            invitations: [
              {
                id: 1,
                email: 'test@test.com',
                role: 'admin',
                status: 'pending'
              }, {
                id: 2,
                email: 'meh@bleh.com',
                role: 'developer',
                status: 'accepted'
              }
            ],
            meta: {
              total_pages: 1
            }
          })
        ];
      });
      this.get('/api/v2/users/me', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            user: {
              id: 1,
              admin: true,
              permissions: []
            }
          })
        ];
      });
      this.get('api/v2/permissions', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            permissions: [
              {
                id: 1,
                permissions: [1]
              }
            ]
          })
        ];
      });
      this.get('/api/v2/commits', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            commits: [
              {
                id: 1,
                project_id: 1,
                author_id: 1,
                state: "passed",
                tickets: []
              }, {
                id: 2,
                project_id: 2,
                author_id: 1
              }
            ],
            authors: [
              {
                id: 1,
                name: "John Doe"
              }
            ],
            meta: {
              total_pages: 1
            }
          })
        ];
      });
      return this.put('/api/v2/commits/2', function() {
        return [
          200, {
            "Content-type": "application/json"
          }, JSON.stringify({
            commit: {
              state: "accepted"
            }
          })
        ];
      });
    });
  }
});

export default Server;
