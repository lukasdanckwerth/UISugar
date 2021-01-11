//
//  ExtensionURL.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 14.08.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

extension URL {
   
   /// Returns the default `FileManager`
   var fileManager: FileManager {
      return FileManager.default
   }
   
   /// A Boolean value indicating whether the file exists.
   var exists: Bool {
      return FileManager.default.fileExists(atPath: path)
   }
   
   /// Returns a boolean value indicating wheather the receiving `URL` is a directory.
   var isDirectory: Bool {
      var isDirectory: ObjCBool = false
      FileManager.default.fileExists(atPath: self.path, isDirectory: &isDirectory)
      return isDirectory.boolValue
   }
   
   /// Returns the pure file name WITH extension.
   var filename: String { lastPathComponent }
   
   /// Returns the pure file name WITHOUT extension.
   var pureFilename: String {
      deletingPathExtension().lastPathComponent
   }
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Read
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Returns an array of `URL`s in the given directory.
   func contents() -> [URL] {
      return (try? FileManager.default.contentsOfDirectory(
         at: self,
         includingPropertiesForKeys: nil,
         options: .skipsHiddenFiles
         )) ?? []
   }
   
   
   // MARK: - Copy
   
   @discardableResult func copy(to destinationURL: URL) -> Bool {
      guard self.exists else { return false }
      guard !destinationURL.exists else { return false }
      
      do {
         try FileManager.default.copyItem(at: self, to: destinationURL)
         return true
      } catch {
         print(error)
         return false
      }
   }
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Remove
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Removes the file at the given `URL` only if it exists.
   @discardableResult func removeIfExist() -> Bool {
      guard self.exists else { return true }
      return removeItem()
   }
   
   /// Removes the file at the given `URL`.
   @discardableResult func removeItem() -> Bool {
      do {
         try remove()
         return true
      } catch {
         print(error)
         return false
      }
   }
   
   /// Removes the file specified by the receiver
   func remove() throws {
      try FileManager.default.removeItem(at: self)
   }
   
   /// Removes all files in the directory
   func removeContents() throws {
      guard isDirectory else { return }
      for fileURL in self.contents() {
         try fileURL.remove()
      }
   }
   
   /// Removes all files in the directory  (without throwing an error)
   func removeContentsUnsafe() {
      try? removeContents()
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: -
   // ===-----------------------------------------------------------------------------------------------------------===
   
   var attributes: [FileAttributeKey : Any]? {
      return try? fileManager.attributesOfItem(atPath: self.path)
   }
   
   /// Returns the modification date ofo the file
   var modificationDate: Date? {
      return attributes?[FileAttributeKey.modificationDate] as? Date
   }
   
   /// Returns the creation date of the file
   var creationDate: Date? {
      return attributes?[FileAttributeKey.creationDate] as? Date
   }
   
   /// Returns the size of the file in bytes
   var size: UInt64 {
      return attributes?[FileAttributeKey.size] as? UInt64 ?? 0
   }
   
   /// Returns the size of the folder at the given `URL` in bytes.  Size is calculated recursivly.
   var directorySize: UInt64 {
      
      var size: UInt64 = 0
      
      do {
         for url in try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) {
            
            var isDirectory: ObjCBool = false
            if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) {
               
               if isDirectory.boolValue {
                  size += url.directorySize
               } else {
                  size += url.size
               }
            }
         }
      } catch {
         print(error)
      }
      
      return size
   }
   
   /// Returns a formatted string representing the size of the item at the given `URL`.
   var formattedSize: String {
      URL.covertToFileString(with: self.size)
   }
   
   /// Returns a formatted string representing the size of the folder at the given `URL`.
   var formattedDirectorySize: String {
      URL.covertToFileString(with: self.directorySize)
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Convenience
   // ===-----------------------------------------------------------------------------------------------------------===
   
   func relativTo(_ baseURL: URL = .mainApplicationURL, replacement: String = "..") -> String {
      relativePath.replacingOccurrences(of: baseURL.path, with: replacement)
   }
   
   /// Returns an alternative `URL` for the receiver IF the receiver already exist;  returns the receiver else
   var toNonExistendFileURL: URL {
      let pureName = self.pureFilename
      let theExtension = self.pathExtension
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
   
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Statics
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Removes all files in the given directory ending with given extensions.
   static func removeItems(inDirectory: URL, withExtensions extensions: [String]) {
      removeItems(inDirectory.contents().filter({ extensions.contains($0.pathExtension) }))
   }
   
   /// Removes all files in the given collection of URLs.
   static func removeItems(_ urls: [URL]) {
      urls.forEach({ $0.removeIfExist() })
   }
   
   /// Returns a formatted string of the given size.
   static func covertToFileString(with size: UInt64) -> String {
      var convertedValue: Double = Double(size)
      var multiplyFactor = 0
      let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
      while convertedValue > 1024 {
         convertedValue /= 1024
         multiplyFactor += 1
      }
      return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
   }
}

// ===--------------------------------------------------------------------------------------------------------------===
//
// MARK: - Temporary Files
// ===--------------------------------------------------------------------------------------------------------------===

extension URL {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initializer for tempoary files
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
   init(temporaryFileWithExtension anExtension: String? = nil) {
      let directory = URL.temporaryDirectoryURL
      var url = directory.appendingPathComponent(NSUUID().uuidString)
      if let theExtension = anExtension {
         url.appendPathExtension(theExtension)
      }
      self = url.exists ? URL(temporaryFileWithExtension: anExtension) : url
   }
   
   /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
   static func createTemporaryFileURL(withExtension aExtension: String? = nil) -> URL {
      let directory = URL.temporaryDirectoryURL
      var url = directory.appendingPathComponent(NSUUID().uuidString)
      if let aExtension = aExtension { url.appendPathExtension(aExtension) }
      return url.exists ? createTemporaryFileURL(withExtension: aExtension) : url
   }
   
   /// Runs in background.  The `completion` block is called from main thread
   static func clearTemoraryDirectory(completion: (() -> ())? = nil) {
      DispatchQueue.global(qos: .background).async {
         try? temporaryDirectoryURL.removeContents()
         guard let completion = completion else { return }
         DispatchQueue.main.async { completion() }
      }
   }
}

// ===--------------------------------------------------------------------------------------------------------------===
//
// MARK: - Application URLs
// ===--------------------------------------------------------------------------------------------------------------===

extension URL {
   
   /// Reference to the app's document directory (`"../"`)
   public static var mainApplicationURL: URL {
      URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
   }
   
   /// Reference to the app's tmp directory (`"../tmp"`)
   public static var temporaryDirectoryURL: URL {
      URL(fileURLWithPath: NSTemporaryDirectory())
   }
   
   /// Reference to the app's library directory (`"../Library"`)
   public static var libraryDirectoryURL: URL {
      FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
   }
   
   /// Reference to the app's preferences directory (`"../Library/Preferences"`)
   public static var preferencesDirectoryURL: URL {
      libraryDirectoryURL.appendingPathComponent("Preferences", isDirectory: true)
   }
   
   /// Reference to the app's library support directory (`"../Library/Application Support"`)
   public static var librarySupportDirectoryURL: URL {
      FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
   }
   
   /// Reference to the app's document directory (`"../Documents"`)
   public static var documentsDirectoryURL: URL {
      FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
   }
}
