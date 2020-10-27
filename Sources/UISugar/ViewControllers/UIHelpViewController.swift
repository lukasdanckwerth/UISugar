//
//  UIHelpViewController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 11.12.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

class UIHelpViewController: UIViewController {
   
   let margin: CGFloat = UISugar.hugeSpacingAlt * 2
   
   lazy var mainStackView = UIStackView()
   
   private lazy var topView: UIView = {
      let view = UIView()
      view.setContentHuggingPriority(.defaultLow, for: .vertical)
      view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
      return view
   }()
   
   private lazy var bottomView: UIView = {
      let view = UIView()
      view.setContentHuggingPriority(.defaultLow, for: .vertical)
      view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
      return view
   }()
   
   
   override func loadView() {
      super.loadView()
      
      view.backgroundColor = .white
      
      mainStackView.axis = .vertical
      mainStackView.spacing = UISugar.spacing
      mainStackView.distribution = .fillEqually
      mainStackView.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(mainStackView)
      if #available(iOS 11.0, *) {
         view.addConstraints([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -margin),
            view.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: -margin),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: margin),
            view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: margin)
         ])
      } else {
         view.addConstraints([
            view.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -margin),
            view.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: -margin),
            view.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: margin),
            view.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: margin)
         ])
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      if #available(iOS 11.0, *) {
         navigationController?.navigationBar.prefersLargeTitles = true
      }
      navigationItem.title = NSLocalizedString("Help", comment: "")
      navigationItem.rightBarButtonItem = dismissDoneButtonItem
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      mainStackView.addArrangedSubview(bottomView)
   }
}

extension UIHelpViewController {
   
   func addPanel(imageName: String, headline: String, text: String) {
      let panel = self.panel(imageName: imageName, headline: headline, text: text)
      panel.setContentHuggingPriority(.defaultHigh, for: .vertical)
      panel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
      mainStackView.addArrangedSubview(panel)
   }
   
   
   
   
   private func panel(imageName: String, headline: String, text: String) -> UIStackView {
      
      let imageView = UIImageView(image: .named(imageName) ?? .named("ColoredUpdateViewController-Checkmark"))
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
      imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
      imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
      
      let stackInner = UIStackView(arrangedSubviews: [
         headlineLabel(text: headline),
         textLabel(text: text)
      ])
      stackInner.axis = .vertical
      stackInner.distribution = .fill
      stackInner.alignment = .top
      stackInner.spacing = UISugar.spacing
      stackInner.translatesAutoresizingMaskIntoConstraints = false
      stackInner.setContentHuggingPriority(.defaultHigh, for: .vertical)
      stackInner.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
      
      let stack = UIStackView(arrangedSubviews: [
         imageView,
         stackInner
      ])
      stack.axis = .horizontal
      stack.distribution = .fill
      stack.alignment = .center
      stack.spacing = UISugar.spacing
      stack.translatesAutoresizingMaskIntoConstraints = false
      
      return stack
   }
   
   /// Creates and returns a label for headlines
   private func headlineLabel(text: String) -> UILabel {
      return label(text: text, font: .preferredFont(forTextStyle: .headline))
   }
   
   /// Creates and returns a multiline label for texts
   private func textLabel(text: String) -> UILabel {
      let label = self.label(text: text, font: .preferredFont(forTextStyle: .body))
      label.numberOfLines = 0
      return label
   }
   
   private func label(text: String, font: UIFont) -> UILabel {
      let label = UILabel()
      label.text = text
      label.font = font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }
}
#endif
