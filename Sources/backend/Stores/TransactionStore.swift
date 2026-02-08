import Vapor

actor TransactionStore {
  var transactions: [Transaction]

  init(_ transactions: [Transaction]) {
    self.transactions = transactions
  }

  func all() -> [Transaction] {
    transactions
  }

  func byId(_ id: Int) -> Transaction? {
    transactions.first(where: { $0.id == id })
  }

  func append(_ transaction: Transaction) {
    transactions.append(transaction)
  }
}