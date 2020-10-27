//
//  WVBarButtonItem.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 29.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import UIKit

class WVBarButtonItem: UIBarButtonItem {
   
   /// A closure to execute when this bar button item is tapped.
   var closure: (() -> Void)?
   
   /// Default initialization from given title and style.
   convenience init(title: String?, style: UIBarButtonItem.Style = .plain, onSelection: (() -> Void)?) {
      self.init(title: title, style: style)
      closure = onSelection
   }
   
   /// Default initialization from given title and style.
   init(title: String?, style: UIBarButtonItem.Style) {
      super.init()
      self.title = title
      self.style = style
      initClosureSeclector()
   }
   
   /// Initialization from storyboard.
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      initClosureSeclector()
   }
   
   /// Sets the target to itself and the selector to the `doClosureAction()` function.
   private func initClosureSeclector() {
      self.target = self
      self.action = #selector(doClosureAction)
   }
   
   /// Executes the closure.
   @objc private func doClosureAction() {
      closure?()
   }
}
