import Foundation
import Vapor

struct TransactionsController: RouteCollection {
  func boot(routes: any RoutesBuilder) throws {
    let transactions = routes.grouped("transactions")

    // transactions.get(use: getAll)
    // transactions.get(":id", use: getById)
    // transactions.post(use: create)
  }

  func getAll(req: Request) async throws -> [Transaction] {
    let query = try? req.query.decode(GetTransactionsQuery.self)

    return []
  }

  func getById(req: Request) async throws -> Transaction? {
    guard let id = req.parameters.get("id", as: Int.self) else {
      throw Abort(.badRequest, reason: "Missing transaction ID")
    }

    return nil
  }

  func create(req: Request) async throws -> Transaction? {
    guard let data = try req.content.decode(CreateTransactionRequest?.self) else {
      throw Abort(.badRequest, reason: "Invalid transaction data")
    }

    return nil
  }
}
