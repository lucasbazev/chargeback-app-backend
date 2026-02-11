import Fluent
import Foundation
import Vapor

struct CreateTransactionRequest: Content {
  let amount: Double
  let currency: String
}

struct GetTransactionsQuery: Content {
  let status: TransactionStatus?
  let min: Double?
  let max: Double?
}

struct UpdateTransactionRequest: Content {
  let status: TransactionStatus
}

enum TransactionStatus: String, Codable, Sendable {
  case pending
  case completed
  case disputed
  case refunded
}

final class Transaction: Model, Content, @unchecked Sendable {
  static let schema: String = "transactions"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "amount")
  var amount: Double

  @Field(key: "currency")
  var currency: String

  @Field(key: "status")
  var status: TransactionStatus

  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  @Timestamp(key: "updated_at", on: .update)
  var updatedAt: Date?

  init() {}

  init(
    id: UUID? = nil, amount: Double, currency: String = "USD", status: TransactionStatus = .pending
  ) {
    self.id = id
    self.amount = amount
    self.currency = currency
    self.status = status
  }

  init(from: CreateTransactionRequest) {
    self.id = nil
    self.amount = from.amount
    self.currency = from.currency
    self.status = .pending
  }
}

/*
struct Transaction: Content {
  let id: Int
  let amount: Double
  let currency: String
  let status: TransactionStatus
  let createdAt: Date
  let updatedAt: Date

  init(
    amount: Double,
    currency: String,
    status: TransactionStatus? = nil,
    createdAt: Date? = nil,
    updatedAt: Date? = nil
  ) {
    self.id = Int.random(in: 1...1000)
    self.amount = amount
    self.currency = currency
    self.status = status ?? .pending
    self.createdAt = createdAt ?? Date()
    self.updatedAt = updatedAt ?? Date()
  }
}
*/
