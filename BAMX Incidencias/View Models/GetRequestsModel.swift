//
//  GetRequestsModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/15/23.
//

import Foundation

class GetRequestsViewModel: ObservableObject {
    @Published var ticketData: TicketData?

        init() {
            loadDetails()
        }

        func loadDetails() {
            let defaults = UserDefaults.standard
            if let storedData = defaults.data(forKey: "ticketData") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(TicketData.self, from: storedData) {
                    ticketData = decoded
                }
            }
        }

    func getRequests() {
        let defaults = UserDefaults.standard
        guard let access_token = defaults.string(forKey: "access_token") else {
            return
        }
        
        Webservice().getRequests(access_token: access_token) { result in
            switch result {
            case .success(let ticketData):
                do {
                    let encoder = JSONEncoder()
                    if let encodedData = try? encoder.encode(ticketData) {
                        defaults.set(encodedData, forKey: "ticketData")
                    }
                    print("Data done!\(ticketData.total)")
                    DispatchQueue.main.async {
                        self.ticketData = ticketData
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
