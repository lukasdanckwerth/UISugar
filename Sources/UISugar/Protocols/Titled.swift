//
//  File.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 20.01.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import Foundation

public protocol Titled {
   var title: String { get }
}

public protocol LocalizedTitled: Titled {
   var localizedTitle: String { get }
}

public extension LocalizedTitled {
   var localizedTitle: String { NSLocalizedString(title, comment: "Unknown") }
}
