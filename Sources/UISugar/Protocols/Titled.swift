//
//  File.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 20.01.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

/// Protocol for objects that have a title.
///
public protocol Titled {
    
    /// The title.
    ///
    var title: String { get }
}

/// Protocol for objects that have a localized title.
///
public protocol LocalizedTitled: Titled {
    
    /// Returns the localized version of the title.
    ///
    var localizedTitle: String { get }
}

// default implementation
public extension LocalizedTitled {
    
    /// Returns the localized version of the title.
    ///
    var localizedTitle: String {
        return NSLocalizedString(title, comment: "Unknown")
    }
}
