//
//  GetTicketsModel.swift
//  BAMX Incidencias
//
//  Created by Gdaalumno on 17/10/23.
//

import Foundation

class GetTicketsViewModel: ObservableObject {
    @Published var incidentResponse: IncidentResponse?

        init() {
            loadDetails()
        }

        func loadDetails() {
            let defaults = UserDefaults.standard
            if let storedData = defaults.data(forKey: "incidentResponse") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(IncidentResponse.self, from: storedData) {
                    incidentResponse = decoded
                }
            }
        }

    func getTickets() {
        let defaults = UserDefaults.standard
        guard let access_token = defaults.string(forKey: "access_token") else {
            return
        }

        Webservice().getTickets(access_token: access_token) { result in
            switch result {
            case .success(let incidentResponse):
                do {
                    let encoder = JSONEncoder()
                    if let encodedData = try? encoder.encode(incidentResponse) {
                        defaults.set(encodedData, forKey: "incidentResponse")
                    }
                    print("Data done!\(incidentResponse.total)")
                    DispatchQueue.main.async {
                        self.incidentResponse = incidentResponse
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
