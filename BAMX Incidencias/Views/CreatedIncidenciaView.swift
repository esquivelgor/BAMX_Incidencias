//
//  CreatedIncidenciaView.swift
//  BAMX Incidencias
//
//  Created by user245071 on 10/6/23.
//

import SwiftUI

struct CreatedIncidenciaView: View {
    let item: Incident
    
    @State private var showMenu: Bool = false
    @State private var showFloatingMenu: Bool = true
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var isEditing = false
    
    @State private var solution: String = ""
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0xE2032C))
                        .padding(.top, 20)
                        .padding(.leading, 20)
                    
                    if item.state == "pending" {
                        Text("(Pendiente)")
                            .foregroundColor(Color(hex: 0xE2032C))
                            .padding(.leading, 20)
                            .cornerRadius(20)
                        
                    } else if item.state == "solved" {
                        Text("(Resuelta)")
                            .foregroundColor(Color(hex: 0x00FF00))
                            .padding(.leading, 20)
                            .cornerRadius(20)
                    } else {
                        Text("(Estado desconocido)")
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                            .cornerRadius(20)
                    }
                    
                    Divider()
                    
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 20){
                            HStack{
                                VStack (alignment: .center){
                                    Section {
                                        Text("Categoria")
                                            .foregroundColor(Color(hex: 0xE2032C))
                                        Text(item.category ?? "Sin datos")
                                            .font(.headline)
                                    }
                                }
                                Spacer()
                                
                                VStack (alignment: .center){
                                    Section {
                                        Text("Fecha")
                                            .foregroundColor(Color(hex: 0xE2032C))
                                        if let createdAt = dateFormatter.date(from: item.created_at) {
                                            Text(formatDate(createdAt))
                                                .font(.headline)
                                        }
                                    }
                                }
                            }
                            
                            HStack{
                                VStack{
                                    Section {
                                        Text("Descripcion")
                                            .foregroundColor(Color(hex: 0xE2032C))
                                        Text(item.description ?? "Sin descripcion")
                                            .font(.headline)
                                    }
                                }
                                
                                Spacer()
                                
                                VStack{
                                    Section {
                                        Text("Prioridad")
                                            .foregroundColor(Color(hex: 0xE2032C))
                                        
                                        Text(item.urgency)
                                            .font(.headline)
                                    }
                                }
                            }
                            
                            //HStack {
                            //    VStack{
                            //        Text("Archivo adjunto")
                            //            .foregroundColor(Color(hex: 0xE2032C))
                            //        Image(uiImage: self.image)
                            //            .resizable()
                            //            .frame(width: 100, height: 100)
                            //            .background(Color.black.opacity(0.2))
                            //            .aspectRatio(contentMode: .fill)
                            //    }
                            //}
                            
                            Section {
                                if item.state == "pending" {
                                    
                                    Divider()
                                    
                                    TextField("Solución", text: $solution)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                    Button("Resolver incidencia", action: {
                                        isEditing.toggle()
                                    })
                                    .buttonStyle(.borderedProminent)
                                    .tint(Color(hex: 0xFABB02))
                                    .cornerRadius(50)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                }
                .padding(20)
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy HH:mm a"
        return formatter.string(from: date)
    }
}
