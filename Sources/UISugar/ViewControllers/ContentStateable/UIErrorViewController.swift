//
//  UIErrorViewController.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 14.03.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

/// A view controller that can be used as a child view controller (background controller) when loading of something
/// leads to an error.
public class UIErrorViewController: UIViewController {
   
   public typealias ReloadHandler = ((UIErrorViewController, UIEvent) -> Void)
   
   
   
   // MARK: - Properties
   
   /// Label do display the reason of the error.
   open lazy var label = setupLabel()
   
   private func setupLabel() -> UILabel {
      let label = UILabel()
      label.textColor = .gray
      label.textAlignment = .center
      label.numberOfLines = 0
      label.font = UIFont.preferredFont(forTextStyle: .headline)
      return label
   }
   
   
   /// Button that triggeres the reload handler.
   open lazy var button = setupButton()
   
   private func setupButton() -> UIFilledSystemButton {
      let button = UIFilledSystemButton(
         title: NSLocalizedString("Retry", comment: "")
      )
      button.addTarget(
         self,
         action: #selector(buttonAction(sender:forEvent:)),
         for: .touchUpInside
      )
      button.addConstraints([
         button.heightAnchor.constraint(equalToConstant: 44),
         button.widthAnchor.constraint(equalToConstant: 300)
      ])
      button.sizeToFit()
      return button
   }
   
   
   open lazy var stackView = setupStackView()
   
   private func setupStackView() -> UIStackView {
      let stack = UIStackView(arrangedSubviews: [
         label,
         button
      ])
      stack.axis = .vertical
      stack.alignment = .center
      stack.spacing = 30
      return stack
   }
   
   /// A closure to execute when the reload button is tapped.
   var reloadHandler: ReloadHandler?
   
   
   
   
   // MARK: - Initialzation
   
   /// Default initialization from given parameters.  Automatically hides button for empty `buttonTitle`.
   init(labelText: String? = nil, buttonTitle: String? = nil, reloadHandler: ReloadHandler? = nil) {
      super.init(nibName: nil, bundle: nil)
      
      label.text = labelText
      
      if let buttonTitle = buttonTitle {
         button.setTitle(buttonTitle, for: .normal)
      } else {
         button.isHidden = true
      }
      
      self.reloadHandler = reloadHandler
   }
   
   /// Default initialization from given coder.
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   /// Default initialization from given `Error`.  NOTE: not implemented!
   init(error aError: Error) {
      fatalError("not implemented")
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Override `UIViewController`
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Sets a `UINotTappableView` as view.
   public override func loadView() {
      view = UINotTappableView()
      stackView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(stackView)
      view.addConstraints([
         stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
         stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
      ])
      stackView.alpha = 0
   }
   
   
   /// Overriden in order to make a smooth animation do display the label and button.
   public override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      UIView.animate(withDuration: UISugar.fadeDuration, animations: {
         self.stackView.alpha = 1
      })
   }
   
   
   /// Overriden in order to copy the frame of the `parent` view controller to this' view controllers frame.
   #if swift(>=4.2)
   public override func didMove(toParent parent: UIViewController?) {
      super.didMove(toParent: parent)
      if let parentFrame = parent?.view.frame {
         view.frame = parentFrame
      }
   }
   #else
   public override func didMove(toParent parent: UIViewController?) {
      super.didMove(toParent: parent)
      if let parentFrame = parent?.view.frame {
         view.frame = parentFrame
      }
      
      if let tableView = (parent as? UITableViewController)?.tableView {
         view.frame.origin.y += tableView.contentOffset.y
      }
   }
   #endif
   
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Actions
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Triggered when user taps on the 'Retry' button.  This functions executes the `reloadHandler` block.
   @objc open func buttonAction(sender: UIButton, forEvent event: UIEvent) {
      reloadHandler?(self, event)
   }
}


class UIErrorImageViewController: UIErrorViewController {
   
   lazy var imageView = setupImageView()
   
   private func setupImageView() -> UIImageView {
      let imageView = UIImageView()
      imageView.contentMode = .center
      imageView.tintColor = .gray
      imageView.addConstraints([
         imageView.heightAnchor.constraint(equalToConstant: 160),
         imageView.widthAnchor.constraint(equalToConstant: 160)
      ])
      return imageView
   }
   
   
   
   /// Default initialization from given parameters.  Automatically hides button for empty `buttonTitle`.
   init(labelText: String? = nil, buttonTitle: String? = nil, image: UIImage? = nil, reloadHandler: ReloadHandler? = nil) {
      super.init(
         labelText: labelText,
         buttonTitle: buttonTitle,
         reloadHandler: reloadHandler
      )
      imageView.image = image
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   
   override func loadView() {
      super.loadView()
      stackView.insertArrangedSubview(imageView, at: 0)
   }
}
#endif
