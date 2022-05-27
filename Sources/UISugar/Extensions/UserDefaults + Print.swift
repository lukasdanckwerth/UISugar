//
//  UserDefaults + Print.swift
//  
//
//  Created by Lukas Danckwerth on 11.08.21.
//

import Foundation

// ===--------------------------------------------------------------------------------------------------------------===
//
// MARK: - Print -
// ===--------------------------------------------------------------------------------------------------------------===
public extension UserDefaults {
    
    func print(defaultsName name: String, filterPrefix: String? = nil) {
        Swift.print(toString(defaultsName: name, filterPrefix: filterPrefix))
    }
    
    func toString(defaultsName name: String, filterPrefix: String? = nil) -> String {
        
        var dictionary = self.dictionaryRepresentation()
        
        if let filterPrefix = filterPrefix {
            dictionary = dictionary.filter({ $0.key.hasPrefix(filterPrefix) })
        }
        
        guard !dictionary.isEmpty else {
            return "\(name) Defaults is empty"
        }
        
        var content: String = """
        Print user defaults.
        
        Defaults Name:  \(name)
        Filter Prefix:  \(filterPrefix ?? "No filter selected.")
        
        
        """
        
        content += dictionary.map({ "- \($0) = \($1)" }).joined(separator: "\n")
        content += "\n"
        
        return content
    }
}
