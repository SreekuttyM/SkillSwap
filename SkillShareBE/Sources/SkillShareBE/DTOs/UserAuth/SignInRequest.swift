//
//  SignInRequest.swift
//  SkillShareBE
//  Created by Sreekutty Maya on 09/06/2025.
//
import Vapor
import Fluent

struct SignInRequest: Content {
    let email: String
    let password: String
}
