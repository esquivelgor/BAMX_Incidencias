//
//  AppHome.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/9/23.
//

import SwiftUI

struct AppHome: View {
    @StateObject private var loginVM =  LoginViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Bienvenido a la pagina de inicio! **\(loginVM.username.lowercased())**!")
            Text("Hoy es: **\(Date().formatted(.dateTime))**")
            Button("Log out", action: loginVM.signout)
                .tint(.red)
                .buttonStyle(.bordered)

        }
    }
}

struct AppHome_Previews: PreviewProvider {
    static var previews: some View {
        AppHome()
    }
}
