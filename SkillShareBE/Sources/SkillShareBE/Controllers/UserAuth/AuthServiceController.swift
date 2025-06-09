//
//  AuthServiceController.swift
//  SkillShareBE
//  Created by Sreekutty Maya on 09/06/2025.
//

import Fluent
import Vapor

struct AuthServiceController: RouteCollection {
   
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.post("signup", use: signup)
        auth.post("signin", use: signin)
        auth.post("refresh", use: self.refresh)
    }
    
    @Sendable
    func signup(req: Request) async throws -> HTTPStatus {

        let data = try req.content.decode(SignUpRequest.self)
        guard try await User.query(on: req.db).filter(\.$email == data.email).first() == nil else {
            throw Abort(.conflict, reason: "Email already registered.")
        }
        let hashed = try Bcrypt.hash(data.password)
        let user = User(email: data.email, passwordHash: hashed, fullName: data.fullName, gender: data.gender)
        do {
            try await user.save(on: req.db)
        } catch {
            print("DB Error:", String(reflecting: error))
            throw error // or handle more gracefully
        }
        return .ok
    }

    @Sendable
    func signin(req: Request) async throws -> TokenResponse {
        let data = try req.content.decode(SignInRequest.self)
        
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == data.email)
            .first()
        else {
            throw Abort(.unauthorized, reason: "Invalid email or password.")
        }
        
        guard try Bcrypt.verify(data.password, created: user.passwordHash) else {
            throw Abort(.unauthorized, reason: "Invalid email or password.")
        }
        
        let payload = UserPayload(
            subject: .init(value: try user.requireID().uuidString),
            expiration: .init(value: .init(timeIntervalSinceNow: Constants.tokenExpirationTime)),// 24h token
            isAdmin: false
        )
        
        let token = try await req.jwt.sign(payload)
        let refreshToken = UUID().uuidString
        let expiresAt = Date().addingTimeInterval(Constants.tokenExpirationTime * 30) // 30 days

        let refresh = RefreshToken(token: refreshToken, userID: try user.requireID(), expiresAt: expiresAt)
        try await refresh.save(on: req.db)

        return TokenResponse(token: token, refreshToken: refreshToken)
    }
    
    @Sendable
    func refresh(req: Request) async throws -> TokenResponse {
        let payload = try req.content.decode(RefreshTokenRequest.self)
        guard let token = try await RefreshToken.query(on: req.db)
            .filter(\.$token == payload.refreshToken)
            .first()
        else {
            throw Abort(.unauthorized, reason: "Invalid refresh token")
        }
        guard token.expiresAt > Date() else {
            throw Abort(.unauthorized, reason: "Refresh token expired")
        }
        let user = try await token.$user.get(on: req.db)
        let newJWT = try await req.jwt.sign(UserPayload(
            subject: .init(value: try user.requireID().uuidString),
            expiration: .init(value: .init(timeIntervalSinceNow:Constants.tokenExpirationTime)), // 1h
            isAdmin: false
        ))
        return TokenResponse(token: newJWT, refreshToken: payload.refreshToken)
    }
}
