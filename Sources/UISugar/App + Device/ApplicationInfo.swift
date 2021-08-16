//
//  ApplicationInfo.swift
//  
//
//  Created by Lukas on 30.11.20.
//
import Foundation

public struct ApplicationInfo {
    /// The default shared intance.
    ///
    public static let shared = ApplicationInfo()
    
    // MARK: - Main Bundle
    
    /// Returns the display name of the application.
    ///
    public var displayName: String? {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    /// Returns the localized display name of the application.
    ///
    public var localizedDisplayName: String? {
        guard let displayName = self.displayName else { return nil }
        return NSLocalizedString(displayName, comment: "")
    }
    
    /// Returns the name of the application.
    ///
    public var name: String? {
        Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    /// Returns the localized name of the application.
    ///
    public var localizedName: String? {
        guard let name = self.name else { return nil }
        return NSLocalizedString(name, comment: "")
    }
    
    /// Returns the build number of the application.
    ///
    public var buildNumber: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    /// Returns the version of the application.
    ///
    public var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// Returns a string with the version and build number of of the application.
    ///
    public var fullVersion: String? {
        "\(version ?? "0") (\(buildNumber ?? "0"))"
    }
    
    /// Returns a string with the version and build number of of the application.
    ///
    public var fullName: String? {
        "\(name ?? "Unknown") \(fullVersion ?? "-")"
    }
    
    /// Returns a localized string with the version and build number of of the application.
    ///
    public var localizedFullName: String? {
        "\(NSLocalizedString(name ?? "Unknown", comment: "")) \(fullVersion ?? "-")"
    }
}

protocol CarrierInfo {
    var carrierName: String? { get }
    var mobileCountryCode: String? { get }
    var mobileNetworkCode: String? { get }
    var isoCountryCode: String? { get }
}

#if canImport(CoreTelephony)
import CoreTelephony
#endif

extension ApplicationInfo {
    // MARK: - Carrier
    
    /// Returns the `CTCarrier` of the device.
    ///
    var carrier: CarrierInfo? {
        #if canImport(CTTelephonyNetworkInfo)
        return CTTelephonyNetworkInfo().subscriberCellularProvider
        #else
        return nil
        #endif
    }
    
    /// Returns the carrier's name.
    ///
    public var carrierName: String? {
        carrier?.carrierName
    }
    
    /// Returns the mobile country code.
    ///
    public var mobileCountryCode: String? {
        carrier?.mobileCountryCode
    }
    
    /// Returns the mobile network code.
    ///
    public var mobileNetworkCode: String? {
        carrier?.mobileNetworkCode
    }
    
    /// Returns the iso country code.
    ///
    public var isoCountryCode: String? {
        carrier?.isoCountryCode
    }
}
