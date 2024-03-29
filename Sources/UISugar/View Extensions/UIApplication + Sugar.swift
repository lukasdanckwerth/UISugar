//
//  ExtensionUIApplication.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 26.04.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

public extension UIApplication {
    
    /// Returns the status bar view
    var statusBarView: UIView? {
        guard responds(to: Selector(("statusBar"))) else { return nil }
        return value(forKey: "statusBar") as? UIView
    }
}
#endif
