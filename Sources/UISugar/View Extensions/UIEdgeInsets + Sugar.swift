//
//  ExtensionUIEdgeInsets.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 28.03.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    
    /// Creates and returns `UIEdgeInsets` where `top`, `left`, `bottom` and `right` are filled with `value`.
    ///
    static func new(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    /// Creates and returns `UIEdgeInsets` where `left` and `right` are filled with the horzontal value and `top` and `bottom` are filled with vertical value.
    ///
    static func new(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

// MARK: - ExpressibleByFloatLiteral

extension UIEdgeInsets: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    public init(floatLiteral value: Self.FloatLiteralType) {
        let cgFloat = CGFloat(value)
        self = UIEdgeInsets(top: cgFloat, left: cgFloat, bottom: cgFloat, right: cgFloat)
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension UIEdgeInsets: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Self.IntegerLiteralType) {
        let cgFloat = CGFloat(value)
        self = UIEdgeInsets(top: cgFloat, left: cgFloat, bottom: cgFloat, right: cgFloat)
    }
}
#endif
