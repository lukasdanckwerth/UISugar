//
//  Extension UIAlertAction.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 16.02.20.
//  Copyright © 2020 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Default Actions
// ===-----------------------------------------------------------------------------------------------------------===

public extension UIAlertAction {
   
   static func cancel(title: String = NSLocalizedString("Cancel", comment: ""), handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction {
      return UIAlertAction(title: title, style: .cancel, handler: handler)
   }
   
   static func destructive(title: String, titleTextColor: UIColor? = .wvRed, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction {
      let action = UIAlertAction(title: title, style: .destructive, handler: handler)
      action.setValue(titleTextColor, forKey: "titleTextColor")
      return action
   }
   
   static func `default`(title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction {
      return UIAlertAction(title: title, style: .default, handler: handler)
   }
   
   static func ok(title: String = NSLocalizedString("OK", comment: ""), handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction {
      return UIAlertAction(title: title, style: .cancel, handler: handler)
   }
}


// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Custom Initialization
// ===-----------------------------------------------------------------------------------------------------------===

public extension UIAlertAction {
   
   convenience init(title: String, image: UIImage? = nil, checked: Bool? = nil, enabled: Bool = true, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
      self.init(title: title, style: .default, handler: handler)
      
      if let image = image {
         self.setValue(image, forKey: "image")
      }
      
      if let checked = checked {
         self.setValue(checked, forKey: "checked")
      }
      
      self.isEnabled = enabled
   }
}


// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Covenience
// ===-----------------------------------------------------------------------------------------------------------===

public extension UIAlertAction {
   
   var isChecked: Bool? {
      get {
         // guard self.responds(to: Selector(Constants.checkedKey)) else { return nil }
         return self.value(forKey: Constants.checkedKey) as? Bool
      }
      set {
         // guard self.responds(to: Selector(Constants.checkedKey)) else { return }
         self.setValue(newValue ?? false, forKey: Constants.checkedKey)
      }
   }
   
   var image: UIImage? {
      get {
         guard self.responds(to: Selector(Constants.imageKey)) else { return nil }
         return self.value(forKey: Constants.imageKey) as? UIImage
      }
      set {
         guard self.responds(to: Selector(Constants.imageKey)) else { return }
         self.setValue(newValue, forKey: Constants.imageKey)
      }
   }
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Constants
   // ===-----------------------------------------------------------------------------------------------------------===
   
   private struct Constants {
      static let checkedKey = "checked"
      static let imageKey = "image"
   }
}
#endif
