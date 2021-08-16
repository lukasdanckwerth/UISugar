//
//  ExtensionFileManager.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 14.06.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

extension FileManager {
    
    
    /// Returns a Boolean value indicating whether the file at the given `URL` exists and is a directory.
    func directoryExists(atURL url: URL) -> Bool {
        return directoryExists(atPath: url.path)
    }
    
    /// Returns a Boolean value indicating whether the file at the given path exists and is a directory.
    func directoryExists(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = ObjCBool(false)
        return FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue
    }
}
