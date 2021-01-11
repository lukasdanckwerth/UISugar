//
//  ExtensionDate.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 23.02.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

extension Date {
    
    /// Returns a string from the given date formatted in the form of 'yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ'.
    ///
    /// - argument date: The date to format in a string.
    static func iso8601Format(date: Date?) -> String? {
        return date != nil ? DateFormatter.iso8601Full.string(from: date!) : nil
    }
    
    /// Returns an optional `Date` from the given string formatted with the form 'yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ'.
    ///
    /// - argument date: The date to format in a string.
    static func iso8601Format(string: String?) -> Date? {
        return string != nil ? DateFormatter.iso8601Full.date(from: string!) : nil
    }
    
    /// Returns a string from the given date formatted in the form of 'yyyy-MM-dd'.
    ///
    /// - argument date: The date to format in a string.
    static func onlyDateFormat(date: Date?) -> String? {
        return date != nil ? DateFormatter.onlyDateFormatter.string(from: date!) : nil
    }
    
    /// Returns an optional `Date` from the given string formatted in the form of 'yyyy-MM-dd'.
    ///
    /// - argument string: The string to create a `Date` from.
    static func onlyDateFormat(string: String?) -> Date? {
        return string != nil ? DateFormatter.onlyDateFormatter.date(from: string!) : nil
    }
    
    /// Returns a string from the given date formatted in the form of 'yyyy-MM'.
    ///
    /// - argument date: The date to format in a string.
    static func onlyYearMonth(date: Date?) -> String? {
        return date != nil ? DateFormatter.onlyYearMonthFormatter.string(from: date!) : nil
    }
    
    /// Returns an optional `Date` from the given string formatted in the form of 'yyyy-MM'.
    ///
    /// - argument string: The string to create a `Date` from.
    static func onlyYearMonth(string: String?) -> Date? {
        return string != nil ? DateFormatter.onlyYearMonthFormatter.date(from: string!) : nil
    }
}
