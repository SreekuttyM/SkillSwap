//
//  UpdateProfileRequest.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Vapor
import Fluent

struct UpdateProfileRequest: Content {
    let fullName: String?
    let gender: String?
}
