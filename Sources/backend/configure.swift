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

  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

  // register routes
  try routes(app)
}
