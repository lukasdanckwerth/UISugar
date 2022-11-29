//
//  UIFilledLabel.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 07.12.17.
//
#if canImport(UIKit)
import UIKit

/** Used for offer type with either R (Restwertboerse) or F (Flotte) */
public class UIFilledLabel: UILabel {
    
    
    // MARK: - Fields
    
    var insets: UIEdgeInsets?
    
    override public var intrinsicContentSize: CGSize {
        guard let insets = insets else {
            return super.intrinsicContentSize
        }
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += insets.top + insets.bottom
        intrinsicSuperViewContentSize.width += insets.left + insets.right
        return intrinsicSuperViewContentSize
    }
    
    /// Background color for filled label.
    public var filledBackgroundColor: UIColor? {
        didSet {
            if let filledBackgroundColor = filledBackgroundColor {
                backgroundColor = UIColor.clear
                textColor = UIColor.white
                layer.backgroundColor = filledBackgroundColor.cgColor
            }
        }
    }
    
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        styleMe()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        styleMe()
    }
    
    private func styleMe() {
        backgroundColor = UIColor.clear
        textColor = UIColor.white
    }
    
    override public func drawText(in rect: CGRect) {
        super.drawText(in: insets == nil ? rect : rect.insetBy(dx: insets!.left, dy: insets!.top))
    }
}
#endif
