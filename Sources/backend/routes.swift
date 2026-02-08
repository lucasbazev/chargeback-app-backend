import Vapor

func routes(_ app: Application) throws {
  app.middleware.use(LoggerMiddleware())
  app.middleware.use(AuthorizationMiddleware())

  try app.register(collection: UsersController(userStore: UserStore(initUsersMock())))

  try app.register(
    collection: TransactionsController(transactionStore: TransactionStore(initTransactionsMock())))

  app.get { req async in
    "Chargeblast API is running!"
  }
}
