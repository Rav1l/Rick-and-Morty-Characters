//
//  NetworkErrorView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import SwiftUI

struct NetworkErrorView: View {
    
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    var body: some View {
        VStack {
            Image("networkErrorImage")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 260)
            
            Text("Network Error")
                .font(.title)
                .bold()
            Text("There was an error connecting. Please check your internet.")
                .foregroundStyle(Color.theme.grey)
                .multilineTextAlignment(.center)
                .frame(width: 250)
            
            Button {
// The button doesn't do anything. On the phone the view will automatically update when the network connection is restored.
            } label: {
                Text("Retry")
                    .foregroundStyle(Color.theme.text)
                    .padding([.top, .bottom], 11)
                    .padding([.leading, .trailing], 90)
                
                    .background(Color.theme.button)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.top)
        }
    }
}

#Preview {
    NetworkErrorView()
        .preferredColorScheme(.dark)
        .environmentObject(NetworkMonitor())
}
