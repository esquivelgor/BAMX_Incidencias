//
//  GetMeModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/11/23.
//

import Foundation

class GetMeViewModel: ObservableObject {

    @Published var meDetails: [MeDetails] = []
    
    func getMe() {
        let defaults = UserDefaults.standard
        guard let access_token = defaults.string(forKey: "access_token") else {
            return
        }
        
        Webservice().getMe(access_token: access_token) { result in switch result {
            case .success(let MeDetails):
                do {
                    let encoder = JSONEncoder()
                    if let encodedData = try? encoder.encode(MeDetails) {
                        defaults.set(encodedData, forKey: "MeDetails")
                    }
                }
                DispatchQueue.main.async {
                    self.meDetails = MeDetails
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
