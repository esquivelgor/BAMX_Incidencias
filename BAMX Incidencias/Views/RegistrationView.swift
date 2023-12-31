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
    @State private var showPositiveAlert = false
    @State private var showNegativeAlert = false
    
    @State private var selectedOp = "Rol 1"
    let rolls = ["Rol 1", "Rol 2", "Rol 3"]

    private var isFormValid: Bool {
        return !name.isEmpty && !forename.isEmpty && isValidEmail(email) && password == confirmPassword && agreedToTerms
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informacion personal")) {
                    TextField("Nombre", text: $name)
                    TextField("Apellido", text: $forename)
                    Picker("Rol", selection: $selectedOp) {
                        ForEach(rolls, id: \.self) {
                            Text($0)
                        }
                    }
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
                    HStack {
                        Spacer()
                        Button("Enviar") {
                            if isFormValid {
                                showPositiveAlert = true
                            } else {
                                showNegativeAlert = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        .cornerRadius(50)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Nuevo Usuario")
            .alert(isPresented: $showPositiveAlert) {
                Alert(title: Text("Enviado!"), message: Text("Solicitud enviada con exito, espera tu confirmacion!"), dismissButton: .default(Text("Okay")))
            }
            .alert(isPresented: $showNegativeAlert) {
                Alert(title: Text("Cuidado!"), message: Text("Porfavor, llena todos los campos correspondientes!"), dismissButton: .default(Text("Okay")))
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
