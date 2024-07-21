//
//  NavigationController.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 21.07.2024.
//

import Foundation
import UIKit

///Swipe-back gesture
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
