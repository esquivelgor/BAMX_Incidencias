//
//  LoginView.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/19/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM =  LoginViewModel()
    @State private var fieldsIncompleted = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center, spacing: 30) {
                    Image("bamx")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 300, alignment: .center)
                        .padding()
                    TextField("Usuario", text: $loginVM.username)
                        .padding()
                        .background()
                        .textInputAutocapitalization(.never)
                        .cornerRadius(25)
                        .shadow(radius: 5, x:5, y:10)
                    
                    SecureField("Contraseña", text: $loginVM.password)
                        .padding()
                        .background()
                        .textInputAutocapitalization(.never)
                        .privacySensitive()
                        .cornerRadius(25)
                        .shadow(radius: 5, x:5, y:10)
                    HStack {
                        Spacer()
                        Button("Olvidé la contraseña", action: loginVM.passwordForgotten)
                            .tint(.red.opacity(0.8))
                        Spacer()
                        Button(action: { loginVM.login() }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 100, height: 50)
                                .background(Color(.red))
                                .cornerRadius(20)
                                .shadow(radius: 5, x:5, y:10)
                        }
                        .padding()
                        Spacer()
                    }
                    Spacer()
                    NavigationLink(destination: RegistrationView(), label: {
                        Text("Registrarme")
                            .foregroundColor(.red)
                        
                    })
                }
                .alert("No tienes acceso", isPresented: $loginVM.invalid) {
                    Button("Cerrar", action: loginVM.passwordForgotten)
                }
                .alert(isPresented: $fieldsIncompleted) {
                    Alert(
                        title: Text("Informacion incompleta"),
                        message: Text("Debes de completar todos los campos"),
                        dismissButton: .default(Text("Ok"))
                    )
                }
                .frame(width: 300)
                .padding()
            }
            .transition(.offset(x: 0, y: 850))
            
        }
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
