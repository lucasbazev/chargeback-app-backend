import Vapor

func routes(_ app: Application) throws {
  app.middleware.use(LoggerMiddleware())
  app.middleware.use(AuthorizationMiddleware())

  // try app.register(collection: UsersController(userStore: UserStore(initUsersMock())))

  try app.register(collection: TransactionsController())

  app.get { req async in
    "Chargeblast API is running!"
  }
}
