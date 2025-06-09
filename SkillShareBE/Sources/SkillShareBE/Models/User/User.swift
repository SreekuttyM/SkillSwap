//
//  File.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Vapor
import Fluent

enum Gender: String, Codable {
    case male, female, other
}

final class User: Model, Content,@unchecked Sendable {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?
    @Field(key: "email")
    var email: String
    @Field(key: "passwordHash")
    var passwordHash: String
    @Field(key: "fullName")
    var fullName: String
    @Field(key: "gender")
    var gender: Gender

    init() {}
    
    init(email: String, passwordHash: String, fullName: String, gender: Gender) {
        self.email = email
        self.passwordHash = passwordHash
        self.fullName = fullName
        self.gender = gender
    }
    
    
}

extension User {
    struct UserModel : Content {
        let id: UUID?
        let email: String
        let fullName: String
        let gender: String
    }

    func convertToUserModel() -> UserModel {
        return UserModel(id: id, email: email, fullName: fullName, gender: gender.rawValue)
    }
}
