//
//  AccountView.swift
//  BAMX Incidencias
//
//  Created by user245071 on 9/22/23.
//

import SwiftUI

struct AccountView: View {
    
    @State private var showMenu: Bool = false
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
        ZStack {
            VStack (alignment: .leading) {
                // We could possibly use this, idk
                HStack {
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(50)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                    
                    Text("Change photo")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            showSheet = true
                        }
                }
                Text("Mi Cuenta")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0xE2032C))
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                Divider()
                ScrollView(.vertical) {
                    VStack {
                        VStack(alignment: .leading, spacing: 20) {
                            AccountRow(label: "Nombre ", value: "John", isEditable: false)
                            AccountRow(label: "Apellido", value: "Doe", isEditable: false)
                            AccountRow(label: "Rol", value: "Usuario", isEditable: false)
                            AccountRow(label: "Correo", value: "johndoe@example.com", isEditable: false)
                            
                            VStack(alignment: .center) {                                 Button(action: {
                                    
                                }) {
                                    Text("Cambiar Contraseña")
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(hex: 0xE2032C))
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

struct AccountRow: View {
    let label: String
    let value: String
    let isEditable: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .bold()
            Spacer()
            if isEditable {
                TextField("", text: .constant(value))
                    .disabled(true)
            } else {
                Text(value)
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
