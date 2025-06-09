//
//  SignUpRequest.swift
//  SkillShareBE
//
//  Created by Sreekutty Maya on 09/06/2025.
//

import Foundation
import Vapor
import Fluent

struct SignUpRequest: Content {
    let email: String
    let password: String
    let fullName: String
    let gender: Gender
}
