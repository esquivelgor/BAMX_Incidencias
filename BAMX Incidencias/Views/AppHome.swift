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
    @EnvironmentObject var loginVM : LoginViewModel
    @StateObject var getRequestsVM = GetRequestsViewModel()
    
    @State private var selectedItemId: String?
    @State private var selectedTitle: String?
    @State private var selectedDescription: String?
    @State private var isShowingSheet = false
    
    var body: some View {
        if !loginVM.isAuthenticated {
            AuthentificationView()
        } else {
            NavigationView {
                ZStack {
                    VStack (spacing: 0){
                        Text("Incidencias")
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
                        
                        Text("Solicitudes")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: 0xE2032C))
                            .padding(.top, 20)
                            .padding(.leading, 20)
                        
                        Divider()
                        
                        List {
                            Section(header: Text("Pendientes").font(.headline)) {
                                ScrollView(.vertical, showsIndicators: false) {
                                    ForEach(getRequestsVM.ticketData?.items.filter { $0.state == "pending" } ?? [], id: \._id) { item in
                                        TicketRowView(item: item)
                                            .onTapGesture {
                                                selectedItemId = item._id
                                                selectedTitle = item.title
                                                selectedDescription = item.description
                                                isShowingSheet = true
                                            }
                                        Rectangle()
                                            .frame(height: 0.5)
                                            .foregroundColor(Color.black)
                                    }
                                }
                                .frame(height: 150)
                            }
                            
                            Section(header: Text("Aprobadas").font(.headline)) {
                                ScrollView(.vertical, showsIndicators: false) {
                                    ForEach(getRequestsVM.ticketData?.items.filter { $0.state == "approved" } ?? [], id: \._id) { item in
                                        TicketRowView(item: item)
                                        Rectangle()
                                            .frame(height: 0.5)
                                            .foregroundColor(Color.black)
                                    }
                                }
                                .frame(height: 150)
                            }
                            
                            Section(header: Text("Rechazadas").font(.headline)) {
                                ScrollView(.vertical, showsIndicators: false) {
                                    ForEach(getRequestsVM.ticketData?.items.filter { $0.state == "rejected" } ?? [], id: \._id) { item in
                                        TicketRowView(item: item)
                                        Rectangle()
                                            .frame(height: 0.5)
                                            .foregroundColor(Color.black)
                                    }
                                }
                                .frame(height: 150)
                            }
                        }
                        .onAppear(perform: getRequestsVM.getRequests)
                        .frame(height: 250)
                        .sheet(isPresented: $isShowingSheet) {
                            if let itemId = selectedItemId {
                                SheetView(itemId: itemId, title: selectedTitle ?? "Null", description: selectedDescription ?? "Null", isPresented: $isShowingSheet)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    
                    GeometryReader { _ in
                        
                        HStack {
                            Spacer()
                            SideMenuView()
                                .environmentObject(loginVM)
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
    
    struct TicketRowView: View {
        let item: Ticket // Assuming you have a Ticket model

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            return formatter
        }()
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.description)
                    .font(.subheadline)
                
                if let createdAt = dateFormatter.date(from: item.created_at) {
                    Text("Created At: \(formatDate(createdAt))")
                        .font(.subheadline)
                }
            }
            .padding(8)
        }
        
        private func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy HH:mm a"
            return formatter.string(from: date)
        }
    }
}

struct AppHome_Previews: PreviewProvider {
    static var previews: some View {
        AppHome()
    }
}
