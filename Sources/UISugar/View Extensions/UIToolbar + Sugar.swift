//
//  ExtensionUIToolbar.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 24.03.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

/// ExtensionUIToolbar
///
/// - author: Lukas Danckwerth
extension UIToolbar {
    
    
    /// Cleares the entire background of the navigation bar.
    func clearBackground() {
        isTranslucent = true
        clipsToBounds = true
        backgroundColor = .clear
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
    }
}
#endif
