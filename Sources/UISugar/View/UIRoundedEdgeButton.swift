//
//  UIRoundedEdgeButton.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 07.12.17.
//
#if os(iOS)
import UIKit

/** A simple button with round corners.
 - author: Lukas Danckwerth */
public class UIRoundedEdgeButton: UIButton {
    
    
    // MARK: - Properties
    
    /// The corner radius. Default is `WVDefaultCornerRadius()`.
    var cornerRadius: CGFloat = 4 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    
    /// Color of the layer border.
    var borderColor: UIColor? {
        didSet { layer.borderColor = borderColor?.cgColor }
    }
    
    /// Selected color when filled.
    var selectedColor: UIColor? = .clear
    
    /// Color of background color when filled.
    var disabledColor: UIColor = .clear
    
    /// Stores the background color when switch `isEnabled` changes the background color to disabled.
    private var enabledColor: UIColor?
    
    /// Boolean value indicating whether this button is drawn with filled background color.
    var isFilled: Bool = false {
        didSet { layer.borderWidth = isFilled ? 0 : 1 }
    }
    
    /// A Boolean value indicating whether this button draws a border.
    var isDrawsBorder: Bool = true
    
    /// A Boolean value indicating whether this button is enabled or not.
    public override var isEnabled: Bool {
        didSet {
            
            if oldValue && !isEnabled  { enabledColor = backgroundColor }
            self.backgroundColor = isEnabled ? enabledColor : disabledColor
            
            if !isEnabled {
                self.layer.borderColor = UIColor.lightGray.cgColor
            } else if let tintColor = tintColor {
                self.layer.borderColor = tintColor.cgColor
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
            
        }
    }
    
    /// Insets of the button. Default is `8` for left and right, and `0` for top and bottom.
    var insets: UIEdgeInsets? = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    /// Overriden in order to set the insets.
    override public var intrinsicContentSize: CGSize {
        if let insets = insets {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize
            intrinsicSuperViewContentSize.height += insets.top + insets.bottom
            intrinsicSuperViewContentSize.width += insets.left + insets.right
            return intrinsicSuperViewContentSize
        }
        return super.intrinsicContentSize
    }
    
    /// Reference to a possible represented object.
    public var selectableCharacter: Any?
    
    
    // MARK: - Initialization
    
    private convenience init() {
        self.init(frame: .zero)
    }
    
    /// Initialization from given frame.
    override private init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    /// Initialization from storyboard.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    /// Sets a border, the rounded corners and colors.
    private func style() {
        
        enabledColor = backgroundColor
        layer.cornerRadius = cornerRadius
        
        if !self.isFilled && isDrawsBorder {
            layer.borderWidth = 1.0
            
            if let borderColor = borderColor {
                layer.borderColor = borderColor.cgColor
            } else if let tintColor = tintColor {
                layer.borderColor = tintColor.cgColor
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
        }
        
    }
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        if !isFilled && isDrawsBorder {
            layer.borderColor = tintColor.cgColor
        }
    }
    
    /// Overriden in order to style the button when a touch begins.
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if isDrawsBorder {
            if self.isFilled {
                backgroundColor = self.selectedColor
            } else if let borderColor = self.borderColor {
                layer.borderColor = borderColor.withAlphaComponent(0.4).cgColor
            } else if let tintColor = self.tintColor {
                layer.borderColor = tintColor.withAlphaComponent(0.4).cgColor
            }
        }
        
        setNeedsDisplay()
    }
    
    /// Overriden in order to style the button when a touch ends.
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        styleToDefault()
    }
    
    /// Overriden in order to style the button when a touch cancels.
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        styleToDefault()
    }
    
    /// Set the colors of the button to default.
    private func styleToDefault() {
        
        guard isDrawsBorder else { return }
        
        if isFilled {
            backgroundColor = enabledColor
        } else if let borderColor = borderColor {
            layer.borderColor = borderColor.cgColor
        } else if let tintColor = tintColor {
            layer.borderColor = tintColor.cgColor
        }
        setNeedsDisplay()
    }
}
#endif
