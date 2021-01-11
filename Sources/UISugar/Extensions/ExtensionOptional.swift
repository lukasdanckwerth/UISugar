//
//  ExtensionOptional.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 01.03.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

/// ExtensionOptional
///
/// - author: Lukas Danckwerth
extension Optional {
    
    
    func or(_ string: String) -> String {
        return self as? String ?? string
    }
    
    func or(_ value: Wrapped) -> Wrapped {
        return self ?? value
    }
}

extension Optional where Wrapped == String {
    
    
    func or(_ string: String) -> String {
        return self ?? string
    }
}
