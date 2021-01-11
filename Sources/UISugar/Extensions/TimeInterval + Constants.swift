//
//  ExtensionTimeInterval.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 08.09.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    /// Returns the default fade duration.
    static var defaultFadeDuration: TimeInterval {
        return 0.3
    }
    
    /// Returns the time intervall for one hour.
    static var oneHour: TimeInterval {
        return 60 * 60
    }
    
    /// Returns the time intervall for twenty four hours.
    static var twentyFourHours: TimeInterval {
        return 24 * oneHour
    }
}
