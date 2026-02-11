import Foundation
import Vapor

struct TransactionsController: RouteCollection {
  func boot(routes: any RoutesBuilder) throws {
    let transactions = routes.grouped("transactions")

    transactions.get(use: getAll)
    transactions.get(":id", use: getById)
    transactions.post(use: create)
  }

  func getAll(req: Request) async throws -> [Transaction] {
    let query = try? req.query.decode(GetTransactionsQuery.self)

    return try await Transaction.query(on: req.db).all().filter { transaction in
      (query?.status.map { transaction.status == $0 } ?? true)
        && (query?.min.map { transaction.amount >= $0 } ?? true)
        && (query?.max.map { transaction.amount <= $0 } ?? true)
    }
  }

  func getById(req: Request) async throws -> Transaction {
    guard let id = req.parameters.get("id", as: UUID.self) else {
      throw Abort(.badRequest, reason: "Missing transaction ID")
    }

    guard let transaction = try await Transaction.find(id, on: req.db) else {
      throw Abort(.notFound, reason: "Transaction not found.")
    }

    return transaction
  }

  func create(req: Request) async throws -> Transaction {
    guard let data = try req.content.decode(CreateTransactionRequest?.self) else {
      throw Abort(.badRequest, reason: "Invalid transaction data")
    }

    let transaction = Transaction(from: data)
    try await transaction.save(on: req.db)

    return transaction
  }
}
