`import Ember from 'ember'`
`import Pretender from 'pretender'`

ServerNoAdmin = Ember.Object.extend
  init:->
    @set('server', @_makePretender())

  shutdown: ->
    @get('server').shutdown()

  _makePretender: ->
    new Pretender ->
      @get 'api/v2/users', ->
          [
            200, { "Content-type": "application/json" }, JSON.stringify(
              users:[
                {
                  id: 1
                  admin: false 
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
                admin: false 
              }
          )
        ]
`export default ServerNoAdmin`
