//
//  incidentsView.swift
//  BAMX Incidencias
//
//  Created by user245071 on 9/30/23.
//

import SwiftUI

import Foundation

class WebService {
    static func postTicket(topic: String, description: String, urgency: String, completion: @escaping (Result<String, Error>) -> Void) {
    }
}

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
    
    @State private var showMenu: Bool = false
    var body: some View {
        NavigationView {
        
        ZStack {
            VStack (alignment: .leading) {
                Text("Nueva Incidencia")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0xE2032C))
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                Divider()
                Form {
                    Section(header: Text("Llene los campos correspondientes")) {
                        VStack(alignment: .leading) {
                            Text("Asunto")
                            TextField("Asunto", text: $topic)
                        }
                        VStack(alignment: .leading) {
                            Picker("Categoria", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) {
                                    Text($0)
                                }
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
                                .background(Color(hex: 0xE2032C))
                            
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
                            VStack {
                                Spacer()
                                Button("Enviar") {
                                    if isFormValid {
                                        showAlert = true
                                        showNegativeAlert = false
                                        submitTicket()
                                        print("a")
                                    } else {
                                        showAlert = true
                                        showNegativeAlert = true
                                        print("b")
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(Color(hex: 0xE2032C))
                                .cornerRadius(50)
                                .frame(maxWidth: .infinity, alignment: .center) // Center-align the button vertically
                                
                                Spacer()
                                Button("Guardar") {
                                    // Your save logic here
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(Color(hex: 0xFABB02))
                                .cornerRadius(50)
                                .frame(maxWidth: .infinity, alignment: .center) // Center-align the button vertically
                            }
                        }
                    }
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
                    
            
          GeometryReader { _ in
            
            HStack {
              Spacer()
              
              SideMenuView()
                .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                .animation(.easeInOut(duration: 0.4), value: showMenu)
            }
            
          }
          .background(Color.black.opacity(showMenu ? 0.5 : 0))
          
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          
          Button {
            self.showMenu.toggle()
          } label: {
            
            if showMenu {
              
              Image(systemName: "xmark")
                .font(.title)
                .foregroundColor(.white)
              
            } else {
              Image(systemName: "text.justify")
                .font(.title)
                .foregroundColor(Color(hex: 0xE2032C))
            }
            
          }
        }
      }
        .navigationBarBackButtonHidden(true)
    }
    func submitTicket() {
        WebService.postTicket(topic: topic, description: description, urgency: selectedPriority) { result in
            switch result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



struct incidentsView_Previews: PreviewProvider {
    static var previews: some View {
        incidentsView()
    }
}
