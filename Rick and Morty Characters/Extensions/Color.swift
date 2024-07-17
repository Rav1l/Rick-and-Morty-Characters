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
}
