//
//  ApplicationInfo + CoreTelephony.swift
//  
//
//  Created by Lukas Danckwerth on 21.08.21.
//

import Foundation

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
