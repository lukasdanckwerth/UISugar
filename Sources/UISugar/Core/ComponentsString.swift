//
//  ComponentsString.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 19.03.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import Foundation

public struct ComponentsString {
    
    /// The components of the string
    private var components: [String] = []
    
    /// The separator to use when joining the components to a string
    public var separator: String
    
    /// Returns a new string by concatenating the elements of `components`,
    /// adding the separator between each element.  Returns `nil` if
    /// `components` is empty
    public var string: String? {
        guard !components.isEmpty else { return nil }
        return components.joined(separator: separator)
    }
    
    /// Returns a Boolean value indicating whether the underlying array
    /// of strings is empty.
    public var isEmpty: Bool {
        return self.components.isEmpty
    }
    
    
    public init(separator: String = ", ") {
        self.separator = separator
    }
    
    /// Adds the given string at the end of the components array if it isn't
    /// `nil`.  Will do nothing if given string is `nil`
    @discardableResult
    public mutating func append(_ string: String?) -> ComponentsString {
        guard let string = string else { return self }
        self.components.append(string)
        return self
    }
}

// infix operator +=: AdditionPrecedence

public extension ComponentsString {

    @discardableResult
    static func += (left: inout ComponentsString, right: String?) -> ComponentsString {
        left.append(right)
        return left
    }
}
