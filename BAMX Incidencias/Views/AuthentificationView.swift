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
        if loginVM.isAuthenticated {
            AppHome()
        } else {
            NavigationView {
                ZStack {
                    VStack(alignment: .center, spacing: 30) {
                        Image("bamx")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 300, alignment: .center)
                            .padding()
                        TextField("Usuario", text: $loginVM.username)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .cornerRadius(15)
                        SecureField("Contraseña", text: $loginVM.password)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .privacySensitive()
                        HStack {
                            Spacer()
                            Button("Olvide la contrasena", action: loginVM.passwordForgotten)
                                .tint(.red.opacity(0.8))
                            Spacer()
                            Button("Log in"){
                                loginVM.login()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            Spacer()
                        }
                        Spacer()
                        HStack{
                            NavigationLink(destination: RegistrationView(), label: {
                                Text("Registrarme")
                                    .foregroundColor(.red)
                                
                            })
                            Spacer()
                            NavigationLink(destination: RequestView(), label: {
                                Text("Solicitar Acceso")
                                    .foregroundColor(.red)
                                
                            })
                            
                        }
                    }
                    .frame(width: 300)
                    .padding()
                    .alert("No tienes acceso", isPresented: $loginVM.invalid) {
                        Button("Cerrar", action: loginVM.passwordForgotten)
                    }
                    .alert(isPresented: $loginVM.passwordAlert) {
                        Alert(title: Text("Enviado!"), message: Text("Espera por una solucion por parte del los administradores!"), dismissButton: .default(Text("Okay"))
                        )
                    }
                }
                .transition(.offset(x: 0, y: 850))
                
            }
        }
    }
}

struct Authentification_Previews: PreviewProvider {
    static var previews: some View {
        AuthentificationView()
    }
}
