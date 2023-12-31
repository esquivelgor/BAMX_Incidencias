//
//  UserDetails.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/11/23.
//

import Foundation

// Users

struct UsersData: Codable {
    var items: [Users]
    var total: Int
    var page: Int
    var size: Int
    var pages: Int
}

struct Users: Codable {
    var _id: String
    var first_name: String
    var last_name: String
    var email: String
    var role: String
    var identification: String
    var password: String
    var created_by: String? // This can be nil
    var last_login: String
    var created_at: String
    var updated_at: String
}


// ----------------- User -----------------

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
    let _id: String
    let first_name: String
    let last_name: String
    let email: String
    let role: String
    let identification: String
    let password: String
    let created_by: String
    let last_login: String
    let created_at: String
    let updated_at: String
}

// ----------------- Requests/Tickets -----------------

struct RequestData: Codable {
    let items: [Requests]
    let total: Int
    let page: Int
    let size: Int
    let pages: Int
}

struct Requests: Codable {
    let _id: String
    let type: String
    let email: String?
    let state: String
    let title: String
    let description: String
    let created_by: String?
    let proccessed_by: String?
    let created_at: String
    let updated_at: String
}
// ------ Incidents

struct Incident: Codable {
    var _id: String
    var title: String
    var description: String?
    var urgency: String
    var state: String
    var images: [IncidentImage]
    var category: String?
    var created_by: String
    var assigned_to: String?
    var time_solved: String?
    var created_at: String
    var updated_at: String
}

struct IncidentImage: Codable {
    var uploaded_image_id: String
    var url: String
    var content_type: String
}

struct IncidentResponse: Codable {
    var items: [Incident]
    var total: Int
    var page: Int
    var size: Int
    var pages: Int
}
