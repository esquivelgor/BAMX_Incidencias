//
//  RegistrationView.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/1/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var forename = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreedToTerms = false
    @State private var showAlert = false
    @State private var selectedOp = "Rol 1"
    let rolls = ["Rol 1", "Rol 2", "Rol 3"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informacion personal")) {
                    TextField("Nombre", text: $name)
                    TextField("Apellido", text: $forename)
                    //TextField("Rol", text: $roll)
                    Picker("Rol", selection: $selectedOp) {
                        ForEach(rolls, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                }
                
                Section(header: Text("Informacion de la cuenta")) {
                    TextField("Email", text: $email)
                    SecureField("Contrasena", text: $password)
                    SecureField("Confirma la contrasena", text: $confirmPassword)
                }
                
                Section {
                    Toggle("He leido y aceptado los terminos y condiciones", isOn: $agreedToTerms)
                }
                
                Section {
                    HStack{
                        Spacer()
                        Button("Enviar") {
                            if isFormValid() {
                                showAlert = true
                            }
                        }
                        .disabled(!isFormValid())
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        .cornerRadius(50)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Nuevo Usuario")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Enviado!"), message: Text("Solicitud enviada con exito, espera tu confirmacion!"), dismissButton: .default(Text("Ok")))
            }
        }
    }

    private func isFormValid() -> Bool {
        return !name.isEmpty && !forename.isEmpty && !email.isEmpty && !password.isEmpty && password == confirmPassword && agreedToTerms
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
