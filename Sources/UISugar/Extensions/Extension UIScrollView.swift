//
//  ExtensionUIScrollView.swift
//  UltraExpert-Go
//
//  Created by Lukas on 11.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

#if os(iOS)
import Foundation
import UIKit.UIScrollView

extension UIScrollView {
   
   func scrollToBottom(animated: Bool = true) {
      let yPosition = self.contentSize.height - self.bounds.size.height
      let bottomOffset = CGPoint(x: 0, y: yPosition)
      self.setContentOffset(bottomOffset, animated: animated)
   } 
}
#endif
