//
//  ContentView.swift
//  BAMX Incidencias
//
//  Created by velgor on 26/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingDetailView = false
    @StateObject var vm =  ViewModel()
    
    var body: some View {
            if !vm.authenticated {
                // Show the view you want users to see when logged on
                VStack(spacing: 20) {
                    Text("Welcome back **\(vm.username.lowercased())**!")
                    Text("Today is: **\(Date().formatted(.dateTime))**")
                    Button("Log out", action: vm.logOut)
                        .tint(.red)
                        .buttonStyle(.bordered)
                }
            } else {
                NavigationView {
                    ZStack {
                        Image("bg")
                            .resizable()
                            .cornerRadius(20)
                            .ignoresSafeArea()
                            .blur(radius: 110)
                    
                        VStack(alignment: .center, spacing: 30) {
                            Image("bamx")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250, alignment: .center)
                                .padding()
                            TextField("Usuario", text: $vm.username)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .cornerRadius(15)
                            SecureField("Contraseña", text: $vm.password)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .privacySensitive()
                                .cornerRadius(15)
                        }
                        .alert("No tienes acceso", isPresented: $vm.invalid) {
                            Button("Dismiss", action: vm.logPressed)
                        }
                        .frame(width: 300)
                        .padding()
                    }
                    .transition(.offset(x: 0, y: 850))
                    
                }
                .navigationTitle("Login")
            }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
