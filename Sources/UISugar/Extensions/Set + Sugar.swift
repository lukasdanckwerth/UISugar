//
//  Set + Sugar.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 18.03.22.
//

import Foundation

extension Set {
    
    /// Returns an array containing the elements of this set.
    ///
    var toArray: Array<Element> { return Array(self) }
}
