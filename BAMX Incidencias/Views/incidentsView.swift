//
//  incidentsView.swift
//  BAMX Incidencias
//
//  Created by user245071 on 9/30/23.
//

import SwiftUI

struct incidentsView: View {
    
    @State private var topic = ""
    @State private var category = ""
    @State private var priority = ""
    @State private var pictures = ""
    @State private var description = ""
    @State private var caption = ""
    
    @State private var showAlert = false
    @State private var showNegativeAlert = false
    
    @State private var selectedCategory = "Seleccionar"
    let categories = ["Seleccionar","Tecnica", "Logistica", "Administrativa"]
    
    @State private var selectedPriority = "Seleccionar"
    let priorities = ["Seleccionar","Baja", "Media", "Alta"]
    
    @State private var image = UIImage()
    @State private var showSheet = false
    
    private var isFormValid: Bool {
        return !topic.isEmpty
    }
    
    var body: some View {
        NavigationView
        {
            Form {
                Section(header: Text("Informacion del ticket")) {
                    TextField("Asunto", text: $topic)
                    Picker("Categoria", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Prioridad", selection: $selectedPriority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    HStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                        
                        Text("Adjuntar archivo")
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .background(Color(red: 226/255, green: 3/255, blue: 44/255))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                showSheet = true
                            }
                    }
                    .padding(.horizontal, 20)
                    .sheet(isPresented: $showSheet) {
                        // To take the picture from the library
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        
                        //  If you wish to take a photo from camera instead:
                        //ImagePicker(sourceType: .camera, selectedImage: self.$image)
                        
                    }
                    TextField("Descripcion", text: $description)
                    Section {
                        HStack {
                            Spacer()
                            Button("Enviar") {
                                if isFormValid {
                                    showAlert = true
                                    showNegativeAlert = false
                                    print("a")
                                } else {
                                    showAlert = true
                                    showNegativeAlert = true
                                    print("b")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .cornerRadius(50)
                            
                            Spacer()
                        }
                    }                }
                .navigationBarTitle("Nueva Incidencia")
                .alert(isPresented: $showAlert) {
                    if showNegativeAlert {
                        return Alert(
                            title: Text("Error!"),
                            message: Text("Revisa tus datos nuevamente, algo no está bien!"),
                            dismissButton: .default(Text("Okay"))
                        )
                    } else {
                        return Alert(
                            title: Text("Enviado!"),
                            message: Text("Solicitud enviada con éxito, espera tu confirmación!"),
                            dismissButton: .default(Text("Okay"))
                        )
                    }
                }
            }
        }
    }
}



struct incidentsView_Previews: PreviewProvider {
    static var previews: some View {
        incidentsView()
    }
}
