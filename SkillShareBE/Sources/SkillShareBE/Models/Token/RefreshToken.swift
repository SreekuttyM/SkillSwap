//
//  RefreshToken.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//
import Vapor
import Fluent

final class RefreshToken: Model, Content, @unchecked Sendable {
    static let schema = "refresh_tokens"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "token")
    var token: String

    @Parent(key: "user_id")
    var user: User

    @Field(key: "expires_at")
    var expiresAt: Date

    init() {}

    init(id: UUID? = nil, token: String, userID: UUID, expiresAt: Date) {
        self.id = id
        self.token = token
        self.$user.id = userID
        self.expiresAt = expiresAt
    }
}
