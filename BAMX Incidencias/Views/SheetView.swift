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
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.body)
            
            HStack {
                Button("Accept") {
                    isPresented = false
                    patchRequestsVM._id = itemId
                    patchRequestsVM.state = "accepted"
                    patchRequestsVM.patchRequests()
                }
                .foregroundColor(.black)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.green))
                
                Button("Reject") {
                    isPresented = false
                    patchRequestsVM._id = itemId
                    patchRequestsVM.state = "rejected"
                    patchRequestsVM.patchRequests()
                }
                .foregroundColor(.black)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.red))
                
                Spacer()
                
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

