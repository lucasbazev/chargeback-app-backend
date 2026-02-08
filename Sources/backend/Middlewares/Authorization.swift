import Foundation
import Vapor

struct AuthorizationMiddleware: AsyncMiddleware {
  func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
    guard let token = request.headers.bearerAuthorization else {
      throw Abort(.unauthorized)
    }

    print(token)
    return try await next.respond(to: request)
  }

}
