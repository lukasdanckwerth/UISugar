//
//  UIContentStateViewController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 06.09.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
// https://www.swiftbysundell.com/articles/custom-container-view-controllers-in-swift/
#if os(iOS)
import UIKit

public extension UIViewController {
   
   /// Reference to the parental `UIStateViewController` if the receiver is shown in one.  Walks the view
   /// controller chain by calling the `parent` property.
   var contentStateViewController: UIStateViewController? {
      return parent as? UIStateViewController ?? parent?.contentStateViewController
   }
}

public class UIStateViewController: UIViewController {
   public var contentViewController: UIViewController?
   
   func set(contentViewController viewController: UIViewController?) {
      contentViewController?.remove()
      guard let viewController = viewController else { return }
      add(viewController)
      contentViewController = viewController
   }
}

extension UIStateViewController: UIStatePresenting {
   public var stateViewController: UIStateViewController {
      return self
   }
}
#endif
