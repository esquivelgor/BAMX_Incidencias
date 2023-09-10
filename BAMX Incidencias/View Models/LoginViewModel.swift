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
    
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(username: username, password: password) {
            result in switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.invalid = true
            }
        }
    }
    
    func signout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
    func passwordForgotten() {
        print("Password forgotten!!")
    }
}
