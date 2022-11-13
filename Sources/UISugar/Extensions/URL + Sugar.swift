//
//  ExtensionURL.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 14.08.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension URL {
    
    // ===--------------------------------------------------------------------------===
    // MARK: - Convenience
    
    /// Returns the default `FileManager`.
    ///
    var fileManager: FileManager {
        return FileManager.default
    }
    
    /// A Boolean value indicating whether the file exists.
    ///
    var exists: Bool {
        return fileManager.fileExists(atPath: path)
    }
    
    // ===--------------------------------------------------------------------------===
    // MARK: - Attributes
    
    /// Returns the attributes dictionary.
    ///
    var attributes: [FileAttributeKey : Any]? {
        return try? fileManager.attributesOfItem(atPath: path)
    }
    
    /// Returns the modification date ofo the file.
    ///
    var modificationDate: Date? {
        return attributes?[FileAttributeKey.modificationDate] as? Date
    }
    
    /// Returns the creation date of the file.
    ///
    var creationDate: Date? {
        return attributes?[FileAttributeKey.creationDate] as? Date
    }
    
    /// Returns the size of the file in bytes.
    ///
    var size: UInt64 {
        return attributes?[FileAttributeKey.size] as? UInt64 ?? 0
    }
    
    /// Returns the size of the folder at the given `URL` in bytes.  Size is calculated recursivly.
    ///
    var directorySize: UInt64 {
        var size: UInt64 = 0
        contents.forEach({
            if $0.isDirectory {
                size += $0.directorySize
            } else {
                size += $0.size
            }
        })
        return size
    }
    
    /// Returns a formatted string representing the size of the item at the given `URL`.
    ///
    var formattedSize: String {
        return URL.covertToFileString(with: size)
    }
    
    /// Returns a formatted string representing the size of the folder at the given `URL`.
    ///
    var formattedDirectorySize: String {
        return URL.covertToFileString(with: directorySize)
    }
    
    /// Returns a formatted string of the given size.
    ///
    private static func covertToFileString(with size: UInt64) -> String {
        var convertedValue: Double = Double(size)
        var multiplyFactor = 0
        let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
    }
    
    /// Returns the pure file name WITH extension.
    ///
    var filename: String {
        return lastPathComponent
    }
    
    /// Returns the pure file name WITHOUT extension.
    ///
    var pureFilename: String {
        return deletingPathExtension().lastPathComponent
    }
    
    // ===--------------------------------------------------------------------------===
    // MARK: - Directories
    
    /// Returns a Boolean value indicating wheather the receiving `URL` is a directory.
    ///
    var isDirectory: Bool {
        var isDirectory: ObjCBool = false
        return fileManager.fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue
    }
    
    /// Returns an array of `URL`s in the given directory. Does not throw errors. Use `getContents()` if you want to be notified for errors.
    ///
    var contents: [URL] {
        return (try? getContents()) ?? []
    }
    
    /// Returns an array of `URL`s in the receiving directory recursively.  Does not throw errors. Use `getContentsRecursively()` if you want to be notified for errors.
    ///
    var contentsRecursively: [URL] {
        return (try? getContentsRecursively()) ?? []
    }
    
    /// Returns an array of `URL`s in the given directory.
    ///
    func getContents() throws -> [URL] {
        return try fileManager.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
    }
    
    /// Returns an array of `URL`s in the receiving directory recursively.
    ///
    func getContentsRecursively() throws -> [URL] {
        var urls: [URL] = []
        try getContents().forEach({
            urls.append($0)
            if $0.isDirectory {
                urls.append(contentsOf: try $0.getContentsRecursively())
            }
        })
        return urls
    }
    
    /// Returns the path of the receiving `URL` relative to the main application directory.
    ///
    var relativeToApplicationPath: String {
        return relativeTo()
    }
    
    /// Returns the path of the receiving `URL` relative to the specified `URL`.
    ///
    func relativeTo(_ otherURL: URL = URL.mainApplicationURL, replacement: String = "- ") -> String {
        return relativePath.replacingOccurrences(of: otherURL.path, with: replacement)
    }
    
    // MARK: Temporary files
    
    /// Returns a URL for randomly named file in the temporary directory.
    ///
    private static var randomTemporaryFileURL: URL {
        //        return URL.temporaryDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension(Document.fileExtension)
        return URL.temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)
    }
    
    /// Returns a URL for randomly named file in the temporary directory. Its guranteed a file at this URL doesn't exist.
    ///
    static func temporaryFileURL() -> URL {
        var fileURL = randomTemporaryFileURL
        while fileURL.exists {
            fileURL = randomTemporaryFileURL
        }
        return fileURL
    }
    
    
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
    ///
    init(temporaryFileWithExtension anExtension: String? = nil) {
        let directory = URL.temporaryDirectoryURL
        var url = directory.appendingPathComponent(NSUUID().uuidString)
        if let theExtension = anExtension {
            url.appendPathExtension(theExtension)
        }
        self = url.exists ? URL(temporaryFileWithExtension: anExtension) : url
    }
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
    ///
    static func createTemporaryFileURL(withExtension aExtension: String? = nil) -> URL {
        let directory = URL.temporaryDirectoryURL
        var url = directory.appendingPathComponent(NSUUID().uuidString)
        if let aExtension = aExtension { url.appendPathExtension(aExtension) }
        return url.exists ? createTemporaryFileURL(withExtension: aExtension) : url
    }
    
    /// Runs in background.  The `completion` block is called from main thread
    ///
    static func clearTemoraryDirectory(completion: (() -> ())? = nil) {
        DispatchQueue.global(qos: .background).async {
            try? temporaryDirectoryURL.removeContents()
            guard let completion = completion else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    
    // MARK: - Copy
    
    @discardableResult func copy(to destinationURL: URL) -> Bool {
        guard exists else { return false }
        guard !destinationURL.exists else { return false }
        
        do {
            try fileManager.copyItem(at: self, to: destinationURL)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    
    // ===--------------------------------------------------------------------------===
    // MARK: - Remove
    
    /// Removes the file specified by the receiver.
    ///
    func remove() throws {
        try fileManager.removeItem(at: self)
    }
    
    /// Removes all files in the directory.
    ///
    func removeContents() throws {
        for fileURL in try getContents() {
            try fileURL.remove()
        }
    }
    
    /// Removes the file specified by the receiver. Does not throw errors.
    ///
    func removeUnsafe() {
        try? remove()
    }
    
    /// Removes all files in the directory. Does not throw errors.
    ///
    func removeContentsUnsafe() {
        try? removeContents()
    }
    
    /// Removes the file at the given `URL` only if it exists.
    ///
    @discardableResult func removeIfExist() -> Bool {
        return !exists || removeItem()
    }
    
    /// Removes the file at the given `URL`.
    ///
    @discardableResult func removeItem() -> Bool {
        do {
            try remove()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    // ===--------------------------------------------------------------------------===
    // MARK: - Application URLs
    
    /// Reference to the applications directory (`"/"`)
    ///
    static var mainApplicationURL: URL {
        return URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
    }
    
    /// Reference to the applications tmp directory (`"/tmp"`)
    ///
    static var temporaryDirectoryURL: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    /// Return the URL of the applications Documents directory (`"/Documents"`).
    ///
    static var documentsDirectoryURL: URL! {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    /// Reference to the app's library directory (`"/Library"`)
    ///
    static var libraryDirectoryURL: URL! {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
    }
    
    /// Reference to the app's preferences directory (`"/Library/Preferences"`)
    ///
    static var preferencesDirectoryURL: URL {
        return libraryDirectoryURL.appendingPathComponent("Preferences", isDirectory: true)
    }
    
    /// Reference to the app's library support directory (`"/Library/Application Support"`)
    ///
    static var librarySupportDirectoryURL: URL! {
        return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
    }
    
    // ===--------------------------------------------------------------------------===
    // MARK: - Convenience
    
    /// Returns an alternative `URL` for the receiver IF the receiver already exist;  returns the receiver else
    ///
    var toNonExistendFileURL: URL {
        let pureName = pureFilename
        let theExtension = pathExtension
        var index = 1
        var candidate = self
        let directoryURL = candidate.deletingLastPathComponent()
        while candidate.exists {
            candidate = directoryURL
                .appendingPathComponent("\(pureName)_\(index)")
                .appendingPathExtension(theExtension)
            index += 1
        }
        return candidate
    }
    
    func printContents() {
        print("contents of: \(relativePath)")
        contentsRecursively.forEach({
            if $0.isDirectory {
                print("\($0.relativeToApplicationPath) (\($0.contents.count == 0 ? "empty" : "\($0.contents.count) Files"))")
            } else {
                print("\($0.relativeToApplicationPath) (\($0.formattedSize))")
            }
        })
    }
}
