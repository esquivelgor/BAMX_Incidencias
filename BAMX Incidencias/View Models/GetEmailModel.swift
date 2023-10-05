//
//  GetEmailModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/5/23.
//

import Foundation

class GetEmailViewModel: ObservableObject {
    
    var email: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var invalid: Bool = false
    @Published var loginAlert: Bool = false
    @Published var passwordAlert: Bool = false
    func sendEmail() {
        
        Webservice().sendEmail(email: email) { result in
            switch result {
            case .success(let response):
                // Handle success, for example, print the response
                print("Email sent successfully. Response: \(response)")
            case .failure(let error):
                // Handle failure, for example, show an error message
                print("Failed to send email. Error: \(error.localizedDescription)")
            }
        }
        
    }

    func test() {
        print("Test!!")
        self.passwordAlert = true
    }
}
