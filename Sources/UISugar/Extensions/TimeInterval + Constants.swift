//
//  ExtensionTimeInterval.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 08.09.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    /// Returns the default fade duration.
    ///
    static var defaultFadeDuration: TimeInterval { return 0.3 }
    
    /// The time intervall for one minute.
    ///
    static let oneMinute: TimeInterval = 60
    
    /// The time intervall for one hour.
    static let oneHour: TimeInterval = oneMinute * 60
    
    /// The time intervall for twenty for hours.
    ///
    static let twentyFourHours: TimeInterval = oneHour * 24
    
    /// The time intervall for twenty for one day.
    ///
    static let oneDay: TimeInterval = twentyFourHours
    
    /// The time intervall for one year.
    ///
    static let oneYear: TimeInterval = oneDay * 365
}
