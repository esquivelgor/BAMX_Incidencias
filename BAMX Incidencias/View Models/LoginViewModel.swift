//
//  Login-ViewModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/7/23.
//

import Foundation

struct TokenManager {
    static var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    static func clearAccessToken() {
        UserDefaults.standard.removeObject(forKey: "access_token")
    }
}

class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var invalid: Bool = false
    @Published var loginAlert: Bool = false
    @Published var passwordAlert: Bool = false
    func login() {
        
        Webservice().login(username: username, password: password) {
            result in switch result {
            case .success(let token):
                UserDefaults.standard.setValue(token, forKey: "access_token")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    print("True")
                }
            case .failure(let error):
                self.loginAlert = true
                print(error.localizedDescription)
                self.invalid = true
            }
        }
        
    }

    
    func signout() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
    func passwordForgotten() {
        print("The user has forgot his password!!")
    }
}
