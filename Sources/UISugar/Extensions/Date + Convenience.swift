//
//  Date + Convenience.swift
//  
//
//  Created by Lukas Danckwerth on 22.10.20.
//

import Foundation

public extension Date {
    
    /// Returns a Boolean value indicating whether the date is in the future or not.
    var isInTheFuture: Bool {
        return self > Date()
    }
    
    /// Returns the date with the same time of the day before.
    ///
    var dayBefore: Date {
        return self - TimeInterval.twentyFourHours
    }
    
    /// Returns the date with the same time of the day after.
    ///
    var dayAfter: Date {
        return self + TimeInterval.twentyFourHours
    }
    
    /// Returns the date with the same time of the week before.
    ///
    var weekBefore: Date {
        return self - (TimeInterval.twentyFourHours * 7)
    }
    
    /// Returns the date withe hour, minutes, seconds and nanoseconds set to `0`.
    ///
    var normalized: Date? {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([
            .day,
            .hour,
            .second,
            .nanosecond,
            .year,
            .month,
            .day
        ], from: self)
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.nanosecond = 0
        
        return calendar.date(from: components)
    }
    
    // MARK: - Equal Functions
    
    /// Returns `true` if the given `Date` is the same date as the receiver ignoring time.
    func sameDate(as date: Date) -> Bool {
        return self.normalized == date.normalized
    }
}
