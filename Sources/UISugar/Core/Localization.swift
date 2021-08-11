//
//  Localization.swift
//  Times Your Age
//
//  Created by Lukas on 07.08.21.
//

import Foundation

public func translate(_ text: String) -> String {
    NSLocalizedString(text, comment: "")
}

public func translate(_ text: String, args: CVarArg...) -> String {
    String(format: NSLocalizedString(text, comment: ""), arguments: args)
}

// ===-------------------------------------------------------------------------------------------------------------===
//
// MARK: - Translation
// ===-------------------------------------------------------------------------------------------------------------===

/// Translates the given text to the device's language.
//public func translate(_ text: String, _ arguments: CVarArg...) -> String? {
//    if arguments.isEmpty {
//        return NSLocalizedString(text, comment: "")
//    } else {
//        let localized = NSLocalizedString(text, comment: "")
//        return String(format: localized, arguments: arguments)
//    }
//}

let tr = translate



/// Translates the given text to the device's language.
///
public func localize(_ text: String, _ arguments: CVarArg...) -> String? {
    if arguments.isEmpty {
        return NSLocalizedString(text, comment: "")
    } else {
        return String(format: NSLocalizedString(text, comment: ""), arguments: arguments)
    }
}

func NSLocalizedString(_ text: String) -> String {
    return NSLocalizedString(text, comment: "")
}
