//
//  Color.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 17.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    let button = Color("ButtonColor")
    let background = Color("BackgroundColor")
    let green = Color("AliveStatusColor")
    let red = Color("DeadStatusColor")
    let grey = Color("UnknownStatusColor")
    let rowBackground = Color("RowBackgroundColor")
    let text = Color("TextColor")
    let secondGrey = Color("StrokeColor")
    ///Color of character's status text
    func statusTextColor(character: CharacterModel) -> Color {
        switch character.status {
        case .alive:
            return  Color.theme.green
        case .dead:
            return  Color.theme.red
        case .unknown:
            return Color.theme.grey
        }
    }
}
