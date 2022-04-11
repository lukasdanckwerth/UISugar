//
//  Extension UIFont.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 29.02.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit.UIFont

extension UIFont {
   static var buttonFont: UIFont {
      return UIFont.systemFont(ofSize: UIFont.buttonFontSize)
   }
   
   static var labelFont: UIFont {
      return UIFont.systemFont(ofSize: UIFont.labelFontSize)
   }
   
   static var smallSystemFont: UIFont {
      return UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
   }
   
   static var systemFont: UIFont {
      return UIFont.systemFont(ofSize: UIFont.systemFontSize)
   }
}
#endif
