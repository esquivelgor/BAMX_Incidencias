//
//  incidentsView.swift
//  BAMX Incidencias
//
//  Created by user245071 on 9/30/23.
//

import SwiftUI
import Foundation

struct incidentsView: View {
    
    @State private var pictures = ""
    @State private var caption = ""
    @State private var navigateToAppHome = false
    
    @State private var showAlert = false
    @State private var showNegativeAlert = false
    @State private var showMenu: Bool = false
    @State private var showSheet = false
    @State private var image = UIImage()
    
    @StateObject var postTicketVM = PostTicketModel()
    
    private var isFormValid: Bool {
        return (!postTicketVM.topic.isEmpty && !postTicketVM.category.isEmpty && !postTicketVM.description.isEmpty && !postTicketVM.urgency.isEmpty)
    }
    
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
                            HStack {
                                Text("Asunto: ")
                                TextField("", text: $postTicketVM.topic)
                            }
                            VStack(alignment: .leading) {
                                Picker("Categoria", selection: $postTicketVM.category) {
                                    ForEach(postTicketVM.categories, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Picker("Prioridad", selection: $postTicketVM.urgency) {
                                    ForEach(postTicketVM.priorities, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                            
                            // HStack {
                            //     Image(uiImage: self.image)
                            //         .resizable()
                            //         .frame(width: 100, height: 100)
                            //         .background(Color.black.opacity(0.2))
                            //         .aspectRatio(contentMode: .fill)
                            //
                            //     Text("Adjuntar archivo")
                            //         .frame(maxWidth: .infinity)
                            //         .frame(height: 30)
                            //         .background(Color(hex: 0xE2032C))
                            //
                            //         .cornerRadius(16)
                            //         .foregroundColor(.white)
                            //         .padding(.horizontal, 10)
                            //         .onTapGesture {
                            //             showSheet = true
                            //         }
                            // }
                            // .padding(.horizontal, 20)
                            // .sheet(isPresented: $showSheet) {
                            //     // To take the picture from the library
                            //     ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                            //
                            //     //  If you wish to take a photo from camera instead:
                            //     //ImagePicker(sourceType: .camera, selectedImage: self.$image)
                            //
                            // }
                            
                            HStack {
                                Text("Descripcion: ")
                                TextField("", text: $postTicketVM.description)
                            }
                            
                            VStack (alignment: .leading) {
                                Section {
                                    VStack {
                                        Spacer()
                                        Button("Enviar") {
                                            if isFormValid {
                                                postTicketVM.postTicket()
                                            }
                                            showAlert = true
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .tint(Color(hex: 0xE2032C))
                                        .cornerRadius(50)
                                        .frame(maxWidth: .infinity, alignment: .center) // Center-align the button vertically
                                        .alert(isPresented: $showAlert) {
                                            if !isFormValid {
                                                return Alert(
                                                    title: Text("Error!"),
                                                    message: Text("Revisa tus datos nuevamente, algo no está bien!"),
                                                    dismissButton: .default(Text("Okay"))
                                                )
                                            } else {
                                                return Alert(
                                                    title: Text("Enviado!"),
                                                    message: Text("Solicitud enviada con éxito, espera tu confirmación!"),
                                                    dismissButton: .default(
                                                        Text("Okay"))//,
                                                        //action: {
                                                        //    navigateToAppHome = true
                                                        //    // Perform any action upon dismissing the alert if needed
                                                        //})
                                                )
                                                
                                            }
                                        }
                                        
                                        //NavigationLink(
                                        //    destination: AppHome(),
                                        //    isActive: $navigateToAppHome,
                                        //    label: { EmptyView() }
                                        //)
                                        Spacer()
                                        
                                    }
                                }
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
}



struct incidentsView_Previews: PreviewProvider {
    static var previews: some View {
        incidentsView()
    }
}
