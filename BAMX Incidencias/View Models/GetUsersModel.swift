//
//  GetUsersModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/19/23.
//

import Foundation

class GetUsersViewModel: ObservableObject {
    @Published var usersData: UsersData?

        init() {
            loadDetails()
        }

        func loadDetails() {
            let defaults = UserDefaults.standard
            if let storedData = defaults.data(forKey: "usersData") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(UsersData.self, from: storedData) {
                    usersData = decoded
                }
            }
        }

    func getUsers() {
        let defaults = UserDefaults.standard
        guard let access_token = defaults.string(forKey: "access_token") else {
            return
        }

        Webservice().getUsers(access_token: access_token) { result in
            switch result {
            case .success(let response):
                do {
                    let encoder = JSONEncoder()
                    if let encodedData = try? encoder.encode(response) {
                        defaults.set(encodedData, forKey: "usersData")
                    }
                    
                    DispatchQueue.main.async {
                        self.usersData = response
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
