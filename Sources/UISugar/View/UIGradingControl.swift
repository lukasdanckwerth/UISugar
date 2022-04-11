//
//  UIGradingControl.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 12.09.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

// ===--------------------------------------------------------------------------------------------------------------===
//
// MARK: - `UIGradingControl`
// ===--------------------------------------------------------------------------------------------------------------===

class UIGradingControl: UIView {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Properties
   // ===-----------------------------------------------------------------------------------------------------------===
   
   
   // MARK: - Stack View
   
   let stackView = UIStackView()
   
   
   // MARK: - Selection Indicator
   
   let selectionIndicator = UIFilledLabel()
   
   lazy var heightAnchorConstraint = selectionIndicator.heightAnchor
      .constraint(equalToConstant: selectionIndicatorSize.height)
   
   lazy var widthAnchorConstraint = selectionIndicator.widthAnchor
      .constraint(equalToConstant: selectionIndicatorSize.width)
   
   var selectionIndicatorCenterXConstraint: NSLayoutConstraint?
   
   var selectionIndicatorCenterYConstraint: NSLayoutConstraint?
   
   var selectionIndicatorSize: CGSize = CGSize(width: 33, height: 33) {
      didSet { selectionIndicatorSizeDidChange() }
   }
   
   var selectedIndex: Int? {
      didSet { selectedIndexDidChange() }
   }
   
   var selectedButton: UIButton? {
      guard let selectedIndex = self.selectedIndex else { return nil }
      guard selectedIndex >= 0, selectedIndex < stackView.arrangedSubviews.count else { return nil }
      return stackView.arrangedSubviews[selectedIndex] as? UIButton
   }
   
   
   // MARK: - Delegate
   
   /// The object that acts as a delegate.
   weak var delegate: UIGradingControlDelegate? {
      didSet { delegateDidChange() }
   }
   
   /// The title color of the buttons
   var titleColor = UIColor.gray
   
   /// The selected title color of the buttons
   var selectedTitleColor = UIColor.white
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Override `UIView`
   // ===-----------------------------------------------------------------------------------------------------------===

   final private func delegateDidChange() {
      stackView.removeArrangedSubviews()
      
      let numberOfItems = delegate?.numberOfItemsIn(gradingControl: self) ?? 0
      for index in 0..<numberOfItems {
         
         let button = UIButton(type: .system)
         button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
         button.setTitleColor(tintColor, for: .normal)
         button.tintColor = tintColor
         
         if let image = delegate?.gradingControl?(self, imageForItemAt: index) {
            button.setImage(image, for: .normal)
         } else if let title = delegate?.gradingControl(self, titleForItemAt: index) {
            button.setTitle(title, for: .normal)
         }
         
         delegate?.gradingControl?(self, willAddButton: button)
         stackView.addArrangedSubview(button)
      }
   }
   
   func selectionIndicatorSizeDidChange() {
      heightAnchorConstraint.constant = selectionIndicatorSize.height
      widthAnchorConstraint.constant = selectionIndicatorSize.width
      selectionIndicator.layer.cornerRadius = selectionIndicatorSize.width / 2
   }
   
   func selectedIndexDidChange() {
      
      if let index = self.selectedIndex, let selectedButton = self.selectedButton {
         
         if let color = delegate?.gradingControl?(self, selectionIndicatorColorForItemAt: index) {
            selectionIndicator.backgroundColor = color
         } else {
            selectionIndicator.backgroundColor = self.tintColor
         }
         
         selectionIndicator.isHidden = false
         
         if let constraintX = self.selectionIndicatorCenterXConstraint {
            removeConstraint(constraintX)
         }
         
         if let constraintY = self.selectionIndicatorCenterYConstraint {
            removeConstraint(constraintY)
         }
         
         self.selectionIndicatorCenterXConstraint = selectedButton.centerXAnchor
            .constraint(equalTo: selectionIndicator.centerXAnchor)
         self.selectionIndicatorCenterYConstraint = selectedButton.centerYAnchor
            .constraint(equalTo: selectionIndicator.centerYAnchor)
         
         addConstraints([
            selectionIndicatorCenterXConstraint!,
            selectionIndicatorCenterYConstraint!
         ])
         
         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.layoutSubviews()
            selectedButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
         }, completion: { _ in
            selectedButton.setTitleColor(self.selectedTitleColor, for: .normal)
            selectedButton.tintColor = self.selectedTitleColor
         })
         
         self.delegate?.gradingControl?(self, didSelectItemAt: index)
      } else {
         selectionIndicator.isHidden = true
      }
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Actions
   // ===-----------------------------------------------------------------------------------------------------------===
   
   @objc final private func buttonAction(sender: UIButton) {
      // clear color for old selection
      if let button = self.selectedButton {
         button.setTitleColor(titleColor, for: .normal)
         button.tintColor = titleColor
         button.transform = CGAffineTransform(scaleX: 1, y: 1)
      }
      self.selectedIndex = stackView.arrangedSubviews.firstIndex(of: sender)
   }
}



// ===--------------------------------------------------------------------------------------------------------------===
//
// MARK: - `UIGradingControlDelegate`
// ===--------------------------------------------------------------------------------------------------------------===

@objc protocol UIGradingControlDelegate: class {
   
   func numberOfItemsIn(gradingControl: UIGradingControl) -> Int
   
   func gradingControl(_ gradingControl: UIGradingControl, titleForItemAt index: Int) -> String?
   
   @objc optional func gradingControl(_ gradingControl: UIGradingControl, imageForItemAt index: Int) -> UIImage?
   
   @objc optional func gradingControl(_ gradingControl: UIGradingControl, selectionIndicatorColorForItemAt index: Int) -> UIColor?
   
   @objc optional func gradingControl(_ gradingControl: UIGradingControl, didSelectItemAt index: Int)
   
   @objc optional func gradingControl(_ gradingControl: UIGradingControl, willAddButton button: UIButton)
   
}
#endif
