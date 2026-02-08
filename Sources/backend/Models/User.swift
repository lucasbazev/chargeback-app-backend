import Foundation
import Vapor

enum UserRole: String, Codable {
  case admin
  case customer
}

struct User: Content {
  let id: Int
  let email: String
  let password: String
  let name: String
  let role: UserRole

  init(from: CreateUserRequest) {
    self.id = Int.random(in: 1...1000)
    self.email = from.email
    self.password = from.password
    self.name = from.name
    self.role = from.role
  }
}

struct CreateUserRequest: Content {
  let email: String
  let password: String
  let name: String
  let role: UserRole
}
