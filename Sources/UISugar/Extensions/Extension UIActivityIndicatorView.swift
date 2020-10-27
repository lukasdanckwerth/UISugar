//
//  ExtensionUIActivityIndicatorView.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 05.06.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

extension UIActivityIndicatorView {
   
   /// Creates and returnes a new `UIActivityIndicatorView` centered via constraints in the center of the given view. The `UIstyle`
   /// is set to `.gray` as default.
   ///
   /// - parameter view:              The view to center the activity indicator view in.
   /// - parameter hidesWhenStopped:  A Boolean value indicating whether the activity indicator view hides then animation stops.
   /// - parameter startAnimation:    A Boolean value indicating whether to start the animation of the activity indicator view.
   convenience init(centeredIn view: UIView, hidesWhenStopped: Bool = true, startAnimation: Bool = true) {
      #if swift(>=4.2)
      self.init(style: .gray)
      #else
      self.init(style: .gray)
      #endif
      
      view.addSubview(self)
      self.translatesAutoresizingMaskIntoConstraints = false
      self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
   }
   
   /// Creates and returnes a new `UIActivityIndicatorView` centered via constraints in the center of the given view. The `UIstyle`
   /// is set to `.gray` as default.
   ///
   /// - parameter view:              The view to center the activity indicator view in.
   /// - parameter hidesWhenStopped:  A Boolean value indicating whether the activity indicator view hides then animation stops.
   /// - parameter startAnimation:    A Boolean value indicating whether to start the animation of the activity indicator view.
   class func centered(in view: UIView, hidesWhenStopped: Bool = true, startAnimation: Bool = true) -> UIActivityIndicatorView {
      
      #if swift(>=4.2)
      let v = UIActivityIndicatorView(style: .gray)
      #else
      let v = UIActivityIndicatorView(style: .gray)
      #endif
      
      
      view.addSubview(v)
      v.translatesAutoresizingMaskIntoConstraints = false
      v.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      v.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
      
      v.hidesWhenStopped = hidesWhenStopped
      if startAnimation { v.startAnimating() }
      
      return v
   }
}
#endif
