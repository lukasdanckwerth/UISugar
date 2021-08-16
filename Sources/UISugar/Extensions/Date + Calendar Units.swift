//
//  File.swift
//  
//
//  Created by Lukas Danckwerth on 25.10.20.
//

import Foundation

public extension Date {
    
    // For shorter call of current calendar within NSDate instance
    var calendar: Calendar {
        //        return Calendar.current
        return Calendar(identifier: .gregorian)
    }
    
    // MARK: Calendar Units
    var era: Int {
        return calendar.component(.era, from: self)
    }
    var year: Int {
        return calendar.component(.year, from: self)
    }
    var month: Int {
        return calendar.component(.month, from: self)
    }
    var day: Int {
        return calendar.component(.day, from: self)
    }
    var hour: Int {
        return calendar.component(.hour, from: self)
    }
    var minute: Int {
        return calendar.component(.minute, from: self)
    }
    var second: Int {
        return calendar.component(.second, from: self)
    }
    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }
    var weekdayOrdinal: Int {
        return calendar.component(.weekdayOrdinal, from: self)
    }
    var quarter: Int {
        return calendar.component(.quarter, from: self)
    }
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    var nanosecond: Int {
        return calendar.component(.nanosecond, from: self)
    }
    var isToday: Bool {
        return calendar.isDateInToday(self)
    }
    var isTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }
    var isYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    var isWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }
    var isWeekday: Bool {
        return !isWeekend
    }
}
