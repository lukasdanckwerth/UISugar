//
//  ExtensionUITextField.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 16.02.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

extension UITextField {
   
   /// The overlay text displayed on the right (or trailing) side of the text field.
   var rightText: String? {
      get {
         guard let label = rightView as? UILabel else { return nil }
         return label.text
      }
      set {
         if let newValue = newValue {
            let label = UIPaddedLabel()
            label.text = " \(newValue)"
            label.textColor = .lightGray
            label.font = self.font
            label.padding.right += 8
            label.sizeToFit()
            rightView = label
            rightViewMode = .always
         } else if rightView is UILabel {
            rightView = nil
            rightViewMode = .never
         }
      }
   }
}
#endif
