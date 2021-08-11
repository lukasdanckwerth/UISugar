//
//  File.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 20.01.20.
//  Copyright © 2020 WinValue. All rights reserved.
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

/// Default implementation of the `localizedTitle` property.
///
public extension LocalizedTitled {
    var localizedTitle: String { NSLocalizedString(title, comment: "Unknown") }
}
