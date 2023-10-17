//
//  WebService.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/11/23.
//
import Foundation

// Errors

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

// ----------------- Request Body

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

struct GetEmailRequestBody: Codable {
    let email: String
}

struct UpdateRequestBody: Codable {
    let state: String
}

//struct TicketRequestBody: Codable {
//    let title: String
//    let category: String
//    let description: String
//    let urgency: String
//}

class Webservice {
    
    // Post
    
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
        
            guard let loginResponse = try? JSONDecoder().decode(UserResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.access_token else {
                completion(.failure(.invalidCredentials))
                return
            }
        
            completion(.success(token))
        } .resume()
    }
    
    //func postTicket(access_token: String, topic: String, description: String, urgency: String, completion: @escaping (Result<Int, NetworkError>) -> Void) {
    //    guard let url = URL(string: "https://food-bank-api.onrender.com/tickets") else {
    //        completion(.failure(.invalidURL))
    //        return
    //    }
    //
    //    var request = URLRequest(url: url)
    //    request.httpMethod = "POST"
    //    request.setValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
    //
    //    request.setValue(
    //        "application/json;charset=utf-8",
    //        forHTTPHeaderField: "Content-Type"
    //    )
    //    let body = TicketRequestBody(title: topic, description: description, urgency: urgency)
    //
    //    URLSession.shared.dataTask(with: request) { _, response, error in
    //        if let error = error {
    //            completion(.failure(NetworkError.invalidURL))
    //            return
    //        }
    //
    //        guard let httpResponse = response as? HTTPURLResponse else {
    //            completion(.failure(NetworkError.decodingError))
    //            return
    //        }
    //
    //        completion(.success(httpResponse.statusCode))
    //    }.resume()
    //
    //}
    //
    // Get
    
    func sendEmail(email: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "https://food-bank-api.onrender.com/requests/auth") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = GetEmailRequestBody(email: email)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.custom(errorMessage: "No HTTP response")))
                return
            }
            
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response Data: \(responseString ?? "Empty")")
            }
                    
            if httpResponse.statusCode == 200 {
                completion(.success("\(httpResponse.statusCode)"))
                print("Success! \(httpResponse.statusCode)")
            } else {
                completion(.failure(.custom(errorMessage: "Wrong statusCode \(httpResponse.statusCode)")))
            }
            
        } .resume()
    }
    
    func getMe(access_token: String, completion: @escaping (Result<MeDetails, NetworkError>) -> Void) {
        guard let url = URL(string: "https://food-bank-api.onrender.com/me") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")

        request.setValue(
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )

        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error {
                    throw error
                }
                guard let data = data else {
                    throw NetworkError.noData
                }
                let me = try JSONDecoder().decode(MeDetails.self, from: data) // Decode as an array
                completion(.success(me))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getRequests(access_token: String, completion: @escaping (Result<TicketData, NetworkError>) -> Void) {
        guard let url = URL(string: "https://food-bank-api.onrender.com/requests") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")

        request.setValue(
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )

        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error {
                    throw error
                }
                guard let data = data else {
                    throw NetworkError.noData
                }
                let decodedData = try JSONDecoder().decode(TicketData.self, from: data) // Decode as an array
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    // Patch
    
    func patchRequests(access_token: String, state: String,_id: String, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        guard let url = URL(string: "https://food-bank-api.onrender.com/tickets/\(_id)") else {
            completion(.failure(.invalidURL))
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
    
        request.setValue(
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        let body = UpdateRequestBody(state: state)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if error != nil {
                completion(.failure(NetworkError.decodingError))
                return
            }
    
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.decodingError))
                return
            }
    
            completion(.success(httpResponse.statusCode))
        }.resume()
    
    }
        
    
    
    
}


