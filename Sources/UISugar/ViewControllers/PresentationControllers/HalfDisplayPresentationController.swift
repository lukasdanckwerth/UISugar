//
//  HalfDisplayPresentationController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 21.06.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

// see: https://stackoverflow.com/questions/42106980/how-to-present-a-viewcontroller-on-half-screen
class HalfDisplayPresentationController: UIPresentationController {
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Properties
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Dimming background view.
   var backgroundView: UIView?
   
   /// Gesture recognizer to dismiss the view controller.
   var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
   
   /// A Boolean valued indicating whether to dim the background.
   var dimsBackground: Bool
   
   /// The height of the presented view controller.
   var height: CGFloat?
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, height: CGFloat? = nil, dimsBackground: Bool = true) {
      
      if dimsBackground {
         
         backgroundView = UIView(frame: presentedViewController.view.frame)
         backgroundView?.backgroundColor = .black
         backgroundView?.alpha = 0
      }
      
      self.dimsBackground = dimsBackground
      self.height = height
      
      super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
      
      if dimsBackground {
         tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
         backgroundView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         backgroundView?.isUserInteractionEnabled = true
         backgroundView?.addGestureRecognizer(tapGestureRecognizer)
      }
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Override UIPresentationController
   // ===-----------------------------------------------------------------------------------------------------------===
   
   override var frameOfPresentedViewInContainerView: CGRect {
      
      let height = self.height ?? self.containerView!.frame.height / 3
      
      let origin = CGPoint(x: 0, y: self.containerView!.frame.height - height)
      let size = CGSize(width: self.containerView!.frame.width,
                        height: height)
      
      return CGRect(origin: origin, size: size)
   }
   
   override func dismissalTransitionWillBegin() {
      
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
         self.backgroundView?.alpha = 0
      }, completion: { (UIViewControllerTransitionCoordinatorContext) in
         self.backgroundView?.removeFromSuperview()
      })
   }
   
   override func presentationTransitionWillBegin() {
      
      guard let backgroundView = self.backgroundView else {
         return
      }
      
      backgroundView.alpha = 0
      containerView?.addSubview(backgroundView)
      containerView?.isUserInteractionEnabled = true
      
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
         backgroundView.alpha = 0.4
      }, completion: nil)
   }
   
   override func containerViewWillLayoutSubviews() {
      super.containerViewWillLayoutSubviews()
      presentedView!.layer.masksToBounds = true
      presentedView!.layer.cornerRadius = UISugar.defaultCornerRadius
      containerView?.layer.drawShadow()
   }
   
   override func containerViewDidLayoutSubviews() {
      super.containerViewDidLayoutSubviews()
      self.presentedView?.frame = frameOfPresentedViewInContainerView
      backgroundView?.frame = containerView!.bounds
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Private Functions
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Dismissed the presented view controller.
   @objc func dismiss() {
      self.presentedViewController.dismiss(animated: true, completion: nil)
   }
}
#endif
