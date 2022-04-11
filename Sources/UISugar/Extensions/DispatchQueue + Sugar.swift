//
//  ExtensionDispatchQueue.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 26.08.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    
    /// Returns the defaul global background queue.  Shortcut for `DispatchQueue.global(qos: .background)`
    static var background: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
    /// Executes the given `background` block asyncron in the globel queue.  When passing a value for `completion`, the block is executed
    /// afterwards in the main queue.
    ///
    /// - parameter background:  The block to execute in the background.
    /// - parameter completion:  A block to execute in the main queue after that background block has been executed.
    static func background(_ background: @escaping (() -> Void), completion: (() -> Void)? = nil) {
        DispatchQueue.background.async {
            background()
            if let completion = completion {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}

