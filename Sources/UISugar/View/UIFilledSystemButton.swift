//
//  UIFilledSystemButton.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 09.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

open class UIFilledSystemButton: UIButton {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Properties
   // ===-----------------------------------------------------------------------------------------------------------===
   
   public lazy var heightConstraint = self.heightAnchor.constraint(equalToConstant: 48)
   
   public var filledBackgroundColor: UIColor? {
      didSet { self.titleLabel?.layer.backgroundColor = filledBackgroundColor?.cgColor }
   }
   
   public var cornerRadius: CGFloat {
      get { return titleLabel?.layer.cornerRadius ?? 0 }
      set { titleLabel?.layer.cornerRadius = newValue }
   }
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   convenience init(title: String) {
      self.init(type: .system)

      setTitle(title, for: .normal)
      
      titleLabel?.bindFrameToSuperviewBounds()
      titleLabel?.textAlignment = .center
      titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
      
      heightConstraint.isActive = true
      heightConstraint.priority = .defaultHigh
      
      applyDefaults()
   }
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Functions
   // ===-----------------------------------------------------------------------------------------------------------===
   
   func applyDefaults() {
      self.setTitleColor(.white, for: .normal)
      self.cornerRadius = UISugar.defaultCornerRadius
   }
}
#endif
