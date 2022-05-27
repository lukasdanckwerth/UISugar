//
//  File.swift
//  
//
//  Created by Lukas Danckwerth on 11.09.20.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Extension `CGSize`
// ===-----------------------------------------------------------------------------------------------------------===

public extension CGSize {
    
    /// Returns the `x` position of the center.
    var centerX: CGFloat {
        return width / 2
    }
    
    /// Returns the `y` position of the center.
    var centerY: CGFloat {
        return height / 2
    }
    
    /// Returns the center.
    var center: CGPoint {
        return CGPoint(x: centerX, y: centerY)
    }
}
