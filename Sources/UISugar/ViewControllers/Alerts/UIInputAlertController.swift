//
//  UIInputAlertController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 29.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

class UIInputAlertController: UIAlertController, UITextFieldDelegate {
   
   typealias UIInputAlertControllerValidation = (String?) -> Bool
   
   typealias UIInputAlertControllerCompletion = (String?) -> Void
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Properties
   // ===-----------------------------------------------------------------------------------------------------------===
   
   var enableButton: UIInputAlertControllerValidation? = { $0?.trimmingCharacters(in: .whitespaces).count ?? 0 > 0 }
   
   var onDismiss: UIInputAlertControllerCompletion?
   
   
   lazy var addAlertAction = UIAlertAction(
      title: NSLocalizedString("Add", comment: ""),
      style: .default,
      handler: { action in
         
         let text = self.textField.text
         self.onDismiss?(text)
         
   })
   
   lazy var cancelAlertAction = UIAlertAction(
      title: NSLocalizedString("Cancel", comment: ""),
      style: .cancel
   )
   
   var textField: UITextField! {
      return textFields?.first
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   convenience init(title: String?, message: String? = nil) {
      self.init(title: title, message: message, preferredStyle: .alert)
      
      build()
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Functions
   // ===-----------------------------------------------------------------------------------------------------------===
   
   open func build() {
      
      addAlertAction.isEnabled = false
      
      addAction(addAlertAction)
      addAction(cancelAlertAction)
      
      addTextField(configurationHandler: { textField in
         
         textField.placeholder = NSLocalizedString("Involvement", comment: "")
         textField.autocapitalizationType = .words
         textField.addTarget(self, action: #selector(self.textDidChange(sender:)), for: .editingChanged)
         
      })
   }
   
   @objc open func textDidChange(sender: UITextField) {
      
      if let enableButton = self.enableButton {
         addAlertAction.isEnabled = enableButton(textField?.text)
      } else if !addAlertAction.isEnabled {
         addAlertAction.isEnabled = true
      }
   }
}
#endif
