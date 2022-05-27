//
//  UserDefaults+Saveable.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 26.01.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// MARK: - Saveable -

protocol UserDefaultsSaveable {
    func save(userDefaults: UserDefaults, key: String)
    func save(key: String)
}

extension UserDefaultsSaveable {
    
    func save(userDefaults: UserDefaults, key: String) {
        userDefaults.set(self, forKey: key)
    }
    
    func save(key: String) {
        self.save(userDefaults: UserDefaults.standard, key: key)
    }
}

// MARK: - Loadable -

protocol UserDefaultsLoadable {
    init?(userDefaults: UserDefaults, key: String)
    init?(key: String)
}

extension UserDefaultsLoadable {
    
    init?(key: String) {
        self.init(userDefaults: .standard, key: key)
    }
}

// MARK: - Typealias `UserDefaultsable` -

typealias UserDefaultsable = UserDefaultsSaveable & UserDefaultsLoadable

// MARK: - "Primitives" + `UserDefaultsable` -

extension Int: UserDefaultsable {
    init?(userDefaults: UserDefaults, key: String) {
        self = userDefaults.integer(forKey: key)
    }
}

extension Float: UserDefaultsable {
    init?(userDefaults: UserDefaults, key: String) {
        self = userDefaults.float(forKey: key)
    }
}

extension Double: UserDefaultsable {
    init?(userDefaults: UserDefaults, key: String) {
        self = userDefaults.double(forKey: key)
    }
}

extension Bool: UserDefaultsable {
    init?(userDefaults: UserDefaults, key: String) {
        self = userDefaults.bool(forKey: key)
    }
}

extension String: UserDefaultsable {
    init?(userDefaults: UserDefaults, key: String) {
        guard let string = userDefaults.string(forKey: key) else { return nil }
        self = string
    }
}

// MARK: - `RawRepresentable` + `UserDefaultsLoadable`

extension RawRepresentable where RawValue == Int, Self: UserDefaultsLoadable {
    init?(userDefaults: UserDefaults, key: String) {
        self.init(rawValue: userDefaults.integer(forKey: key))
    }
}

extension RawRepresentable where RawValue == Float, Self: UserDefaultsLoadable {
    init?(userDefaults: UserDefaults, key: String) {
        self.init(rawValue: userDefaults.float(forKey: key))
    }
}

extension RawRepresentable where RawValue == Double, Self: UserDefaultsLoadable {
    init?(userDefaults: UserDefaults, key: String) {
        self.init(rawValue: userDefaults.double(forKey: key))
    }
}

extension RawRepresentable where RawValue == Bool, Self: UserDefaultsLoadable {
    init?(userDefaults: UserDefaults, key: String) {
        self.init(rawValue: userDefaults.bool(forKey: key))
    }
}

extension RawRepresentable where RawValue == String, Self: UserDefaultsLoadable {
    init?(userDefaults: UserDefaults, key: String) {
        guard let string = userDefaults.string(forKey: key) else { return nil }
        self.init(rawValue: string)
    }
}

// MARK: - `RawRepresentable` + `UserDefaultsSaveable`

extension RawRepresentable where Self: UserDefaultsSaveable {
    
    func save(userDefaults: UserDefaults, key: String) {
        userDefaults.set(self.rawValue, forKey: key)
    }
}
