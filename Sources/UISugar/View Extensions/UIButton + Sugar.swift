//
//  ExtensionUIButton.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 04.03.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIButton {
   
   convenience init(title: String, target: Any? = nil, action: Selector? = nil, tintColor: UIColor? = nil, titleColor: UIColor? = nil) {
      self.init(type: .system)
      setTitle(title, for: .normal)
      if let target = target, let action = action {
         self.addTarget(target, action: action, for: .touchUpInside)
      }
      if let tintColor = tintColor {
         self.tintColor = tintColor
      }
      if let titleColor = titleColor {
         setTitleColor(titleColor, for: .normal)
      }
   }
}
#endif
