//
//  SheetView.swift
//  BAMX Incidencias
//
//  Created by user245584 on 10/16/23.
//

import SwiftUI

struct SheetView: View {
    
    var itemId: String = ""
    var title: String = ""
    var description: String = ""
    
    @Binding var isPresented: Bool
    @StateObject var patchRequestsVM = PatchRequestsViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)

            HStack(alignment: .center, spacing: 16) {
                Button("Aceptar") {
                    isPresented = false
                    patchRequestsVM._id = itemId
                    patchRequestsVM.state = "approved"
                    patchRequestsVM.patchRequests()
                }
                .foregroundColor(.white)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: 0x29A35)))
                
                Button("Rechazar") {
                    isPresented = false
                    patchRequestsVM._id = itemId
                    patchRequestsVM.state = "rejected"
                    patchRequestsVM.patchRequests()
                }
                .foregroundColor(.white)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: 0xE2032C)))
            }
            Spacer()
        }
        .padding(16)

        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

