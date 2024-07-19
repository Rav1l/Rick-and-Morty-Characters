//
//  FilterView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isSelect: Bool = false
    
    var body: some View {
        VStack {
            header
            HStack {
                Text("Status")
                Spacer()
            }
            .padding(.top)
            HStack(spacing: -1) {
                deadButton
                aliveButton
                unknownButton
                Spacer()
            }
            .padding(.leading, -5)
            .font(.caption)
            HStack {
                Text("Gender")
                Spacer()
            }
            .padding(.top)
            HStack(spacing: -1) {
                feamaleButton
                maleButton
                genderlessButton
                unknownGenderButton
                Spacer()
            }
            .padding(.leading, -5)
            .font(.caption)
            applyBatton
                .padding(.top)
        }
        .padding()
        .background(Color.theme.rowBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    FilterView()
        .preferredColorScheme(.dark)
}

extension FilterView {
    private var header: some View {
        HStack {
            Button("", systemImage:"xmark") { dismiss() }
                .foregroundStyle(Color.theme.text)
            Spacer()
            Text("Filters")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Reset")
                    .font(.caption)
                    .foregroundStyle(Color.theme.text)
            })
        }
    }
    
    private func buttonLabel(text: String) -> some View {
        Text(text)
            .foregroundStyle(Color.theme.text)
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 15)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 3).foregroundStyle(Color.theme.secondGrey))
            .padding(5)
    }
    
    
    
    private var deadButton: some View {
        Button {
            
        } label: {
            buttonLabel(text: "Dead")
        }
    }
    
    private var aliveButton: some View {
        Button {
            
        } label: {
            buttonLabel(text: "Alive")
        }
    }
    
    private var unknownButton: some View {
        Button {
            
        } label: {
            buttonLabel(text: "Unknown")
        }
    }
    
    private var feamaleButton: some View {
        Button {
            
        } label: {
            buttonLabel(text: "Female")
        }
    }
    
    private var maleButton: some View {
        Button {
            
        } label: {
            buttonLabel(text: "Male")
        }
    }
    
    private var genderlessButton: some View {
        Button {
            
        } label: {
            buttonLabel(text: "Genderless")
        }
    }
    
    private var unknownGenderButton: some View {
        Button {
            
        } label: {
            buttonLabel(text: "Unknown")
        }
    }
    
    private var applyBatton: some View {
        Button {
            
        } label: {
            HStack {
                Spacer()
                Text("Apply")
                    .foregroundStyle(Color.theme.text)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                Spacer()
            }
            .background(Color.theme.button)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}
