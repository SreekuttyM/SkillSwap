//
//  RefreshTokenRequest.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Vapor
import Fluent

struct RefreshTokenRequest: Content {
    let refreshToken: String
}
