import Vapor

func initUsersMock() -> [User] {
  [
    User(
      from: CreateUserRequest(
        email: "admin@chargeblast.com", password: "admin123", name: "Chargeblast", role: .admin))
  ]
}
