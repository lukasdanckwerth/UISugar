//
//  WVButton.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 27.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import UIKit

/// A simple `UIButton` subclass which additionally can have a represented object of type `Type`.
class WVButton<Type>: UIButton {
   
   /// The represented object by this button.
   var representedObject: Type?
   
   
   static func new(object: Type, title: String? = nil, frame: CGRect = CGRect.zero) -> WVButton<Type> {
      let b = WVButton<Type>(frame: frame)
      b.representedObject = object
      b.setTitle(title, for: .normal)
      return b
   }
}
