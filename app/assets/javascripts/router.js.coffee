Review.Router.map ->
  @resource 'projects', ->
    @resource 'project', path: '/:project_id', ->
      @route 'commits'
  @resource 'tickets', ->
    @resource 'ticket', path: '/:ticket_id', ->
      @route 'commits'
  @resource 'admin', ->
    @route 'users'
