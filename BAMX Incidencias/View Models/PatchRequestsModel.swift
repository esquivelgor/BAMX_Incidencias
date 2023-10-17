//
//  PatchRequestsModel.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/16/23.
//
import Foundation

class PatchRequestsViewModel: ObservableObject {

    var _id: String = ""
    var state: String = ""

    func patchRequests() {
        let defaults = UserDefaults.standard
        guard let access_token = defaults.string(forKey: "access_token") else {
            return
        }

        Webservice().patchRequests(access_token: access_token, state: state, _id: _id) { result in
            if case .success(200) = result {
                print("Success with code 200")
            } else {
                print("Request failed or returned a code other than 200")
            }
        }
    }
}


