//
//  CreateUser.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        return try await database.schema("users")
            .id()
            .field("email", .string, .required)
            .unique(on: "email")
            .field("passwordHash", .string, .required)
            .field("fullName", .string, .required)
            .field("gender", .string, .required)
            .create()
    }
   
    func revert(on database: any FluentKit.Database) async throws {
        return try await database.schema("users").delete()
    }
}
