//
//  ExtensionUIToolbar.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 24.03.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

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
