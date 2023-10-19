//
//  PostTicketModel.swift
//  BAMX Incidencias
//
//  Created by user245071 on 10/18/23.
//

import Foundation

class PostTicketModel: ObservableObject {
    
    var topic: String = ""
    var category: String = ""
    var description: String = ""
    var urgency: String = ""
    
    func postTicket() {
        Webservice().postTicket(topic: topic, category: category, description: description, urgency: urgency){ result in
            switch result {
            case .success(let response):
                print("Email sent successfully. Response: \(response)")
            case .failure(let error):
                print("Failed to send email. Error: \(error.localizedDescription)")
            }
        }
    }
}
