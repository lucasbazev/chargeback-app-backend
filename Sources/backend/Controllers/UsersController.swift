import Foundation
import Vapor

struct UsersController: RouteCollection {
  let userStore: UserStore

  init(userStore: UserStore) {
    self.userStore = userStore
  }

  func boot(routes: any RoutesBuilder) {
    let users = routes.grouped("users")

    users.get(use: getAll)
    users.get(":id", use: getAll)
    users.post(use: create)
  }

  func getAll(req: Request) async throws -> [User] {
    return await userStore.all()
  }

  func getById(req: Request) async throws -> User {
    guard let id = req.parameters.get("id", as: Int.self) else {
      throw Abort(.badRequest, reason: "User ID missing.")
    }

    guard let user = await userStore.byId(id) else {
      throw Abort(.badRequest, reason: "User not found.")
    }

    return user
  }

  func create(req: Request) async throws -> User {
    guard let data = try req.content.decode(CreateUserRequest?.self) else {
      throw Abort(.badRequest, reason: "Invalid user data.")
    }

    let hashedUser = CreateUserRequest(
      email: data.email,
      password: try await req.password.async.hash(data.password),
      name: data.name,
      role: data.role
    )

    let user = User(from: hashedUser)
    await userStore.append(user)
    return user
  }
}
