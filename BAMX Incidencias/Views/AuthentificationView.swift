//
//  Authentification.swift
//  BAMX Incidencias
//
//  Created by velgor on 26/08/23.
//

import SwiftUI

struct AuthentificationView: View {
    @State private var isShowingDetailView = false
    @StateObject private var loginVM =  LoginViewModel()
    
    var body: some View {
        NavigationLink(destination: AppHome(), isActive: $loginVM.isAuthenticated){
            EmptyView()
        }
    }
}

struct Authentification_Previews: PreviewProvider {
    static var previews: some View {
        AuthentificationView()
    }
}
