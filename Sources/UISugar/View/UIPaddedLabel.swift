//
//  UIPaddedLabel.swift
//  UltraExpert-Go
//
//  Created by Lukas on 15.08.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import UIKit

@IBDesignable class UIPaddedLabel: UILabel {
    
    
    // MARK: - Properties
    
    /// The insets to
    @IBInspectable var padding: UIEdgeInsets = .zero
    
    /// Returns the intrinsic content size of the label with padding added.
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += (padding.left + padding.right)
        size.height += (padding.top + padding.bottom)
        return size
    }
    
    
    // MARK: - Override `UILabel`
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: padding.left, dy: padding.top))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.width += (padding.left + padding.right)
        size.height += (padding.top + padding.bottom)
        return size
    }
}
