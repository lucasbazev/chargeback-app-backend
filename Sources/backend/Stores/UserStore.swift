import Vapor

actor UserStore {
  var users: [User]

  init(_ users: [User]) {
    self.users = users
  }

  func all() -> [User] {
    users
  }

  func byId(_ id: Int) -> User? {
    users.first(where: { $0.id == id })
  }

  func append(_ user: User) {
    users.append(user)
  }

}
