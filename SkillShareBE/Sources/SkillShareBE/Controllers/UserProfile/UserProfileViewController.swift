//
//  UserProfileController.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Fluent
import Vapor
import JWTKit

struct UserProfileController: RouteCollection {
    
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let auth = routes.grouped("profile").grouped(JWTMiddleware<UserPayload>())
        auth.get(use: getUserProfile)
        auth.put(use: updateUserProfile)
    }
    
    @Sendable
    func getUserProfile(req: Request) async throws -> User.UserModel {
        let payload = try req.auth.require(UserPayload.self)
        
        let userID = UUID(uuidString: payload.subject.value)!
        print(userID)
        guard let user = try await User.find(userID, on: req.db) else {
            throw Abort(.notFound, reason: "User not found")
        }
        return user.convertToUserModel()
    }
    
    @Sendable
    func updateUserProfile(req: Request) async throws -> HTTPStatus {
        let payload = try req.auth.require(UserPayload.self)
        let userID = UUID(uuidString: payload.subject.value)!
        print(userID)

        guard let user = try await User.find(userID, on: req.db) else {
            throw Abort(.notFound, reason: "User not found")
        }
        let input = try req.content.decode(UpdateProfileRequest.self)
        
        if let name = input.fullName {
            user.fullName = name
        }
        
        if let gender = input.gender {
            user.gender = Gender(rawValue: gender) ?? .female
        }
        
        try await user.save(on: req.db)
        return .ok
    }
    
}
