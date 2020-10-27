//
//  UIActivityFilledButton.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 22.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

public class UIActivityFilledButton: UIFilledSystemButton, UIActivityPresenting {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Properties
   // ===-----------------------------------------------------------------------------------------------------------===
   
   private var titleColor: UIColor?
   
   // MARK: - Satisfy `UIActivityPresenting`
   
   lazy public var activityIndicator = UIActivityIndicatorView(centeredIn: self)
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Functions
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Calls the `startAnimating()` message of the `activityIndicator` and sets the title of the underlying button to
   /// `nil`
   public func startAnimating() {
      self.titleColor = titleColor(for: .normal)
      self.activityIndicator.alpha = 0.0
      self.activityIndicator.startAnimating()
      UIView.animate(withDuration: 0.5, animations: {
         self.setTitleColor(.clear, for: .normal)
         self.activityIndicator.alpha = 1.0
      })
   }
   
   /// Calls the `stopAnimating()` message of the `activityIndicator` and sets the title of the underlying button to
   /// to the value of the `title` property of self
   public func stopAnimating() {
      UIView.animate(withDuration: 0.5, animations: {
         self.activityIndicator.alpha = 0.0
      }) { _ in
         self.setTitleColor(self.titleColor, for: .normal)
         self.activityIndicator.stopAnimating()
      }
   }
}
#endif
