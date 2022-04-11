//
//  UISugar.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 09.09.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

public struct UISugar {
   
   
   
   // MARK: - Framework Constants
   
   public static let defaultCornerRadius: CGFloat = 16
   
   public static let smallCornerRadius: CGFloat = 5
   
   public static let fadeDuration: TimeInterval = 0.3
   
   
   
   // MARK: - Shadow Constants
   
   public static let shadowOffset: CGSize = {
      if #available(iOS 13, *) {
         return CGSize(width: 0, height: 1)
      } else {
         return CGSize(width: 0, height: 10)
      }
   }()
   
   public static let shadowRadius: CGFloat = {
      if #available(iOS 13, *) {
         return 3
      } else {
         return 15
      }
   }()
   
   public static let shadowOpacity: Float = 0.3
   
   
   
   // MARK: - Margin Constants
   
   public static let spacing: CGFloat = 8
   
   public static let hugeSpacing: CGFloat = spacing * 2  // 16
   
   public static let hugeSpacingAlt: CGFloat = 20
   
   
   
}
#endif
