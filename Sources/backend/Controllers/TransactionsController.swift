import Vapor
import Foundation

struct TransactionsController: RouteCollection {
  let transactionStore: TransactionStore

  init(transactionStore: TransactionStore) {
    self.transactionStore = transactionStore
  }

  func boot(routes: any RoutesBuilder) throws {
    let transactions = routes.grouped("transactions")

    transactions.get(use: getAll)
    transactions.get(":id", use: getById)
    transactions.post(use: create)
  }

  func getAll(req: Request) async throws -> [Transaction] {
    let query = try? req.query.decode(GetTransactionsQuery.self)

    return await transactionStore.all().filter { transaction in
      (query?.status.map { transaction.status == $0 } ?? true)
        && (query?.min.map { transaction.amount >= $0 } ?? true)
        && (query?.max.map { transaction.amount <= $0 } ?? true)
    }
  }

  func getById(req: Request) async throws -> Transaction {
    guard let id = req.parameters.get("id", as: Int.self) else {
      throw Abort(.badRequest, reason: "Missing transaction ID")
    }

    if let transaction = await transactionStore.byId(id) {
      return transaction
    } else {
      throw Abort(.notFound, reason: "Transaction not found")
    }
  }

  func create(req: Request) async throws -> Transaction {
    guard let data = try req.content.decode(CreateTransactionRequest?.self) else {
      throw Abort(.badRequest, reason: "Invalid transaction data")
    }

    let newTransaction = Transaction(
      amount: data.amount,
      currency: data.currency
    )

    await transactionStore.append(newTransaction)
    return newTransaction
  }

}