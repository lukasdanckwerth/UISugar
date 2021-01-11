//
//  Selectable.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 03.01.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

class Selectable<T> {
    
    /// The represented 'selectable' object
    var representedObject: T
    
    /// Boolean value to indicate whether this Selectable is selected or not
    var isSelected: Bool = false
    
    /// Constructor with single parameter
    init(_ representedObject: T) {
        self.representedObject = representedObject
    }
}
