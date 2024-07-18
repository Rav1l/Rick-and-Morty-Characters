//
//  Resources.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 18.07.2024.
//

import Foundation

///All available API's resources.
@frozen enum Resources: String  {
    ///Resource to get craracter
    case character
    ///Resource to get episodes
    case episode
    ///Resource to get loactions
    case location
}
