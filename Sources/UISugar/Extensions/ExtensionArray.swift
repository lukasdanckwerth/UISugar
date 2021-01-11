//
//  ExtensionArray.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 04.03.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

/// ExtensionArray
///
/// - author: Lukas Danckwerth
extension Array where Element: Hashable {
    
    var toSet: Set<Element> {
        return Set(self.map{ $0 })
    }
}

extension Array {
    
    
    /// Returns a Boolean value indicating whether the given index is a valid index of the receiver.
    func valid(index: Int) -> Bool {
        return index >= 0 && index < count
    }
}

extension Set {
    
    var toArray: Array<Element> {
        return Array(self)
    }
}
