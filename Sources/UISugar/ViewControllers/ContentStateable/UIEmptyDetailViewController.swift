//
//  UIEmptyDetailViewController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 30.09.17.
//
#if os(iOS)
import UIKit

class UIEmptyDetailViewController: UIViewController {
   
   
   // MARK: - Properties
   
   /// Reference to the underlaying UILabel which is the view of this controller as well.
   public var label = UILabel(frame: CGRect.zero)
   /// Reference to the displayed message.
   private var message: String? {
      didSet { label.text = message }
   }
   
   // Initialization with given String.
   init(message: String?) {
      self.message = message
      self.label.text = message
      super.init(nibName: nil, bundle: nil)
   }
   
   /// Initialization from storyboard.
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   
   // MARK: - Override UIViewController
   
   override func loadView() {
      
      // Configure the label
      label.textColor = UIColor.lightGray
      label.font = label.font.withSize(CGFloat(35.0))
      label.textAlignment = .center
      label.numberOfLines = 0
      
      view = label
   }
}
#endif
