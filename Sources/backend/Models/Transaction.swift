import Foundation
import Vapor

enum TransactionStatus: String, Codable {
  case pending
  case completed
  case disputed
  case refunded
}

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

struct CreateTransactionRequest: Content {
  let amount: Double
  let currency: String
}

struct GetTransactionsQuery: Content {
  let status: TransactionStatus?
  let min: Double?
  let max: Double?
}