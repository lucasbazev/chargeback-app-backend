import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  // POSTGRES DB
  app.databases.use(
    .postgres(
      configuration: .init(
        hostname: "localhost",
        username: "chargeback_admin",
        password: "chargeback-app-db-admin",
        database: "chargeback_app_db",
        tls: .disable
      )
    ),
    as: .psql
  )

  app.migrations.add(CreateTransactionsTableMigration())

  // populate transactions table with some data
  // try await initTransactionsMock(app: app)

  // register routes
  try routes(app)
}
