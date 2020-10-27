//
//  Extension UIView + Constraints.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 11.03.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import UIKit

extension UIView {
   
   /// Adds the receiver to the given `UIView` in `superview` and binds it's frame to `superview`s frame
   func bind(to superview: UIView, insets: UIEdgeInsets = .zero) {
      self.translatesAutoresizingMaskIntoConstraints = false
      superview.addSubview(self)
      if #available(iOS 11.0, *) {
         superview.addConstraints([
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
            self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
         ])
      } else {
         superview.addConstraints([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
         ])
      }
   }
   
   /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
   /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
   func bindFrameToSuperviewBounds(insets: UIEdgeInsets? = nil) {
      guard let superview = self.superview else {
         print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
         return
      }
      
      translatesAutoresizingMaskIntoConstraints = false
      
      if let insets = insets {
         superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(insets.left)-[subview]-\(insets.right)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
         superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(insets.top)-[subview]-\(insets.bottom)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
      } else {
         superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
         superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
      }
   }
   
   func center(in superview: UIView) {
      self.translatesAutoresizingMaskIntoConstraints = false
      superview.addSubview(self)
      superview.addConstraints([
         self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
         self.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
      ])
   }
   
   func centerInSuperview() {
      guard let superview = self.superview else { return }
      translatesAutoresizingMaskIntoConstraints = false
      superview.addConstraints([
         centerXAnchor.constraint(equalTo: superview.centerXAnchor),
         centerYAnchor.constraint(equalTo: superview.centerYAnchor)
      ])
   }
   
   func setWidthAnchor(constant: CGFloat) {
      self.widthAnchor.constraint(equalToConstant: constant).isActive = true
   }
   
   func setHeightAnchor(constant: CGFloat) {
      self.heightAnchor.constraint(equalToConstant: constant).isActive = true
   }
   
   func setSize(width: CGFloat, height: CGFloat) {
      self.setWidthAnchor(constant: width)
      self.setHeightAnchor(constant: height)
   }
}
