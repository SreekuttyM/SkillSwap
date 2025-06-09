//
//  JWTMiddleware.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//


import Vapor
import JWT

struct JWTMiddleware<Payload: JWTPayload & Authenticatable>: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard let bearer = request.headers.bearerAuthorization else {
            throw Abort(.unauthorized)
        }

        let payload = try await request.jwt.verify(bearer.token, as: Payload.self)
        request.auth.login(payload)

        return try await next.respond(to: request)
    }
}
