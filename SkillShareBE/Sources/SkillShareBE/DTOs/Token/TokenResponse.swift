//
//  TokenResponse.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Vapor
import Fluent

struct TokenResponse: Content {
    let token: String
    let refreshToken: String
}
