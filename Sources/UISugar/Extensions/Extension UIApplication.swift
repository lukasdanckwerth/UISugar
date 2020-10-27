//
//  ExtensionUIApplication.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 26.04.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import UIKit

extension UIApplication {
   
   /// Returns the status bar view
   var statusBarView: UIView? {
      guard responds(to: Selector(("statusBar"))) else { return nil }
      return value(forKey: "statusBar") as? UIView
   }
}
