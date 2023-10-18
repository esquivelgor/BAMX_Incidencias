//
//  Login-ViewModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/7/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    
    @Published var isAuthenticated: Bool = false
    @Published var invalid: Bool = false
    @Published var loginAlert: Bool = false
    @Published var passwordAlert: Bool = false
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(username: username, password: password) { result in switch result {
        case .success(let token):
            defaults.setValue(token, forKey: "access_token")
            DispatchQueue.main.async {
                self.isAuthenticated = true
            }
        case .failure(let error):
            print(error.localizedDescription)
            self.loginAlert = true
            self.invalid = true
            print("Not login")
        }
        }
    }

    func signout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "access_token")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
    func passwordForgotten() {
        print("The user has forgot his password!!")
    }
}
