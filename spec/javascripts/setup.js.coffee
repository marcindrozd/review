Review.Store = DS.Store.extend
    revision: 11
    adapter: DS.FixtureAdapter.create(simulateRemoteResponse: false)

Review.Project.FIXTURES = []
Review.User.FIXTURES = []

Review.setupForTesting()
Review.injectTestHelpers()
