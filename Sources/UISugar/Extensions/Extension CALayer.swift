//
//  ExtensionCALayer.swift
//  UltraExpert-Go
//
//  Created by Lukas on 20.09.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import UIKit

extension CALayer {
   
   
   /// Draws shadow under this layer specified by the given arguments.
   ///
   /// - parameters:
   ///   - offset: the offset of the shadow
   ///   - radius: the radius of the shadow
   ///   - opacity: the opacity of the shadow
   func drawShadow(offset: CGSize = UISugar.shadowOffset, radius: CGFloat = UISugar.shadowRadius, opacity: Float = UISugar.shadowOpacity) {
      
      shadowOffset = offset
      shadowRadius = radius
      shadowOpacity = opacity
      
   }
}
