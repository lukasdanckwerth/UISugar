//
//  CGFrame + Extension.swift
//  Chopper
//
//  Created by Lukas Danckwerth on 04.09.20.
//  Copyright © 2020 Anika. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Extension `CGRect`
// ===-----------------------------------------------------------------------------------------------------------===

public extension CGRect {
    
    /// Returns the `x` value of the origin.
    var x: CGFloat {
        return origin.x
    }
    
    /// Returns the `y` value of the origin.
    var y: CGFloat {
        return origin.y
    }
    
    /// Returns the position of this rectangle's `x` + `width`.
    var backX: CGFloat {
        return x + width
    }
    
    /// Returns the position of this rectangle's `y` + `height`.
    var backY: CGFloat {
        return x + width
    }
    
    /// Returns the `x` position of the center.
    var centerX: CGFloat {
        return width / 2
    }
    
    /// Returns the `y` position of the center.
    var centerY: CGFloat {
        return height / 2
    }
    
    /// Returns the center point of this rectangle.
    var center: CGPoint {
        return CGPoint(x: centerX, y: centerY)
    }
}
