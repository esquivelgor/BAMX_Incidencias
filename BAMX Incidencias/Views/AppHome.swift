//
//  AppHome.swift
//  BAMX Incidencias
//
//  Created by user245584 on 9/9/23.
//

import SwiftUI

struct AppHome: View {
    
    @EnvironmentObject var loginVM : LoginViewModel

    @State private var isShowingSheet = false
    @State private var showMenu: Bool = false
    @State private var showFloatingMenu: Bool = true
    
    @StateObject var getRequestsVM = GetRequestsViewModel()
    @StateObject var getTicketsVM = GetTicketsViewModel()
    
    @State private var selectedItemId: String?
    @State private var selectedTitle: String?
    @State private var selectedDescription: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 0){
                    Text("Incidencias")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0xE2032C))
                        .padding(20)

                    
                    Divider()
                    
                    List {
                        Section(header: Text("Urgencia alta").font(.headline).foregroundColor(Color.black)) {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(getTicketsVM.incidentResponse?.items.filter {$0.urgency == "high"} ?? [], id: \._id) { item in
                                    NavigationLink(destination: CreatedIncidenciaView(item: item)) {
                                        IncidentRowView(item: item)
                                    }
                                    .buttonStyle(.plain)
                                    Rectangle()
                                        .frame(height: 0.5)
                                        .foregroundColor(Color.black)
                                }
                            }
                            .frame(height: 120)
                        }.accentColor(Color.red)
                        Section(header: Text("Urgencia media").font(.headline).foregroundColor(Color.black)) {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(getTicketsVM.incidentResponse?.items.filter {$0.urgency == "medium"} ?? [], id: \._id) { item in
                                    NavigationLink(destination: CreatedIncidenciaView(item: item)) {
                                        IncidentRowView(item: item)
                                    }
                                    .buttonStyle(.plain)
                                    Rectangle()
                                        .frame(height: 0.5)
                                        .foregroundColor(Color.black)
                                }
                            }
                            .frame(height: 120)
                        }.accentColor(Color.red)
                        Section(header: Text("Urgencia baja").font(.headline).foregroundColor(Color.black)) {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(getTicketsVM.incidentResponse?.items.filter {$0.urgency == "low"} ?? [], id: \._id) { item in
                                    NavigationLink(destination: CreatedIncidenciaView(item: item)) {
                                        IncidentRowView(item: item)
                                    }
                                    .buttonStyle(.plain)
                                    Rectangle()
                                        .frame(height: 0.5)
                                        .foregroundColor(Color.black)
                                }
                            }
                            .frame(height: 120)
                        }.accentColor(Color.red)
                        
                    }
                    .onAppear(perform: getTicketsVM.getTickets)
                    .frame(height: 275)
                    //.sheet(isPresented: $isShowingSheet) {
                    //    if let itemId = selectedItemId {
                    //        SheetView(itemId: itemId, title: selectedTitle ?? "Null", description: selectedDescription ?? "Null", isPresented: $isShowingSheet)
                    //    }
                    //}
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                    Text("Solicitudes")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: 0xE2032C))
                        .padding(20)
                    
                    Divider()
                    
                    List {
                        Section(header: Text("Pendientes").font(.headline).foregroundColor(Color.black)) {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(getRequestsVM.requestData?.items.filter { $0.state == "pending" } ?? [], id: \._id) { item in
                                    RequestsRowView(item: item)
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
                        }.accentColor(Color.red)
                        
                        Section(header: Text("Aprobadas").font(.headline).foregroundColor(Color.black)) {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(getRequestsVM.requestData?.items.filter { $0.state == "approved" } ?? [], id: \._id) { item in
                                    RequestsRowView(item: item)
                                    Rectangle()
                                        .frame(height: 0.5)
                                        .foregroundColor(Color.black)
                                }
                            }
                            .frame(height: 150)
                        }.accentColor(Color.red)
                        
                        Section(header: Text("Rechazadas").font(.headline).foregroundColor(Color.black)) {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(getRequestsVM.requestData?.items.filter { $0.state == "rejected" } ?? [], id: \._id) { item in
                                    RequestsRowView(item: item)
                                    Rectangle()
                                        .frame(height: 0.5)
                                        .foregroundColor(Color.black)
                                }
                            }
                            .frame(height: 150)
                        }.accentColor(Color.red)
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
    
    struct RequestsRowView: View {
        let item: Requests

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
    
    struct IncidentRowView: View {
        let item: Incident

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            return formatter
        }()
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.description ?? "Sin descripcion")
                    .font(.subheadline)
                
                Text("Estado actual: \(item.state)")
                    .font(.subheadline)
                
                
                if let createdAt = dateFormatter.date(from: item.created_at) {
                    Text("Fecha: \(formatDate(createdAt))")
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
    }}

struct AppHome_Previews: PreviewProvider {
    static var previews: some View {
        AppHome()
    }
}
