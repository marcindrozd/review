`import Ember from 'ember'`
`import Pretender from 'pretender'`

Server = Ember.Object.extend
  init:->
    @set('server', @_makePretender())

  shutdown: ->
    @get('server').shutdown()

  _makePretender: ->
    new Pretender ->
      @get '/api/v2/projects', ->
        [
          200, { "Content-type": "application/json" }, JSON.stringify( 
            projects: [ 
              { 
                id: 1
                accepted: 1
                rejected: 2
                pending: 6
                total: 10
                name: 'firstProject'
                grade: 'good'
                permission: [1]
              },{
                id: 2
                accepted: 0
                rejected: 2
                pending: 4 
                total: 10
                name: 'secondProject'
                grade: 'good'
                permission: [1]
              }
            ]
          ) 
        ]
      @get 'api/v2/users', ->
        [
          200, { "Content-type": "application/json" }, JSON.stringify(
            users:[
              {
                id: 1
                admin: true
                permissions: [1]
              },
              {
                id: 2
                admin: true
                permissions: [1]
              }
            ]
          )
        ]
      @get '/api/v2/users/me', ->
        [
          200, { "Content-type": "application/json" }, JSON.stringify(
            user:
              {
                id: 1
                admin: true
                permissions:[1] 
              }
          )
        ]
      @get 'api/v2/permissions', ->
        [
          200, { "Content-type": "application/json"}, JSON.stringify(
            permissions:[1]
          )
        ]
`export default Server`
