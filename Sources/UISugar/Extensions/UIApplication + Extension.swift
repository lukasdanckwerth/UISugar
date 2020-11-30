//
//  ExtensionUIApplication.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 26.04.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    /// Returns the status bar view
    var statusBarView: UIView? {
        guard responds(to: Selector(("statusBar"))) else { return nil }
        return value(forKey: "statusBar") as? UIView
    }
    
    /// Returns the display name of the application.
    ///
    var displayName: String? {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    /// Returns the name of the application.
    ///
    var name: String? {
        Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    /// Returns the build number of the application.
    ///
    var buildNumber: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    /// Returns the version of the application.
    ///
    var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// Returns a string with the version and build number of of the application.
    ///
    var fullVersion: String? {
        "\(version ?? "0") (\(buildNumber ?? "0"))"
    }
    
    /// Returns a string with the version and build number of of the application.
    ///
    var fullName: String? {
        "\(name ?? "Unknown") \(fullVersion ?? "-")"
    }
}
