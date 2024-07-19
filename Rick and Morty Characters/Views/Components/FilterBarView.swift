//
//  FilterBarView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import SwiftUI

struct FilterBarView: View {
    
    @Binding var searchText: String
    @State private var showSheet: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .scaleEffect(x: -1)
                TextField("", text: $searchText, prompt: Text("Search").foregroundStyle(Color.theme.text))
                
            }
            .padding([.top, .bottom], 9)
            .padding([.leading, .trailing])
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 3).foregroundStyle(Color.theme.rowBackground))
            .padding(5)
            Button {
                showSheet.toggle()
            } label: {
                Image("slider")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .scaleEffect(x: -1)
            }
        }
        .padding([.leading, .trailing], 5)
        .sheet(isPresented: $showSheet, content: {
            FilterView()
                .presentationDetents([.fraction(0.43)])
                .presentationDragIndicator(.hidden)
                .background(Color.black)
        })
    }
}

#Preview {
    FilterBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}
