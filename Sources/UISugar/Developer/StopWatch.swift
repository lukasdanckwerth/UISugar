//
//  StopWatch.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 15.11.17.
//

import Foundation

private class StopWatch {
    
    // MARK: - Properties
    
    /// Describes the usage of this stop watch.
    let tag: String
    
    /// The date this stop watch was started.
    private(set) var startTime: Date
    
    /// The date this stop watch was stopped the last time.
    private(set) var stopTime: Date?
    
    /// Returns the time interval till the stop time if a stop time is set.  Will return time intervall since
    /// now else.  The value will be absoulte which means it always will be positive.
    var timeIntervalSinceStart: TimeInterval {
    
        let intervall: TimeInterval!
        
        if stopTime == nil {
            intervall = startTime.timeIntervalSinceNow
        } else {
            intervall = startTime.timeIntervalSince(stopTime!)
        }
        
        return intervall >= 0 ? intervall : intervall * -1
    }
    
    /// Returns a fancy string containing a formatted version of the time intervall since start.
    var formattedTimeIntervalSinceStart: String {
        return formatTimeIntervall(timeIntervalSinceStart)
    }
    
    // MARK: - Initialization
    
    /// Creates a new instance.
    init(_ tag: String) {
        self.tag = tag
        self.startTime = Date()
    }
    
    /// Starts the stop watch and returns the start date.
    @discardableResult func start() -> Date {
        startTime = Date()
        return startTime
    }
    
    /// Stops this stop watch and returns the time intervall since the start.
    @discardableResult func stop() -> TimeInterval {
        stopTime = Date()
        return timeIntervalSinceStart
    }
    
    /// Prints a beautiful string with the passed time.
    func printTime() {
        NSLog("[\(tag)]", formatTimeIntervall(timeIntervalSinceStart))
    }
    
    /// Formats and returns the given time intervall.
    private func formatTimeIntervall(_ timeIntervall: TimeInterval) -> String {
        
        if timeIntervall < 0 {
            return String(format: "%.5f Sec", timeIntervall * -1)
        } else {
            return String(format: "%.5f Sec", timeIntervall)
        }
    }
}

/// Meassures the duration of the execution of the given block.
public func measure(file: String = #file, _ tag: String? = nil, _ block: (() -> ())) {
    
    let stopWatch = StopWatch(tag ?? "")
    
    block()
    
    stopWatch.stop()
    
    let group = file.components(separatedBy: "/").last?.replacingOccurrences(of: ".swift", with: "") ?? file
    if let tag = tag {
        NSLog("[StopWatch in \(group)]  [\(tag)]  measured: \(stopWatch.formattedTimeIntervalSinceStart)")
    } else {
        NSLog("[StopWatch in \(group)]  measured: \(stopWatch.formattedTimeIntervalSinceStart)")
    }
}
