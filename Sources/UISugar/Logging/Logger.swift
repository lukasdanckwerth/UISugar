//
//  Logger.swift
//
//  Created by Lukas Danckwerth on 29.07.17.
//

import Foundation

#if canImport(FirebaseAnalytics)
import FirebaseAnalytics
#endif

/** Main class for logging. */
public class Logger {
    
    
    // Mark: - Severity enum
    
    public enum Severity: Int {
        case verbose
        case debug
        case info
        case warning
        case error
        case none
        
        /// Returns a string for labeling the severity existing of 4 characters.
        var label: String {
            switch self {
            case .verbose:  return "    "
            case .debug:    return "DEBG"
            case .info:     return "INFO"
            case .warning:  return "WARN"
            case .error:    return "ERRO"
            case .none:     return ""
            }
        }
    }
    
    /// Single default instance
    public static let `default` = Logger()
    
    
    // Mark: - Fields
    
    /// The servertiy of logging
    public var severity: Logger.Severity
    
    /// Date formatter
    public lazy var formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        f.locale = Locale(identifier: "de_DE")
        return f
    }()
    
    /// Sets whether to print the date in the beginning of the line.
    public var printDate: Bool = true {
        didSet { printDateDidChange() }
    }
    
    /// Tells this class that the value of `printDate` has been set.
    open func printDateDidChange() {
        formatter.dateFormat = printDate ? "yyyy-MM-dd HH:mm:ss.SSS" : "HH:mm:ss.SSS"
    }
    
    /// Seprator for log messages
    public var seperator: String = "::"
    /// Defines the max length of a line before it is trimmed.
    public var maxLineLength: Int = 100080
    
    
    // Mark: - Initialization
    
    /// Private contructor. Get access via 'UALogger.default'
    private init() {
        
        #if DEBUG
        self.severity = .verbose
        #else
        self.severity = .none
        #endif
    }
    
    
    // Mark: - Main log function
    
    public func verbose(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
        internalPrint(file: file, function: function, line: line, column: column, severity: .verbose, more)
    }
    
    public func verbose(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, array: [Any?]) {
        internalPrint(file: file, function: function, line: line, column: column, severity: .verbose, array)
    }
    
    public func debug(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
        internalPrint(file: file, function: function, line: line, column: column, severity: .debug, more)
    }
    
    public func info(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
        internalPrint(file: file, function: function, line: line, column: column, severity: .info, more)
    }
    
    public func warning(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?...) {
        internalPrint(file: file, function: function, line: line, column: column, severity: .warning, more)
    }
    
    public func error(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, _ more: Any?..., throwable: Any? = nil) {
        internalPrint(file: file, function: function, line: line, column: column, severity: .error, more)
        guard let throwable = throwable else { return }
        internalPrint(file: file, function: function, line: line, column: column, severity: .error, [throwable])
    }
    
    public func prettyPrint<Type>(value: Type) where Type: Codable {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let data = try jsonEncoder.encode(value)
            print("\n\n\(String(describing: String(data: data, encoding: .utf8)))\n\n")
        } catch {
            print("Can't encode \(value)")
        }
    }
    
    public func event(_ origin: Any, id: String, value: Any? = nil) {
        
        let originString: String
        if origin is String {
            originString = origin as! String
        } else {
            originString = String(describing: type(of: origin))
                .replacingOccurrences(of: "TableViewController", with: "TVC")
                .replacingOccurrences(of: "CollectionViewController", with: "CVC")
                .replacingOccurrences(of: "CollectionViewCell", with: "CVCell")
                .replacingOccurrences(of: "TableViewCell", with: "TVCell")
                .replacingOccurrences(of: "ViewController", with: "VC")
                .replacingOccurrences(of: "Controller", with: "C")
        }
        
        let name = "\(originString)_\(id)".prefix(39)
        
        #if DEBUG
        var message = "\(formatter.string(from: Date())) \(seperator) [ FB ] \(name)"
        if value != nil { message += ", value: \(String(describing: value!))" }
        print(message)
        #else
//        if value != nil {
//            Analytics.logEvent(String(name), parameters: ["value": String(describing: value!)])
//        } else {
//            Analytics.logEvent(String(name), parameters: nil)
//        }
        #endif
    }
    
    // MAKR: - Auxiliary functions
    
    internal func internalPrint(file: String = #file, function: String = #function, line: Int = #line, column: Int = #column, severity: Severity, _ more: [Any?]) {
        
        #if DEBUG
        // nothing to do here
        #else
        return
        #endif
        
        // Guard the log serverity fits
        guard self.severity.rawValue <= severity.rawValue else { return }
        
        
        // Start line with date
        var message = Logger.default.formatter.string(from: Date())
        
        
        // Build line with prefix, filename, line and column
        message += " :: [\(severity.label)] :: [\(sourceFileName(filePath: file)) \(line):\(column)]"
        
        
        // Combine the arguments given in `more`
        let strMore = more.compactMap({
            return $0 == nil ? "nil" : "\($0!)"
        }).joined(separator: ", ")
        
        
        // Add the `more` string to the message
        message += " :: \(strMore)"
        
        
        // Check whether the message reached the max line length
        if message.count > maxLineLength {
            let index = message.index(message.startIndex, offsetBy: maxLineLength)
            message = message[..<index] + "..."
        }
        
        
        // Print the message
        print(message)
    }
    
    private func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!.replacingOccurrences(of: ".swift", with: "")
    }
}
