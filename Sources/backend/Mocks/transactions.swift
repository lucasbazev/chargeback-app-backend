import Vapor

func initTransactionsMock(app: Application) async throws {
  let mockData = [
    Transaction(
      amount: 100.0,
      currency: "USD",
      status: .completed,
    ),
    Transaction(
      amount: 50.0,
      currency: "EUR",
      status: .pending,
    ),
    Transaction(
      amount: 200.0,
      currency: "GBP",
      status: .disputed,
    ),
    Transaction(
      amount: 75.0,
      currency: "AUD",
      status: .refunded,
    ),
  ]

  try await mockData.create(on: app.db)
}
