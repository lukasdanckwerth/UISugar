//
//  UINotTappableView.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 26.03.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

class UINotTappableView: UIView {
    
    
    /// Override `hitTest` in order to only allow taps on subviews but not the view itself.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let subview = super.hitTest(point, with: event)
        return subview == self ? nil : subview
    }
}
#endif
