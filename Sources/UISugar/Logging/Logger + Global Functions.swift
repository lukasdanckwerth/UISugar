//
//  File.swift
//  
//
//  Created by Lukas Danckwerth on 13.08.21.
//

import Foundation

public func verbose(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
    Logger.default.internalPrint(file: file, function: function, line: line, column: column, severity: .verbose, more)
}

public func debug(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
    Logger.default.internalPrint(file: file, function: function, line: line, column: column, severity: .debug, more)
}

public func info(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
    Logger.default.internalPrint(file: file, function: function, line: line, column: column, severity: .info, more)
}

public func warning(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
    Logger.default.internalPrint(file: file, function: function, line: line, column: column, severity: .warning, more)
}

public func error(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?..., throwable: Any? = nil) {
    Logger.default.internalPrint(file: file, function: function, line: line, column: column, severity: .error, more)
}
