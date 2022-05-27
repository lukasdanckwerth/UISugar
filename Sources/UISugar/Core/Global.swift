//
//  Global.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 12.04.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===-------------------------------------------------------------------------------------------------------------===
//
// MARK: - Nil or Empty Checks
// ===-------------------------------------------------------------------------------------------------------------===

/// Returns a Boolean value indicating whether the given `String` is nil or empty.
///
/// - parameter string: The string to check.
public func isNilOrEmpty(_ string: String?) -> Bool {
    return string?.isEmpty ?? true
}

/// Returns a Boolean value indicating whether the given `String` contains of at least one character.
///
/// - parameter string: The string to check.
public func notNilOrEmpty(_ string: String?) -> Bool {
    return !isNilOrEmpty(string)
}

/// Returns a Boolean value indicating whether at least one of the given values is non-nil.
public func oneNotNilOrEmpty(_ first: String?, _ more: String?...) -> Bool {
    return notNilOrEmpty(first) || more.first(where: { notNilOrEmpty($0) }) != nil
}

/// Returns a Boolean value indicating whether the given array is nil or empty.
///
/// - parameter array: The array to check.
public func isNilOrEmpty(_ array: Array<Any>?) -> Bool {
    return array?.isEmpty ?? true
}

/// Returns a Boolean value indicating whether the given array is not empty.
///
/// - parameter array: The array to check.
public func notNilOrEmpty(_ array: Array<Any>?) -> Bool {
    return !isNilOrEmpty(array)
}

/// Returns the given `String` if it isn't `nil` or it's trimmed version if not empty.
///
/// - parameter value: The value to check for `nil` or empty.
///
/// - returns: The given `String` or `nil`.
public func trimmedEmptyToNil(_ value: String?) -> String? {
    return value != nil ? (value?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 ? nil : value) : nil
}



/// Returns a Boolean value which is `true` if all passed Boolean values are `true`, returns `false` if any one or all
/// of the given values are `false`.
public func allTrue(_ values: Bool...) -> Bool {
    return values.first(where: { !$0 }) == nil
}

/// Returns a Boolean value which is `true` if all passed Boolean values are `false`, returns `false` if any one or all
/// of the given values are `true`.
public func allFalse(_ values: Bool...) -> Bool {
    return values.first(where: { $0 }) == nil
}




// ===-------------------------------------------------------------------------------------------------------------===
//
// MARK: - Auxiliary
// ===-------------------------------------------------------------------------------------------------------------===

/// Sets the value given in `second` to `first` and then returns first. This function imitates the Java behaviour where you can assign
/// a value to a variable and this expression returns the variable such as:
///
/// ```
/// String myString = "Hello World";
/// System.out.println(myString = "Hello Console")    <-- This line is imitated
/// ```
///
/// ... so now you can write in Swift:
///
/// ```
/// var myString = "Hello World"
/// print(assign(&myString, "Hello Console"))
/// ```
///
/// - parameter first: The variable to asssign with a new value.
/// - parameter second: The value to assign to the first parameter.
///
/// - returns: The first parameter after the second was assigned to it.
public func assign<Type>(_ first: inout Type!, _ second: Type) -> Type {
    first = second
    return first
}

/// Iterates the given enum.  This function is workaround for `String` enumerations.
public func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}




//#if canImport(UIKit)
//extension NSLocalizedString {
//    convenience init() {
//        
//    }
//}
//#endif
