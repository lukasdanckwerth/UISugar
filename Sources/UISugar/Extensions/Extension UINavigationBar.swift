//
//  ExtensionUINavigationBar.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 24.03.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import UIKit

/// ExtensionUINavigationBar
///
/// - author: Lukas Danckwerth
extension UINavigationBar {
   
   /// Cleares the entire background of the navigation bar.
   func clearBackground() {
      backgroundColor = .clear
      isTranslucent = true
      setBackgroundImage(UIImage(), for: .default)
      shadowImage = UIImage()
      clipsToBounds = true
   }
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   convenience init(pushItem item: UINavigationItem) {
      self.init()
      self.pushItem(item, animated: false)
   }
}
