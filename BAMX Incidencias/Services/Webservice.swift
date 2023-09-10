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


struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class Webservice {
    
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "https://example.com/login") else {
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
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        } .resume()
    }
    
}
