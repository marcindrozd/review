Review.Store = DS.Store.extend
    revision: 11
    adapter: DS.FixtureAdapter.create(simulateRemoteResponse: false)

Review.User.FIXTURES = [
  id: 1
  image_url: "adas1.jpg"
  name: "mariusz"
  nickname: "mariuszDusielak"
  admin: true
  permissions: [1,2,3]
,
  id: 2
  image_url: "adas2.jpg"
  name: "Jessica"
  nickname: "JessicaAlba"
  admin: false
  permissions: [4,5,6]
]

Review.Project.FIXTURES = [
  id: 1
  name: 'firstP'
  rejected: 0
  pending: 0
  accepted: 0
  total: 0
  grade: "grade1"
  permission: [1,4]
,
  id: 2
  name: 'SecondP'
  rejected: 0
  pending: 0
  accepted: 0
  total: 0
  grade: "grade2"
  permission: [2,5]
,
  id: 3
  name: 'thirdP'
  rejected: 0
  pending: 0
  accepted: 0
  total: 0
  grade: "grade3"
  permission: [3,6]
]

Review.Permission.FIXTURES = [
  id: 1
  user_id: 1
  project_id: 1
  allowed: true
,
  id: 2
  user_id: 1
  project_id: 2
  allowed: true
,
  id: 3
  user_id: 1
  project_id: 3
  allowed: false
,
  id: 4
  user_id: 2
  project_id: 1
  allowed: false
,
  id: 5
  user_id: 2
  project_id: 2
  allowed: false
,
  id: 6
  user_id: 2
  project_id: 3
  allowed: false
]

Review.setupForTesting()
Review.injectTestHelpers()
