//
//  Authentification.swift
//  BAMX Incidencias
//
//  Created by velgor on 26/08/23.
//

import SwiftUI

struct AuthentificationView: View {
    @State private var isShowingDetailView = false
    @EnvironmentObject var loginVM : LoginViewModel
    
    @State private var showLoginAlert = false
    @State private var showPasswordAlert = false
    
    var body: some View {
        if loginVM.isAuthenticated {
            AppHome().environmentObject(loginVM)
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
                            Button("Olvide la contrasena") {
                                showPasswordAlert = true
                                loginVM.passwordForgotten()
                            }
                            .alert(isPresented: $showPasswordAlert) {
                                Alert(
                                    title: Text("Enviado"),
                                    message: Text("Espere por una solucion por parte del los administradores"),
                                    dismissButton: .default(Text("Okay"))
                                )
                            }
                            .tint(.red.opacity(0.8))
                            
                            Spacer()
                            
                            Button("Log in"){
                                loginVM.login()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                    if !loginVM.isAuthenticated {
                                        showLoginAlert = true
                                    }
                                }
                            }
                            .alert(isPresented: $showLoginAlert) {
                                Alert(
                                    title: Text("No tienes acceso"),
                                    dismissButton: .default(Text("Cerrar"))
                                )
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
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
