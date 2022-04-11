//
//  ExtensionArray.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 04.03.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension Array {
    
    /// Returns a Boolean value indicating whether the given index is a valid index of the receiver.
    ///
    func valid(index: Int) -> Bool {
        return count > 0 && index >= 0 && index < count
    }
}

extension Array where Element: Hashable {
    
    /// Returns a set from the elements of this array.
    ///
    var toSet: Set<Element> {
        return Set(self.map{ $0 })
    }
}
