//
//  CreateUser 2.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Fluent

struct CreateRefreshToken: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        return try await database.schema("refresh_tokens")
            .id()
            .field("token", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("expires_at", .datetime, .required)
            .unique(on: "token")
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        return try await database.schema("refresh_tokens").delete()
    }
}
