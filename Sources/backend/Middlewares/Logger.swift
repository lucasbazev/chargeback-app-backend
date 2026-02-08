import Vapor

struct LoggerMiddleware: AsyncMiddleware {
  func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
    let body = request.body

    if let bodyString = body.string, !bodyString.isEmpty {
      print("Request body: \(bodyString)")
    }

    return try await next.respond(to: request)
  }
}
