//
//  Localization.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 07.08.21.
//

import Foundation

/// Localizes the specified string using `NSLocalizedString()`.
///
public func translate(_ text: String, comment: String = "") -> String {
    NSLocalizedString(text, comment: comment)
}

/// Localizes the specified string using `NSLocalizedString()`.
///
public func translate(_ text: String, args: CVarArg...) -> String {
    String(format: NSLocalizedString(text, comment: ""), arguments: args)
}

/// Localizes the specified string using `NSLocalizedString()`.
///
public func l(_ text: String, comment: String = "") -> String {
    NSLocalizedString(text, comment: comment)
}

/// Localizes the specified string using `NSLocalizedString()`.
///
public func l(_ text: String, args: CVarArg...) -> String {
    String(format: NSLocalizedString(text, comment: ""), arguments: args)
}
