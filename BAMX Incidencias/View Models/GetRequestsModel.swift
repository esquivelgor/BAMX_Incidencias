//
//  GetRequestsModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/15/23.
//

import Foundation

class GetRequestsViewModel: ObservableObject {
    @Published var requestData: RequestData?

        init() {
            loadDetails()
        }

        func loadDetails() {
            let defaults = UserDefaults.standard
            if let storedData = defaults.data(forKey: "requestData") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(RequestData.self, from: storedData) {
                    requestData = decoded
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
            case .success(let requestData):
                do {
                    let encoder = JSONEncoder()
                    if let encodedData = try? encoder.encode(requestData) {
                        defaults.set(encodedData, forKey: "requestData")
                    }
                    
                    DispatchQueue.main.async {
                        self.requestData = requestData
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
