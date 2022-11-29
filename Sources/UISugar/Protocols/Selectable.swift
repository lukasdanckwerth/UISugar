//
//  Selectable.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 03.01.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

/// A protocol for anything beeing selectable.
///
public protocol Selectable {
    associatedtype SelectableObject
    
    /// A Boolean value indicating whether the receiver is selected.
    ///
    var isSelected: Bool {get set}
    
    /// An associated object which could be selected or not.
    ///
    var representedObject: SelectableObject {get set}
}

/// A wrapper object for selectable items.
///
public class SelectableItem<T>: Selectable {
    
    /// The represented 'selectable' object.
    ///
    public var representedObject: T
    
    /// Boolean value to indicate whether this Selectable is selected or not.
    ///
    public var isSelected: Bool = false
    
    /// Constructor with single parameter.
    ///
    public init(_ representedObject: T) {
        self.representedObject = representedObject
    }
}

/// Additional functionality for a `Selectable`.
///
extension Selectable {
    
    /// Toggles the `isSelected` Boolean value.
    ///
    /// - returns: The new value of `isSelected`.
    ///
    mutating func toggle() -> Bool {
        isSelected = !isSelected
        return isSelected
    }
}
