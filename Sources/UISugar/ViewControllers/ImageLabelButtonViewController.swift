//
//  ImageLabelButtonViewController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 23.05.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

class ImageLabelButtonViewController: UIViewController {
   
   
   // MARK: - Properties
   
   /// An image view in the top of the stack view.
   lazy var imageView: UIImageView = {
      let iv = UIImageView(frame: .zero)
      iv.contentMode = .scaleAspectFit
      return iv
   }()
   
   /// A label in the middle of the stack view.
   lazy var label: UILabel = {
      let l = UILabel()
      l.translatesAutoresizingMaskIntoConstraints = false
      l.textColor = .gray
      l.textAlignment = .center
      l.numberOfLines = 0
      l.font = UIFont.systemFont(ofSize: 23)
      return l
   }()
   
   /// A view with the button in the center.
   lazy var viewWithButton: UIView = {
      let v = UIView()
      
      v.translatesAutoresizingMaskIntoConstraints = false
      v.heightAnchor.constraint(equalToConstant: 44).isActive = true
      
      v.addSubview(button)
      
      button.translatesAutoresizingMaskIntoConstraints = false
      button.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
      button.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
      
      return v
   }()
   
   /// A button in the bottom of the stack view.
   lazy var button: UIRoundedEdgeButton = {
      let b = UIRoundedEdgeButton(type: .system)
      b.addTarget(self, action: #selector(retryButtonAction(sender:)), for: .touchUpInside)
      return b
   }()
   
   /// The stack view combining the views in this controller.
   lazy var stackView = UIStackView(arrangedSubviews: [imageView, label, viewWithButton])
   
   /// A closure to execute when the button is tapped.
   var buttonAction: () -> Void = {}
   
   
   // MARK: - Initialzation
   
   convenience init(image: UIImage? = nil, labelText: String? = nil, buttonTitle: String? = nil) {
      self.init(nibName: nil, bundle: nil)
      
      imageView.image = image
      imageView.alpha = 0
      imageView.isHidden = image == nil
      
      label.text = labelText
      label.alpha = 0
      label.isHidden = labelText == nil
      
      button.setTitle(buttonTitle, for: .normal)
      button.isHidden = buttonTitle == nil
      button.alpha = 0
      
   }
   
   /// Sets a `UINotTappableView` as view.
   override func loadView() {
      view = UINotTappableView()
   }
   
   /// Configures the stack view containing the other views.
   override func viewDidLoad() {
      super.viewDidLoad()
      
      stackView.axis = .vertical
      stackView.spacing = 8
      
      view.addSubview(stackView)
      
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
      
      stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
      stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
   }
   
   /// Overriden in order to make a smooth animation do display the label and button.
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      UIView.animate(withDuration: UISugar.fadeDuration, animations: {
         self.imageView.alpha = 0.4
         self.label.alpha = 1
         self.button.alpha = 1
      })
   }
   
   /// Overriden in order to copy the frame of the `parent` view controller to this' view controllers frame.
   #if swift(>=4.2)
   override func didMove(toParent parent: UIViewController?) {
      super.didMove(toParent: parent)
      
      if let parentFrame = parent?.view.frame {
         view.frame = parentFrame
      }
   }
   #else
   override func didMove(toParent parent: UIViewController?) {
      super.didMove(toParent: parent)
      
      if let parentFrame = parent?.view.frame {
         view.frame = parentFrame
      }
   }
   #endif
   
   
   
   // MARK: - Actions
   
   /// Triggered when user taps on the 'Retry' button.  This functions executes the `reloadHandler` block.
   @objc private func retryButtonAction(sender: UIButton) {
      buttonAction()
   }
}
#endif
