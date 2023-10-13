//
//  GetMeModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/11/23.
//

import Foundation

class GetMeViewModel: ObservableObject {
    @Published var meDetails: MeDetails?

        init() {
            loadMeDetails()
        }

        func loadMeDetails() {
            let defaults = UserDefaults.standard
            if let storedData = defaults.data(forKey: "MeDetails") {
                let decoder = JSONDecoder()
                if let decodedMeDetails = try? decoder.decode(MeDetails.self, from: storedData) {
                    meDetails = decodedMeDetails
                }
            }
        }

    func getMe() {
        let defaults = UserDefaults.standard
        guard let access_token = defaults.string(forKey: "access_token") else {
            return
        }
        
        Webservice().getMe(access_token: access_token) { result in
            switch result {
            case .success(let meDetails):
                do {
                    let encoder = JSONEncoder()
                    if let encodedData = try? encoder.encode(meDetails) {
                        defaults.set(encodedData, forKey: "MeDetails")
                    }
                    print("Data done!\(meDetails.first_name)")
                    DispatchQueue.main.async {
                        self.meDetails = meDetails
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
