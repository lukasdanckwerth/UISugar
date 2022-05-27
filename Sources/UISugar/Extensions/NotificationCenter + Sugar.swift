//
//  NotificationCenter + Convenience.swift
//  Times Your Age
//
//  Created by Lukas Danckwerth on 03.08.21.
//

import Foundation

/// Extends the `NotificationCenter` about some convenience functionality.
///
public extension NotificationCenter {
    
    /// Post a new `Notification` for the given name on the main dispatch queue.
    ///
    func postOnMainQueue(_ name: Notification.Name) {
        DispatchQueue.main.async {
            self.post(Notification(name: name))
        }
    }
}
