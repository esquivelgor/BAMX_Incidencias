//
//  SplashScreenView.swift
//  BAMX Incidencias
//
//  Created by velgor on 27/08/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.4
    @State private var opacity = 0.5
    
    @StateObject var loginVM = LoginViewModel()
    
    var body: some View {
        if isActive {
            if UserDefaults.standard.string(forKey: "access_token") != nil {
                AppHome().environmentObject(loginVM)
            } else {
                AuthentificationView().environmentObject(loginVM)
            }
        } else {
            ZStack{
                Image("bg")
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(0)
                VStack {
                    VStack {
                        Image("bamx")
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation{
                            self.isActive = true                    }
                    }
                }            }
           
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
