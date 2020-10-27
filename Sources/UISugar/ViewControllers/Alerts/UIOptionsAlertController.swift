//
//  UIOptionsAlertController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 10.11.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

#if os(iOS)
import Foundation
import UIKit.UIAlertController

class UIOptionsAlertController<OptionType: Equatable>: UIAlertController {
   
   var options: [OptionType]?
   
   var selectedValue: OptionType?
   
   var allowEmptySelction: Bool = true
   
   var titleForEmptySelection = "None"
   
   
   var titleFor: (OptionType?) -> String = { "\(String(describing: $0))" }
   
   var imageFor: ((OptionType?) -> UIImage?)?
   
   var onSelection: ((OptionType?) -> Void)?
   
   
   
   
   convenience init(title: String? = nil) {
      self.init(title: title, message: nil, preferredStyle: .actionSheet)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      build()
   }
   
   func build() {
      
      guard let options = self.options else { return }
      
      for option in options {
         
         let action = UIAlertAction(
            title: titleFor(option),
            image: imageFor?(option),
            handler: { _ in
               self.onSelection?(option)
         })
         
         action.isChecked = selectedValue == option
         
         addAction(action)
      }
      
      if allowEmptySelction {
         addAction(
            UIAlertAction(
               title: titleForEmptySelection,
               style: .default,
               handler: { _ in
                  self.onSelection?(nil)
            })
         )
      }
   }
}
#endif
