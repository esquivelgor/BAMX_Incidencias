//
//  CreatedIncidenciaView.swift
//  BAMX Incidencias
//
//  Created by user245071 on 10/6/23.
//

import SwiftUI

struct CreatedIncidenciaView: View {
    @State private var showMenu: Bool = false
    @State private var showFloatingMenu: Bool = true

    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var isEditing = false
    @State private var category = "Mantenimiento"
    @State private var dateCreated = "12/10/23"
    @State private var subject = "Apagon"
    @State private var status = "Cerrado" 
    @State private var description = "LoremIpsum"
    @State private var idIncidencia = 114

    var body: some View {
        NavigationView {
        ZStack {
            VStack (alignment: .leading) {
                Text("Incidencia #\(idIncidencia)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0xE2032C))
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                Divider()
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 20){
                        HStack{
                            VStack (alignment: .center){
                                Section {
                                    Text("Categoria")
                                        .foregroundColor(Color(hex: 0xE2032C))
                                    if isEditing {
                                        TextField("Enter Name", text: $category)
                                    } else {
                                        Text(category)
                                            .font(.headline)
                                    }
                                }
                            }
                            Spacer()

                            VStack (alignment: .center){
                                Section {
                                    Text("Fecha Creada")
                                        .foregroundColor(Color(hex: 0xE2032C))
                                    Text(dateCreated)
                                        .font(.headline)

                                }
                            }

                        }
                        HStack{
                            VStack (alignment: .center){
                                Section {
                                    Text("Asunto")
                                        .foregroundColor(Color(hex: 0xE2032C))
                                    if isEditing {
                                        TextField("Enter Name", text: $subject)
                                    } else {
                                        Text(subject)
                                            .font(.headline)
                                    }
                                }
                            }
                            Spacer()

                            VStack{
                                Section {
                                    Text("Estatus")
                                        .foregroundColor(Color(hex: 0xE2032C))
                                    if isEditing {
                                        TextField("Enter Name", text: $status)
                                    } else {
                                        Text(status)
                                            .font(.headline)
                                    }
                                }
                            }

                        }
                        HStack{
                            VStack{
                                Text("Descripcion")
                                    .foregroundColor(Color(hex: 0xE2032C))
                                if isEditing {
                                    TextField("Enter Name", text: $description)
                                } else {
                                    Text(description)
                                        .font(.headline)
                                }
                            }
                            
                        }
                        HStack {
                            VStack{
                                Text("Archivo adjunto")
                                    .foregroundColor(Color(hex: 0xE2032C))
                                Image(uiImage: self.image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .background(Color.black.opacity(0.2))
                                    .aspectRatio(contentMode: .fill)
                            }
                            
                        }
                        
                        Section {
                            if status == "Abierto" {
                                if isEditing {
                                    Button("Save", action: {
                                        isEditing.toggle()
                                    })
                                    .buttonStyle(.borderedProminent)
                                    .tint(Color(hex: 0x29A835))
                                    .cornerRadius(50)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                } else {
                                    Button("Edit", action: {
                                        isEditing.toggle()
                                    })
                                    .buttonStyle(.borderedProminent)
                                    .tint(Color(hex: 0xFABB02))
                                    .cornerRadius(50)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }

                            
                        VStack(alignment: .center) {
                            if status == "Abierto" {
                                Text("Esta incidencia no ha sido resuelta")
                                    .foregroundColor(Color(hex: 0xE2032C))
                                    .padding()
                                    .cornerRadius(20)
                                    .padding(.top, 20)
                            } else if status == "Cerrado" {
                                Text("Esta incidencia ha sido resuelta")
                                    .foregroundColor(Color(hex: 0x00FF00)) // Green color for resolved status
                                    .padding()
                                    .cornerRadius(20)
                                    .padding(.top, 20)
                            } else {
                                Text("Estado desconocido")
                                    .foregroundColor(.black) // Default text color for unknown status
                                    .padding()
                                    .cornerRadius(20)
                                    .padding(.top, 20)
                            }
                        }

                            
                        }
                    .padding(.horizontal, 16)
                }
                
            }
            .padding(20)
                    
            
          GeometryReader { _ in
            
            HStack {
              Spacer()
              
              SideMenuView()
                .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                .animation(.easeInOut(duration: 0.4), value: showMenu)
            }
            
          }
          .background(Color.black.opacity(showMenu ? 0.5 : 0))
            
            if (showFloatingMenu == true) {
                ZStack (alignment: .bottomTrailing){
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    FloatingMenu()
                        .padding()
                }
            }
          
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

}
struct CreatedIncidenciaView_Previews: PreviewProvider {
    static var previews: some View {
        CreatedIncidenciaView()
    }
}
