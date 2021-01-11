//
//  Device.swift
//  imHome
//
//  Created by Kevin Xu on 2/9/15. Updated on 6/20/15.
//  Copyright (c) 2015 Alpha Labs, Inc. All rights reserved.
//
#if os(iOS)
import UIKit

// MARK: - Device Structure

public struct Device {

    // MARK: - Singletons

    public static var TheCurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }

    public static var TheCurrentDeviceVersion: Float {
        struct Singleton {
            static let version = Float(UIDevice.current.systemVersion)!
        }
        return Singleton.version
    }

    public static var TheCurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.main.bounds.size.height
        }
        return Singleton.height
    }

    // MARK: - Device Idiom Checks

    public static var PHONE_OR_PAD: String {
        if isPhone() {
            return "iPhone"
        } else if isPad() {
            return "iPad"
        }
        return "Not iPhone nor iPad"
    }

    public static var DEBUG_OR_RELEASE: String {
        #if DEBUG
        return "Debug"
        #else
        return "Release"
        #endif
    }

    public static var SIMULATOR_OR_DEVICE: String {
        #if targetEnvironment(simulator)
        return "Simulator"
        #else
        return "Device"
        #endif
    }

    public static func isPhone() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .phone
    }

    public static func isPad() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .pad
    }

    public static func isDebug() -> Bool {
        return DEBUG_OR_RELEASE == "Debug"
    }

    public static func isRelease() -> Bool {
        return DEBUG_OR_RELEASE == "Release"
    }

    public static func isSimulator() -> Bool {
        return SIMULATOR_OR_DEVICE == "Simulator"
    }

    public static func isDevice() -> Bool {
        return SIMULATOR_OR_DEVICE == "Device"
    }

    // MARK: Retina Check

    public static func IS_RETINA() -> Bool {
        return UIScreen.main.responds(to: #selector(getter: UIScreen.main.scale))
    }
}
#endif
