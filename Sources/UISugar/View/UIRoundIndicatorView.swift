//
//  UIRoundIndicatorView.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 07.12.17.
//

import UIKit

@IBDesignable
class UIRoundIndicatorView: UIView {

   override var backgroundColor: UIColor? {
      didSet {
         super.backgroundColor = backgroundColor
         layer.cornerRadius = layer.frame.width / 2
      }
   }

   @IBInspectable
   var isOn: Bool = false {
      didSet { isHidden = !isOn }
   }

   // Only executed in Interface Builder
   override func prepareForInterfaceBuilder() {
      layer.cornerRadius = layer.frame.width / 2
   }
}
