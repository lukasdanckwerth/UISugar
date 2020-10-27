//
//  ExtensionUIColor.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 30.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

public extension UIColor {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - WinValue Colors
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Returns the default WinValue red color
    static var wvRed: UIColor {
        // UIColor(red: 190/255, green: 38/255, blue: 37/255, alpha: 1.0) /* #be2625 */
        return #colorLiteral(red: 0.7451, green: 0.149, blue: 0.1451, alpha: 1)
    }
    
    /// Returns the default WinValue blue color
    static var wvBlue: UIColor {
        // UIColor(red: 26/255, green: 94/255, blue: 142/255, alpha: 1.0) /* #1a5e8e */
        return #colorLiteral(red: 0.102, green: 0.3686, blue: 0.5569, alpha: 1)
    }
    
    /// Returns the default WinValue light blue.
    static var wvLightBlue: UIColor {
        // UIColor(red: 57/255, green: 152/255, blue: 220/255, alpha: 1.0) /* #3998dc */
        return #colorLiteral(red: 0.2235, green: 0.5961, blue: 0.8627, alpha: 1)
    }
    
    /// Returns the default WinValue turkey.
    static var wvTurkey: UIColor {
        // UIColor(red: 90/255, green: 197/255, blue: 211/255, alpha: 1.0) /* #5ac5d3 */
        return #colorLiteral(red: 0.3529, green: 0.7725, blue: 0.8275, alpha: 1)
    }
    
    /// Returns the default WinValue gray.
    static var wvGray: UIColor {
        // UIColor(red: 225/255, green: 229/255, blue: 236/255, alpha: 1.0) /* #e1e5ec */
        return #colorLiteral(red: 0.8824, green: 0.898, blue: 0.9255, alpha: 1)
    }
    
    
    /// Returns the default WinValue yellow for bookmark star.
    static var wvYellow: UIColor {
        return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - WinValue RestwertBoerse Colors
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// The default RB orange color.
    // static let restwertBoerseOrange = #colorLiteral(red: 0.9007799029, green: 0.4747456312, blue: 0.1764956713, alpha: 1)
    static let restwertBoerseOrange: UIColor = .systemOrange
    
    /// The default RB orange color.
    static let rbOrange = UIColor.restwertBoerseOrange
    
    /// The default RB tint color.
    static let restwertBoerseTint: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return .systemOrange
                } else {
                    return .wvBlue
                }
            })
        } else {
            return .wvBlue
        }
    }()
    
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - WinValue UltraExpert Colors
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// The default UX purple color.
    static let ultraExpertPurple = #colorLiteral(red: 0.448834002, green: 0.2150844932, blue: 0.5962926745, alpha: 1)
    
    /// The default UX purple color.
    static let uxPurple = UIColor.ultraExpertPurple
    
    
    
    /// The default tint color for the app.  For now this is `UIColor.wvBlue`.
    static let defaultTintColor = UIColor.wvBlue // UIButton.appearance().tintColor
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - System Colors
    // ===-----------------------------------------------------------------------------------------------------------===
    
    static var officialAppleLabelPlaceholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
    
    static let system = UIButton.appearance().tintColor
    
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Extension UIColor by Grigory Avdyushin
// ===-----------------------------------------------------------------------------------------------------------===
//
//  UIColor.swift
//  Flat UI Colors
//
//  Created by Grigory Avdyushin on 22.01.15.
//  Copyright (c) 2015-2019 Grigory Avdyushin. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// Color formats
    enum ColorFormat: Int {
        
        case RGB = 12
        case RGBA = 16
        case RRGGBB = 24
        
        init?(bitsCount: Int) {
            self.init(rawValue: bitsCount)
        }
        
    }
    
    /// Returns color with given hex string
    convenience init(string: String) {
        let string = string.replacingOccurrences(of: "#", with: "")
        
        guard
            let hex = Int(string, radix: 16),
            let format = ColorFormat(bitsCount: string.count * 4) else {
                self.init(white: 0, alpha: 0)
                return
        }
        
        self.init(hex: hex, format: format)
    }
    
    /// Returns color with given hex integer value and color format
    convenience init(hex: Int, format: ColorFormat = .RRGGBB) {
        
        let red: Int, green: Int, blue: Int, alpha: Int
        
        switch format {
        case .RGB:
            red   = ((hex & 0xf00) >> 8) << 4 + ((hex & 0xf00) >> 8)
            green = ((hex & 0x0f0) >> 4) << 4 + ((hex & 0x0f0) >> 4)
            blue  = ((hex & 0x00f) >> 0) << 4 + ((hex & 0x00f) >> 0)
            alpha = 255
            break;
        case .RGBA:
            red   = ((hex & 0xf000) >> 12) << 4 + ((hex & 0xf000) >> 12)
            green = ((hex & 0x0f00) >>  8) << 4 + ((hex & 0x0f00) >>  8)
            blue  = ((hex & 0x00f0) >>  4) << 4 + ((hex & 0x00f0) >>  4)
            alpha = ((hex & 0x000f) >>  0) << 4 + ((hex & 0x000f) >>  4)
            break;
        case .RRGGBB:
            red   = ((hex & 0xff0000) >> 16)
            green = ((hex & 0x00ff00) >>  8)
            blue  = ((hex & 0x0000ff) >>  0)
            alpha = 255
            break;
        }
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
    
    /// Returns integer color representation
    var asInt: Int {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (Int)(r * 255) << 16 | (Int)(g * 255) << 8  | (Int)(b * 255)  << 0
    }
    
    /// Returns hex string color representation
    var asHexString: String {
        return String(format:"#%06x", asInt)
    }
    
    /// Returns color with adjusted saturation or/and brightness
    func withAdjusted(saturation: CGFloat = 0.0, brightness: CGFloat = 0.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else {
            return self
        }
        
        return UIColor(
            hue: h,
            saturation: min(max(s + saturation, 0.0), 1.0),
            brightness: min(max(b + brightness, 0.0), 1.0),
            alpha: a
        )
    }
    
    /// Returns lighter color by 25%
    var lighterColor: UIColor {
        return self.withAdjusted(saturation: -0.25)
    }
    
    /// Return darker color by 25%
    var darkerColor: UIColor {
        return self.withAdjusted(brightness: -0.25)
    }
}

/// Flat UI Palette v1
/// https://flatuicolors.com/palette/defo
public extension UIColor {
    
    // Green / Sea
    static let flatTurquoise = UIColor(hex: 0x1ABC9C)
    static let flatGreenSea = UIColor(hex: 0x16A085)
    // Green
    static let flatEmerald = UIColor(hex: 0x2ECC71)
    static let flatNephritis = UIColor(hex: 0x27AE60)
    // Blue
    static let flatPeterRiver = UIColor(hex: 0x3498DB)
    static let flatBelizeHole = UIColor(hex: 0x2980B9)
    // Purple
    static let flatAmethyst = UIColor(hex: 0x9B59B6)
    static let flatWisteria = UIColor(hex: 0x8E44AD)
    // Dark blue
    static let flatWetAsphalt = UIColor(hex: 0x34495E)
    static let flatMidnightBlue = UIColor(hex: 0x2C3E50)
    // Yellow
    static let flatSunFlower = UIColor(hex: 0xF1C40F)
    static let flatOrange = UIColor(hex: 0xF39C12)
    // Orange
    static let flatCarrot = UIColor(hex: 0xE67E22)
    static let flatPumkin = UIColor(hex: 0xD35400)
    // Red
    static let flatAlizarin = UIColor(hex: 0xE74C3C)
    static let flatPomegranate = UIColor(hex: 0xC0392B)
    // White
    static let flatClouds = UIColor(hex: 0xECF0F1)
    static let flatSilver = UIColor(hex: 0xBDC3C7)
    // Gray
    static let flatAsbestos = UIColor(hex: 0x7F8C8D)
    static let flatConcerte = UIColor(hex: 0x95A5A6)
}
#endif
