//
//  FloatingMenu.swift
//  BAMX Incidencias
//
//  Created by user245071 on 9/30/23.
//

import SwiftUI

struct FloatingMenu: View {
    var body: some View {
        VStack {
            NavigationLink(destination: incidentsView(), label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(red: 226/255, green: 3/255, blue: 44/255))
                    .shadow(color:.gray, radius: 0.3,x: 1, y: 1)
                
            })
        }
    }
}

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}
