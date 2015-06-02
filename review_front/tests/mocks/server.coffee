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
                rejcected: 2
                pending: 6
                name: 'fristProject'
                grade: 'good'
                permission: [1]
              },{
                id: 2
                accepted: 0
                rejcected: 2
                pending: 4 
                name: 'secondProject'
                grade: 'good'
                permission: [1]
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
               }
            )
         ]
`export default Server`
