//
//  WVNavigationViewController.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 04.12.17.
//
#if os(iOS)
import UIKit

/**
 - author: Lukas Danckwerth */
class WVNavigationViewController: UINavigationController {

   /// A optional view drawn below the navigation bar
   var additionalView: UIView? {
      didSet {
         // Remove any oexisting old additional view
         removeOldAdditionalView(aView: oldValue)
         // Add the view to this view controllers view if it's not already added
         addAdditionalView(aView: additionalView)
      }
   }

   /// Removes the given view from the view of this view controller
   private func removeOldAdditionalView(aView: UIView?) {
      if aView != nil, viewIfLoaded != nil, view.subviews.contains(aView!) {
         aView!.removeFromSuperview()
      }
   }

   /// Adds the given view to the view herachy
   private func addAdditionalView(aView: UIView?) {
      if aView != nil, viewIfLoaded != nil, !view.subviews.contains(aView!) {
         view!.addSubview(aView!)
      }
   }

   /// Height of the additional view.
   var additionalViewHeight: CGFloat?


   // MARK: - Override UINavigationController

   override func viewDidLoad() {
      super.viewDidLoad()

      // Add additonol view to view herachy
      addAdditionalView(aView: additionalView)
   }

   override func viewDidLayoutSubviews() {

      // Check if we got an additional view here and lay out if so
      if let additionalView = self.additionalView, let view = self.view {

         additionalView.frame.size.width = view.frame.width
         additionalView.frame.origin.x = 0
         additionalView.frame.origin.y = self.toolbar?.frame.height ?? 0

         if let additionalViewHeight = additionalViewHeight {
            additionalView.frame.size.height  = additionalViewHeight
         }
      }

      // Delegate call to super
      super.viewDidLayoutSubviews()
   }
}
#endif
