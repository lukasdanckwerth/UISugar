//
//  ExtensionEncodable.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 11.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

extension Encodable {
   
   
   var dictionary: [String: Any]! {
      guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
   }
   
   var jsonData: Data? {
      do {
         return try JSONEncoder().encode(self)
      } catch let error {
         print(error)
         return nil
      }
   }
   
   var prettyJSONData: Data? {
      do {
         let encoder = JSONEncoder()
         encoder.outputFormatting = .prettyPrinted
         return try encoder.encode(self)
      } catch let error {
         print(error)
         return nil
      }
   }
   
   var jsonString: String? {
      if let jsonData = self.jsonData {
         return String(data: jsonData, encoding: .utf8)
      }
      return nil
   }
   
   var prettyJSONString: String? {
      if let prettyJSONData = self.prettyJSONData {
         return String(data: prettyJSONData, encoding: .utf8)
      }
      return nil
   }
   
   func write(to destinationURL: URL) throws {
      try self.jsonData?.write(to: destinationURL, options: .atomic)
   }
   
   @discardableResult func writeSimple(to destinationURL: URL) -> Bool {
      do {
         try write(to: destinationURL)
         return true
      } catch {
         return false
      }
   }
}

extension Encodable where Self: Decodable {
   
   
   /// Returns a copy of this `Codable`.  The copy is created by decoding and encoding this `Codable` to and from `Data`.
   var copy: Self? {
      do {
         return try JSONDecoder().decode(Self.self, from: JSONEncoder().encode(self))
      } catch let error {
         NSLog("Can't copy \(self).  \(error)")
      }
      return nil
   }
   
   static func fromJSON(jsonString: String) -> Self? {
      if let jsonData = jsonString.data(using: .utf8) {
         return try? JSONDecoder().decode(Self.self, from: jsonData)
      }
      return nil
   }
   
   init?(jsonURL: URL?) {
      guard let jsonURL = jsonURL else { return nil }
      do {
         self = try JSONDecoder().decode(Self.self, from: try Data(contentsOf: jsonURL))
      } catch {
         return nil
      }
   }
}
