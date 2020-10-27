//
//  UIVibrancyLabel.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 09.09.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

@available(iOS 10.0, *)
class UIVibrancyLabel: UIVisualEffectView {
   
   
   
   // MARK: - Properties
   
   let label = UILabel(frame: .zero)
   
   let vibrancyEffectView: UIVisualEffectView
   
   
   var blurEffect: UIBlurEffect
   
   var vibrancyEffect: UIVibrancyEffect
   
   
   
   // MARK: - Initialization
   
   override init(effect: UIVisualEffect?) {
      blurEffect = (effect as? UIBlurEffect) ?? UIBlurEffect(style: .prominent)
      vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
      vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
      
      super.init(effect: blurEffect)
      self.setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
      // self.setup()
   }
   
   convenience init() {
      self.init(effect: UIBlurEffect(style: .prominent))
   }
   
   
   
   // MARK: - Private Setup
   
   private func setup() {
      
      contentView.addSubview(vibrancyEffectView)
      vibrancyEffectView.bindFrameToSuperviewBounds()
      
      vibrancyEffectView.contentView.addSubview(label)
      label.bindFrameToSuperviewBounds(insets: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
      
      
   }
}
#endif
