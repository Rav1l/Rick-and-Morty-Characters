//
//  FilterSheetView.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import SwiftUI

struct FilterSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var filterVM: FilterViewModel
    
    var body: some View {
        VStack {
            header
            HStack {
                Text("Status")
                Spacer()
            }
            .padding(.top)
            HStack(spacing: -1) {
                statusButton(status: .dead, isSelect: filterVM.isDead)
                statusButton(status: .alive, isSelect: filterVM.isAlive)
                statusButton(status: .unknown, isSelect: filterVM.isStatusUnknown)
                Spacer()
            }
            .padding(.leading, -5)
            .font(.caption)
            HStack {
                Text("Gender")
                Spacer()
            }
            .padding(.top)
            HStack(spacing: -3) {
                genderButton(gender: .female, isSelect: filterVM.isFemale)
                genderButton(gender: .male, isSelect: filterVM.isMale)
                genderButton(gender: .genderless, isSelect: filterVM.isGenderless)
                genderButton(gender: .unknown, isSelect: filterVM.isGenderUnknown)
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
    FilterSheetView()
        .preferredColorScheme(.dark)
        .environmentObject(DeveloperPreview.instance.filterVM)
}

//MARK: Extensions
// MARK: Header
extension FilterSheetView {
    private var header: some View {
        HStack {
            closeButton
            Spacer()
            headerTitle
            Spacer()
            resetButton
        }
    }
    
    ///closedButton
    private var closeButton: some View {
        Button("", systemImage:"xmark") {
            dismiss()
        }
        .foregroundStyle(Color.theme.text)
    }
    
    ///Header title
    private var headerTitle: some View {
        Text("Filters")
            .font(.title3)
            .fontWeight(.semibold)
    }
    
    ///Reset button
    private var resetButton: some View {
        Button {
            self.filterVM.allSelectFalse()
            self.filterVM.gender = ""
            self.filterVM.status = ""
            self.filterVM.loadData()
        } label: {
            Text("Reset")
                .font(.caption)
                .foregroundStyle(
                    self.filterVM.isDead ||
                    self.filterVM.isAlive ||
                    self.filterVM.isStatusUnknown ||
                    self.filterVM.isFemale ||
                    self.filterVM.isMale ||
                    self.filterVM.isGenderless ||
                    self.filterVM.isGenderUnknown ?
                    Color.theme.button : Color.theme.text
                )
        }
    }
    
    //MARK: Button label
    ///Lable for button character's status and gender
    private func buttonLabel(text: String, isSelect: Bool) -> some View {
        HStack {
            Text(text)
            if isSelect { Image(systemName: "checkmark").padding(.trailing, -3) }
        }
        .foregroundStyle(isSelect ? Color.black : Color.theme.text)
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 15)
        .background {
            if isSelect {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color.white)
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 3)
                    .foregroundStyle(Color.theme.secondGrey)
            }
        }
        .padding(5)
    }
    //MARK: Buttons
    ///Button for selected character status
    private func statusButton(status: Status, isSelect: Bool) -> some View {
        Button {
            withAnimation(.interactiveSpring) {
                statusSelect(status: status)
            }
        } label: {
            buttonLabel(text: status.rawValue, isSelect: isSelect)
        }
    }
    ///Button for selected character gender
    private func genderButton(gender: Gender, isSelect: Bool) -> some View {
        Button {
            withAnimation(.interactiveSpring) {
                genderSelect(gender: gender)
            }
        } label: {
            buttonLabel(text: gender.rawValue, isSelect: isSelect)
        }
    }
    
    private var applyBatton: some View {
        Button {
            self.filterVM.loadData()
            dismiss()
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
    //MARK: Select methods
    ///Select logic for status buttons
    private func statusSelect(status: Status) {
        switch status {
        case .dead :
            self.filterVM.status = status.rawValue
            self.filterVM.isDead = true
            self.filterVM.isAlive = false
            self.filterVM.isStatusUnknown = false
        case .alive:
            self.filterVM.status = status.rawValue
            self.filterVM.isDead = false
            self.filterVM.isAlive = true
            self.filterVM.isStatusUnknown = false
        case .unknown:
            self.filterVM.status = status.rawValue
            self.filterVM.isDead = false
            self.filterVM.isAlive = false
            self.filterVM.isStatusUnknown = true
        }
        self.filterVM.loadData()
    }
    ///Select logic for gender buttons
    private func genderSelect(gender: Gender) {
        switch gender {
        case .female:
            self.filterVM.gender = gender.rawValue
            self.filterVM.isFemale = true
            self.filterVM.isMale = false
            self.filterVM.isGenderless = false
            self.filterVM.isGenderUnknown = false
        case .male:
            self.filterVM.gender = gender.rawValue
            self.filterVM.isFemale = false
            self.filterVM.isMale = true
            self.filterVM.isGenderless = false
            self.filterVM.isGenderUnknown = false
        case .genderless:
            self.filterVM.gender = gender.rawValue
            self.filterVM.isFemale = false
            self.filterVM.isMale = false
            self.filterVM.isGenderless = true
            self.filterVM.isGenderUnknown = false
        case .unknown:
            self.filterVM.gender = gender.rawValue
            self.filterVM.isFemale = false
            self.filterVM.isMale = false
            self.filterVM.isGenderless = false
            self.filterVM.isGenderUnknown = true
        }
        self.filterVM.loadData()
    }
}
