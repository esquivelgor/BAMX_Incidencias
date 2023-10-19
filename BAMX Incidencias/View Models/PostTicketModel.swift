//
//  PostTicketModel.swift
//  BAMX Incidencias
//
//  Created by user245071 on 10/18/23.
//

import Foundation

class PostTicketModel: ObservableObject {
    
    @Published var topic: String = ""
    @Published var category: String = "Seleccionar"
    @Published var description: String = ""
    @Published var urgency: String = "Seleccionar"
    var categories = ["Seleccionar","tecnic", "logistic", "administrative"]
    var priorities = ["Seleccionar","low", "medium", "high"]

    func postTicket() {
        
        let defaults = UserDefaults.standard
        guard let access_token = defaults.string(forKey: "access_token") else {
            return
        }
        
        Webservice().postTicket(access_token: access_token, topic: topic, category: category, description: description, urgency: urgency){ result in
            switch result {
            case .success(let response):
                print("Email sent successfully. Response: \(response)")
            case .failure(let error):
                print("Failed to send email. Error: \(error.localizedDescription)")
            }
        }
    }
}
