//
//  UIPlaceholdableLabel.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 05.09.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

#if os(iOS)
import UIKit.UILabel

@IBDesignable
public class UIPlaceholdableLabel: UILabel {
   
   private lazy var placeholderLabel: UILabel = {
      let label = UILabel()
      addSubview(label)
      label.bindFrameToSuperviewBounds()
      label.contentMode = self.contentMode
      label.textAlignment = self.textAlignment
      label.font = self.font
      label.textColor = .lightGray
      return label
   }()
   
   
   // MARK: - Properties
   
   /// Placeholder to set for empty `text` values.
   @IBInspectable
   var placeholderText: String? {
      get { placeholderLabel.text }
      set { placeholderLabel.text = newValue }
   }
   
   /// The color of the placeholder text
   @IBInspectable
   var placeholderTextColor: UIColor {
      get { placeholderLabel.textColor }
      set { placeholderLabel.textColor = newValue }
   }
   
   /// Returns a Boolean value indicating whether the label currently displays the placeholder text.  If value of
   /// `placeholder` property is `nil` this computed property always returns `false`.
   open var isPlaceholding: Bool {
      return placeholderText != nil && super.text == nil
   }
   
   open func textDidChange() {
      if text == nil, placeholderLabel.isHidden {
         placeholderLabel.isHidden = false
      } else if !placeholderLabel.isHidden {
         placeholderLabel.isHidden = true
      }
   }
   
   
   // MARK: - Override UILabel
   
   // overriden in order to observe the value of the `text` property
   override public var text: String? {
      get { return super.text }
      set {
         super.text = newValue
         self.textDidChange()
      }
   }
   
   public override func prepareForInterfaceBuilder() {
      self.textDidChange()
   }
}
#endif
