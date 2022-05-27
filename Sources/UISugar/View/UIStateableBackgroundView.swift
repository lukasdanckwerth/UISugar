//
//  UIStateableBackgroundView.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 24.01.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

class UIStateableBackgroundView: UIView {
   
   private static let fontSizeActive: CGFloat = 17
   
   private static let fontSizeEmpty: CGFloat = 27
   
   
   lazy var activityIndicator: UIActivityIndicatorView = {
      #if swift(>=4.2)
      let indicator = UIActivityIndicatorView(style: .gray)
      #else
      let indicator = UIActivityIndicatorView(style: .gray)
      #endif
      indicator.hidesWhenStopped = true
      indicator.startAnimating()
      return indicator
   }()
   
   lazy var label: UILabel = {
      let label = UILabel()
      label.text = NSLocalizedString("Load", comment: "").uppercased()
      label.textAlignment = .center
      label.textColor = .gray
      label.font = UIFont.systemFont(ofSize: 14)
      return label
   }()
   
   lazy var stackViewBackground: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [activityIndicator, label])
      stackView.alignment = .center
      stackView.distribution = .fillProportionally
      stackView.axis = .vertical
      stackView.contentMode = .center
      stackView.spacing = 8
      activityIndicator.startAnimating()
      return stackView
   }()
   
   
   // MARK: - Override `UIView`
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      #if swift(>=4.2)
      stackViewBackground.frame.size = stackViewBackground.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
      #else
      stackViewBackground.frame.size = stackViewBackground.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
      #endif
      
      // stackViewBackground.center = self.center <-- Does not proper work!
      
      stackViewBackground.center.x = self.frame.width / 2
      stackViewBackground.center.y = self.frame.height / 2
   }
   
   
   // MARK: - Initialization
   
   init() {
      super.init(frame: CGRect.zero)
      self.addSubview(stackViewBackground)
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.addSubview(stackViewBackground)
   }
   
   
   // MARK: - Public functions
   
   /// Starts the activity indicator and optionaly sets the given text to the label.
   func start(text: String? = nil) {
      activityIndicator.startAnimating()
      label.font = UIFont.systemFont(ofSize: UIStateableBackgroundView.fontSizeActive)
      label.text = text
      layoutSubviews()
   }
   
   /// Stops and hides the activity indicator and removes any text in the label.
   func stop() {
      activityIndicator.stopAnimating()
      label.text = nil
   }
   
   func setEmptyText(_ emptyText: String?) {
      activityIndicator.stopAnimating()
      label.font = UIFont.systemFont(ofSize: UIStateableBackgroundView.fontSizeEmpty)
      label.text = emptyText
      layoutSubviews()
   }
}
#endif
