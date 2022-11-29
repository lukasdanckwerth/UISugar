//
//  CommandLine + Convenience.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 10.08.21.
//

import Foundation

public typealias CommandLineArgument = String

public extension CommandLine {
    
    /// Returns a Boolean value indicating whether the command line arguments contains the specified `CommandLineArgument`.
    ///
    static func contains(_ argument: CommandLineArgument) -> Bool {
        return arguments.contains(argument)
    }
}
