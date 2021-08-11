//
//  ExtensionDateFormatter.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 23.02.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

public extension DateFormatter {
    
    /// Creates a new instance from the given values.
    convenience init(_ dateFormat: String, calendar: Calendar = Calendar(identifier: .iso8601), locale: Locale = Locale(identifier: "en_US_POSIX")) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = locale
    }
    
    /// Optional implementation of the `string(from:)` message for convenience.
    func optionalString(from date: Date?) -> String? {
        if let date = date {
            return string(from: date)
        }
        return nil
    }
}

public extension DateFormatter {
    
    /**
     DateFormatter with format "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ".
     */
    static let iso8601Full: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        // formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        
    }()
    
    /**
     DateFormatter with format "yyyy-MM-dd".
     */
    static let onlyDateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        // formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        
    }()
    
    static let onlyTime: DateFormatter = DateFormatter("HH:mm")
    
    /**
     DateFormatter with format "yyyy-MM".
     */
    static let onlyYearMonthFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.calendar = Calendar(identifier: .iso8601)
        // formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        
    }()
    
    /**
     DateFormatter with (human readable) format "dd.MM.yyyy".
     */
    static let humanReadable: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        // formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        
    }()
    
    /**
     DateFormatter with (human readable full) format "dd.MM.yyyy HH:mm".
     */
    static var humanReadableFull: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.calendar = Calendar(identifier: .iso8601)
        // formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    
    /**
     DateFormatter with format "ddMMyy".
     */
    static let sixCharacter: DateFormatter = DateFormatter("ddMMyy")
    
    /**
     DateFormatter with format "dd.MM.yy".
     */
    static let sixCharacterDot: DateFormatter = DateFormatter("dd.MM.yy")
    
    /**
     DateFormatter with format "ddMMyyyy".
     */
    static let eightCharacter: DateFormatter = DateFormatter("ddMMyyyy")
    
    /// - returns: A string representation of date using the short time and date style.
    class func short(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    /// - returns: A string representation of date using the long time and date style.
    class func long(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        return dateFormatter.string(from: date)
    }
}
