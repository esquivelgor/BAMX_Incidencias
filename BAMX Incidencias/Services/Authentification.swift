
//
//  Webservice.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/7/23.
//

import Foundation
enum AuthenticationError: Error {
    case invalidCredentials
    case invalidURL
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}


struct User: Codable {
    let user: UserDetails
    let access_token: String?
    let type: String
}

struct UserDetails: Codable {
    let _id: String
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

class Webservice {
    
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "https://food-bank-api.onrender.com/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
        
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage:"Sin informacion")))
                return
            }
        
            guard let loginResponse = try? JSONDecoder().decode(User.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            print(loginResponse)
            guard let token = loginResponse.access_token else {
                completion(.failure(.invalidCredentials))
                return
            }
        
            completion(.success(token))
        } .resume()
    }
    
}
