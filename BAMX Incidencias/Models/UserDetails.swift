//
//  UserDetails.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/11/23.
//

import Foundation

struct UserResponse: Codable {
    let user: UserDetails
    let access_token: String?
    let type: String
}

struct UserDetails: Codable {
    let _id: String?
    let first_name: String
    let last_name: String
    let email: String
    let role: String
    let identification: String
    let created_by: String?
    let last_login: String
    let created_at: String
    let updated_at: String
}

struct MeDetails: Codable {
    let _id: String?
    let first_name: String
    let last_name: String
    let email: String
    let role: String
    let identification: String
    let password: String
    let created_by: String?
    let last_login: String
    let created_at: String
    let updated_at: String
}