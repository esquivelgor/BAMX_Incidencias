//
//  NotificacionesView.swift
//  BAMX Incidencias
//
//  Created by user245071 on 9/22/23.
//

import SwiftUI

struct NotificationsView: View {
    @State private var showMenu: Bool = false
    @State private var showFloatingMenu: Bool = true

    var body: some View {
        NavigationView {
        
        ZStack {
            VStack (alignment: .leading) {
                Text("Mis Notificaciones")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0xE2032C))
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                Divider()
                
                ScrollView(.vertical) {
                    VStack {
                        HStack{
                            Text("Fecha")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Descripcion")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .font(Font.system(size: 18).weight(.bold))
                        .padding(8)
                        Rectangle()
                              .frame(height: 2)
                              .foregroundColor(Color(hex: 0x575756))
                        
                        ForEach(0..<3) { rowIndex in
                            HStack {
                                Text("Dia \(rowIndex + 1)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Text \(rowIndex + 1)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(8)
                            .foregroundColor(Color(hex: 0x575756))

                            Rectangle()
                                  .frame(height: 2)
                                  .foregroundColor(Color(hex: 0x575756))
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

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
