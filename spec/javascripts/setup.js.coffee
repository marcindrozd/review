Review.Store = DS.Store.extend
    revision: 11
    adapter: DS.FixtureAdapter.create(simulateRemoteResponse: false)

Review.User.FIXTURES = []

Review.Project.FIXTURES = []

Review.Permission.FIXTURES = []

Review.setupForTesting()
Review.injectTestHelpers()
