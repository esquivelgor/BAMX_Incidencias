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
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}


struct LoginResponse: Codable {
    let user: String?
    let access_token: String?
    let type: String?
    //let _id: String
    //let first_name: String
    //let last_name: String
    //let email: String
    //let role: String
    //let identification: String
    //let password: String
    //let last_login: String
    //let created_at: String
    //let updated_at: String
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
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage:"Sin informacion")))
                return
            }
            let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data)
            print("0")
            print(loginResponse?.user as Any)
            print("1")
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            //print("2")
            guard let token = loginResponse.access_token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        } .resume()
    }
    
    
    //func sendGet() {
    //    guard let url = URL(string: "https://example.com/login") else {
    //        print("Invalid URL")
    //        return
    //    }
    //
    //    URLSession.shared.dataTask(with: request) { (data, response, error) in
    //
    //        if let error = error {
    //            print("Error 1")
    //        } else if let data = data {
    //            if let decodedData = try? JSONDecoder().decode(a, from: <#T##Data#>)
    //        }
    //
    //    } .resume()    }
    
}
