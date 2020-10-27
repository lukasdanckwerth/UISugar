//
//  ExtensionUISplitViewController.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 19.12.17.
//

import UIKit

extension UISplitViewController {
   
   var masterViewController: UIViewController? {
      return self.viewControllers.first
   }
   
   var detailsViewController: UIViewController? {
      return self.viewControllers.count > 1 ? self.viewControllers[1] : nil
   }
   
   func setViewWeighes(fractionPrimary: CGFloat, fractionSecondary: CGFloat) {
      
      if fractionPrimary + fractionSecondary > 1.0 {
         print(self, "The sum of the fraction value for primary view (\(fractionPrimary) and the fraction value for secondary view"
            + " (\(fractionSecondary) is higher 1.0. This may lead to wrong display result.")
      }
      
      preferredDisplayMode = .allVisible
      preferredPrimaryColumnWidthFraction = fractionPrimary
      
      let screenWidth = UIScreen.main.bounds.width
      minimumPrimaryColumnWidth = screenWidth * fractionPrimary;
      maximumPrimaryColumnWidth = screenWidth * fractionSecondary;
   }
   
//   open func showDetailViewController(_ vc: UIViewController, sender: Any?, animated: Bool, completion: ((Bool) -> ())? = nil) {
//      
//      
//      if animated, let currentDetailVC = self.detailsViewController {
//         
//         let backgroundBefore = self.view.backgroundColor
//         let navigationBar: UINavigationBar?
//         let view: UIView?
//         
//         if let navigationController = currentDetailVC as? UINavigationController {
//         
//            navigationBar = navigationController.navigationBar
//            self.view.backgroundColor = navigationController.view.backgroundColor ?? UIColor.white
//            view = navigationController.view
//            
//         } else {
//            
//            navigationBar = currentDetailVC.navigationController?.navigationBar
//            self.view.backgroundColor = currentDetailVC.view.backgroundColor ?? UIColor.white
//            view = currentDetailVC.view
//         
//         }
//
//         
//         UIView.animate(withDuration: 0.06, animations: {
//            
//            view?.alpha = 0
//            navigationBar?.alpha = 0
//            navigationBar?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
//            
//         }, completion: {completed in
//            
//            vc.navigationController?.navigationBar.alpha = 0
//            vc.view.alpha = 0
//            
//            self.showDetailViewController(vc, sender: self)
//            
//            UIView.animate(withDuration: 0.06, animations: {
//               
//               vc.navigationController?.navigationBar.alpha = 1
//               vc.view.alpha = 1
//               
//            }, completion: {completed in
//               UIView.animate(withDuration: 0.3, animations: { self.view.backgroundColor = backgroundBefore })
//               completion?(completed)
//            })
//         })
//         
//      } else {
//         
//         // If animation flag is false or the split view controller doesn't contain a details controller just show the given
//         // view controller `vc`.
//         self.showDetailViewController(vc, sender: sender)
//      }
//   }
}

