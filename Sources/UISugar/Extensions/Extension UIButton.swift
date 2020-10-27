//
//  ExtensionUIButton.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 04.03.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

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
