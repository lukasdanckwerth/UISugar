//
//  Secrets.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 05.11.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

struct Secrets {
    
    func store(secret: String, forKey key: String) throws {
        
        let keyData = key.data(using: .utf8)!
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: keyData,
            kSecValueRef as String: secret
        ]
        
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        
        guard status == errSecSuccess else { throw SecretsError.storingError }
        
    }
    
    func getSecret(forKey key: String) throws -> String? {
        
        let getQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: key,
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecReturnRef as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getQuery as CFDictionary, &item)
        
        guard status == errSecSuccess else { throw SecretsError.loadingError }
        
        let secret = item as! SecKey
        
        print("secret: ", secret)
        
        return "\(secret)"
    }
}

extension Secrets {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - `SecretsError`
    // ===-----------------------------------------------------------------------------------------------------------===
    
    public enum SecretsError: Error {
        
        case storingError
        
        case loadingError
        
    }
}
