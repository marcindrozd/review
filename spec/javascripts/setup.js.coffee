Review.ApplicationAdapter = DS.FixtureAdapter.extend({simulateRemoteResponse: true})
Review.Store = DS.Store.extend
  revision: 12
  adapter:  DS.FixtureAdapter
DS.FixtureAdapter.reopen
  queryFixtures: (records, query, type) ->
    records.filter (record) ->
      for key of query
        if !query.hasOwnProperty(key)
          continue
        value = query[key]
        if record[key] != value
          return false
       true
Review.setupForTesting()
Review.injectTestHelpers()
