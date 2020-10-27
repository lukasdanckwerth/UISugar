//
//  UIStatePresenting.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 21.01.20.
//  Copyright © 2020 WinValue. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

public protocol UIStatePresenting {
   
   // var state: UIStatePresentingState? { get set }
   
   var stateViewController: UIStateViewController { get }
   
   
   
   func transition(to newState: UIState)
   
   func viewController(for state: UIState) -> UIViewController?
   
}

public extension UIStatePresenting {
   
    @available(iOS 13.0, *)
    func loadingViewController() -> UIViewController {
      UILoadingViewController()
   }
   
   func noInternetViewController() -> UIViewController {
      UIErrorViewController(labelText: "Error", buttonTitle: NSLocalizedString("Retry", comment: ""))
   }
   
   func emptyViewController(message: String) -> UIViewController {
      UIEmptyDetailViewController(message: message)
   }
   
   func failedViewController(errorMessage: String) -> UIViewController {
      UIErrorViewController(labelText: errorMessage, buttonTitle: NSLocalizedString("Retry", comment: ""))
   }
   
   func transition(to newState: UIState) {
      let vc = viewController(for: newState)
      stateViewController.set(contentViewController: vc)
      // state = newState
   }
   
   func viewController(for state: UIState) -> UIViewController? {
      switch state {
      case .fine:
         return nil
      case .stating(let imageName, let message, let buttonTitle, let reloadHandler):
         return UIErrorImageViewController(
            labelText: message,
            buttonTitle: buttonTitle,
            image: .named(imageName ?? ""),
            reloadHandler: reloadHandler
         )
      case .loading:
        if #available(iOS 13.0, *) {
            return loadingViewController()
        } else {
            return nil
        }
      case .noInternet:
         return noInternetViewController()
      case .empty(let message):
         return emptyViewController(message: message)
      case .failed(let errorMessage):
         return failedViewController(errorMessage: errorMessage)
      case .render(let viewController):
         return viewController
      }
   }
}
#endif
