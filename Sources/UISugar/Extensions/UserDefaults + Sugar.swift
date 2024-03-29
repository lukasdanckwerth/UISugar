//
//  ExtensionUserDefaults.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 24.03.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit


// MARK: - Additional Objects Storage -

public extension UserDefaults {
    
    // MARK: - Add `UIColor` Storage
    
    /// Returns the `UIColor` object associated with the specified key.
    ///
    func color(forKey key: String) -> UIColor? {
        return objectFromData(forKey: key)
    }
    
    /// Sets the value of the specified default key to the specified `UIColor` object.
    ///
    func set(color: UIColor?, forKey key: String) {
        setObjectToData(t: color, forKey: key)
    }
    
    // MARK: - Add `Date` Storage
    
    /// Returns the `Date` object associated with the specified key.
    ///
    func date(forKey key: String) -> Date? {
        return value(forKey: key) as? Date
    }
    
    /// Sets the value of the specified default key to the specified `Date` object.
    ///
    func set(date: Date?, forKey key: String) {
        setValue(date, forKey: key)
    }
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Generic Storage Functions
    // ===-----------------------------------------------------------------------------------------------------------===
    
    // MARK: Archived Objects
    
    /// Returns the `T` object associated with the specified key.
    private func objectFromData<T: NSObject>(forKey key: String) -> T? where T: NSCoding {
        var t: T?
        if let data = self.data(forKey: key) {
            #if swift(>=5.0)
            if #available(iOS 11.0, *) {
                t = try? NSKeyedUnarchiver.unarchivedObject(ofClass: T.self, from: data)
            } else {
                t = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
            }
            #else
            t = NSKeyedUnarchiver.unarchiveObject(with: data) as? T
            #endif
        }
        return t
    }
    
    /// Sets the value of the specified default key to the specified `T` object.
    private func setObjectToData<T>(t: T?, forKey key: String) {
        var tData: NSData?
        if let t = t {
            #if swift(>=5.0)
            if #available(iOS 11.0, *) {
                tData = try? NSKeyedArchiver.archivedData(withRootObject: t, requiringSecureCoding: true) as NSData?
            } else {
                tData = NSKeyedArchiver.archivedData(withRootObject: t) as NSData?
            }
            #else
            tData = NSKeyedArchiver.archivedData(withRootObject: t) as NSData?
            #endif
        }
        set(tData, forKey: key)
    }
    
    // MARK: JSON
    
    /// Returns the `T` codable object associated with the specified key.
    func codable<T: Codable>(forKey key: String) -> T? {
        var t: T?
        if let jsonData = self.data(forKey: key) {
            t = try? JSONDecoder().decode(T.self, from: jsonData)
        }
        return t
    }
    
    /// Sets the value of the specified default key to the specified `T` codable object.
    func set<T: Codable>(codable: T?, forKey key: String) {
        #if DEBUG
        Swift.print("store \(key)", "\n", codable?.jsonData ?? Data())
        #endif
        set(codable?.jsonData, forKey: key)
    }
}

#endif
