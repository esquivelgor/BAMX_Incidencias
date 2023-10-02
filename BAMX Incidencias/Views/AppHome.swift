//
//  AppHome.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/9/23.
//

import SwiftUI

struct AppHome: View {
    @State private var showMenu: Bool = false
    @State private var showFloatingMenu: Bool = true
    @StateObject private var loginVM =  LoginViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (alignment: .leading){
                    Text("Mis Incidencias")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0xE2032C))
                        .padding(.top, 20)
                        .padding(.leading, 20)
                    
                    Divider()
                    
                    ScrollView(.vertical) {
                        VStack {
                            // Table headers
                            HStack (alignment: .center){
                                Text("Incidencia")
                                    .frame(maxWidth: .infinity)
                                Text("Categorías")
                                    .frame(maxWidth: .infinity)
                                Text("Estatus")
                                    .frame(maxWidth: .infinity)
                            }
                            .font(Font.system(size: 18).weight(.bold))
                            .padding(8)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color.black)
                            
                            ForEach(0..<3) { rowIndex in
                                HStack {
                                    Text("Incidencia \(rowIndex + 1)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Categoría \(rowIndex + 1)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Estatus \(rowIndex + 1)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(8)
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color.black)
                            }
                        }
                        .padding(.horizontal, 16)
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
                
                // Floating Menu Button
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
                    showFloatingMenu.toggle()
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


struct AppHome_Previews: PreviewProvider {
    static var previews: some View {
        AppHome()
    }
}
