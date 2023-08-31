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
                //NavigationView{
                //    VStack(spacing: 30){
                //        Image("bamx")
                //            .aspectRatio(contentMode: .fit)
                //            .frame(width: 250, height: 250, alignment: .center)
                //            .padding()
                //
                //        Text("Iniciar Sesión")
                //            .fontWeight(.bold)
                //            .frame(width: 170, height: 40, alignment: .center)
                //            .background(Color.red)
                //            .foregroundColor(.white)
                //            .cornerRadius(100)
                //
                //        NavigationLink(
                //            destination: SplashScreenView(),
                //            label: {
                //                Text("Registrarme")
                //            }
                //        )
                //    }
                //    .navigationTitle("Login")
                //}                // Show a login screen
                ZStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer()
                        Text("Log in")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .medium, design: .rounded))
                            .underline()

                        TextField("Username", text: $vm.username)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                        SecureField("Password", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .privacySensitive()
                        HStack {
                            Spacer()
                            Button("Forgot password?", action: vm.logPressed)
                                .tint(.red.opacity(0.80))
                            Spacer()
                            Button("Log on",role: .cancel, action: vm.authenticate)
                                .buttonStyle(.bordered)
                            Spacer()
                        }
                        Spacer()
                    }
                    .alert("Access denied", isPresented: $vm.invalid) {
                        Button("Dismiss", action: vm.logPressed)
                    }
                    .frame(width: 300)
                    .padding()
                }
                .transition(.offset(x: 0, y: 850))
            }
        }
}
            
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
