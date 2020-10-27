//
//  UIGradingControl+Setup.swift
//  UltraExpert-Go
//
//  Created by Lukas on 30.01.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import Foundation
import UIKit

extension UIGradingControl {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Setup
   // ===-----------------------------------------------------------------------------------------------------------===
   
   final func setup() {
      
      // configure round selection indicator
      
      selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
      selectionIndicator.filledBackgroundColor = UIColor.clear
      selectionIndicator.layer.cornerRadius = selectionIndicatorSize.width / 2
      selectionIndicator.layer.masksToBounds = true
      
      addSubview(selectionIndicator)
      addConstraints([
         selectionIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
         heightAnchorConstraint,
         widthAnchorConstraint
      ])
      
      
      // configure stack view
      
      stackView.axis = .horizontal
      stackView.alignment = .center
      stackView.spacing = 8
      stackView.distribution = .fillEqually
      
      stackView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(stackView)
      if #available(iOS 11.0, *) {
         addConstraints([
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
         ])
      } else {
         addConstraints([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor)
         ])
      }
   }
}
