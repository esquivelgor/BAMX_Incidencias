//
//  requestView.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/20/23.
//

import SwiftUI

struct RequestView: View {

    @State private var showAlert = false
    @StateObject private var getEmailVM =  GetEmailViewModel()
    
    private var isFormValid: Bool {
        return isValidEmail(getEmailVM.email)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informacion de la cuenta")) {
                    TextField("Email", text: $getEmailVM.email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                }
                Spacer(minLength: 450)
                
                HStack {
                    Spacer()
                    Button("Enviar") {
                        if isFormValid {
                            showAlert = true
                            getEmailVM.sendEmail()
                        } else {
                            showAlert = true
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        if isFormValid {
                            return Alert(title: Text("Enviado"), message: Text("Solicitud enviada con exito, espera tu confirmacion"), dismissButton: .default(Text("Okay")))
                        } else {
                            return Alert(title: Text("Error"), message: Text("El formato del correo electrónico no es válido. Por favor, corrige el campo de correo electrónico."), dismissButton: .default(Text("Okay")))
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .cornerRadius(50)
                    Spacer()
                }
            }
            .navigationBarTitle("Solicitud de Acceso")
        }
    }
}

struct requestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}



