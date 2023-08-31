//
//  ContentView.swift
//  BAMX Incidencias
//
//  Created by velgor on 26/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingDetailView = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 30){
                Image("bamx")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250, alignment: .center)
                    .padding()
                
                Text("Iniciar Sesión")
                    .fontWeight(.bold)
                    .frame(width: 170, height: 40, alignment: .center)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(100)
                
                NavigationLink(
                    destination: SplashScreenView(),
                    label: {
                        Text("Registrarme")
                    }
                )
            }
            .navigationTitle("Login")
        }
    }
}
            
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
