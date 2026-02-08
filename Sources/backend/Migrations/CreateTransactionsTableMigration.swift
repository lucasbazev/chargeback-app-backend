import Vapor
import Fluent

struct CreateTransactionsTableMigration: AsyncMigration {
  func prepare(on database: any FluentKit.Database) async throws {
    try await database.schema("transactions")
      .id()
      .field("amount", .double, .required)
      .field("currency", .string, .required)
      .field("status", .string, .required)
      .field("created_at", .datetime, .required)
      .field("updated_at", .datetime, .required)
      .create()
  }

  func revert(on database: any Database) async throws {
    try await database.schema("transactions").delete()
  }
}