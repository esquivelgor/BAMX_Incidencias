//
//  GetEmailModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/5/23.
//

import Foundation

class GetEmailViewModel: ObservableObject {
    
    var email: String = ""
    func sendEmail() {
        
        Webservice().sendEmail(email: email) { result in
            switch result {
            case .success(let response):
                print("Email sent successfully. Response: \(response)")
            case .failure(let error):
                print("Failed to send email. Error: \(error.localizedDescription)")
            }
        }
    }
}
