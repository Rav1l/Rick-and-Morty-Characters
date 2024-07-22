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
    @EnvironmentObject private var filterVM: FilterViewModel
    
    var body: some View {
        VStack {
            HStack {
                searchField
                filtersButton
            }
            .padding([.leading, .trailing], 5)
            .sheet(isPresented: $showSheet, content: {
                FilterSheetView()
                    .presentationDetents([.fraction(0.45)])
                    .presentationDragIndicator(.hidden)
                    .presentationCornerRadius(20)
                    .presentationBackground(Color.theme.background)
            })
            if !self.filterVM.status.isEmpty || !self.filterVM.gender.isEmpty {
                HStack {
                    if !self.filterVM.status.isEmpty { statusText }
                    if !self.filterVM.gender.isEmpty { genderText }
                    resetAll
                    Spacer()
                }
                .padding(.leading, 11)
            }
        }
    }
}

#Preview {
    FilterBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
        .environmentObject(DeveloperPreview.instance.filterVM)
}

//MARK: Extensions
extension FilterBarView {
    
    ///Text field
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .scaleEffect(x: -1)
            TextField("", text: $searchText, prompt: Text("Search").foregroundStyle(Color.theme.text))
        }
        .padding([.top, .bottom], 9)
        .padding([.leading, .trailing])
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 3).foregroundStyle(Color.theme.rowBackground))
        .padding(5)
    }
    
    ///Button open FilterSheetView
    private var filtersButton: some View {
        Button {
            showSheet.toggle()
        } label: {
            imageSlider()
                .resizable()
                .scaledToFit()
                .frame(width: 25)
                .scaleEffect(x: -1)
        }
    }
    
    ///Change image of filtersButton
    private func imageSlider() -> Image {
        self.filterVM.isDead ||
        self.filterVM.isAlive ||
        self.filterVM.isStatusUnknown ||
        self.filterVM.isFemale ||
        self.filterVM.isMale ||
        self.filterVM.isGenderless ||
        self.filterVM.isGenderUnknown ?
        Image("sliderSelected") : Image("slider")
    }
    
    /// Setting text of selected filters
    private func textSelectedFilter(titel: String, textColor: Color, background: Color) -> some View {
        return Text(titel)
            .font(.caption)
            .foregroundStyle(textColor)
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 9)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    ///Reset all filter button
    private var resetAll: some View {
        Button {
            self.filterVM.allSelectFalse()
            self.filterVM.gender = ""
            self.filterVM.status = ""
            self.filterVM.loadData()
        } label: {
            textSelectedFilter(titel: "Reset all filters", textColor: .white, background: Color.theme.button)
        }
    }
    
    private var statusText: some View {
        textSelectedFilter(titel: filterVM.status, textColor: .black, background: .white)
    }
    
    private var genderText: some View {
        textSelectedFilter(titel: filterVM.gender, textColor: .black, background: .white)
    }
    
}
