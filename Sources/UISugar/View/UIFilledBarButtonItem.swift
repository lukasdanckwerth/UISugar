//
//  UIFilledBarButtonItem.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 27.09.17.
//
#if os(iOS)
import UIKit

open class UIFilledBarButtonItem: UIBarButtonItem {
   
   
   // MARK: - Properties
   
   private var _filledButton = UIRoundedEdgeButton(type: .system)
   
   /// A Boolean value indicating whether the item has a filled background.
   var isFilled: Bool = false {
      didSet { isFilledDidChange() }
   }
   
   open override var image: UIImage? {
      didSet { _filledButton.setImage(image, for: .normal); _filledButton.sizeToFit() }
   }
   
   open override var tintColor: UIColor? {
      didSet { _filledButton.tintColor = tintColor }
   }
   
   open override var title: String? {
      didSet { _filledButton.setTitle(title, for: .normal); _filledButton.sizeToFit()  }
   }
   
   open var contentEdgeInsets: UIEdgeInsets {
      get { return _filledButton.contentEdgeInsets }
      set { _filledButton.contentEdgeInsets = newValue }
   }
   
   open var isDrawsBorder: Bool {
      get { return _filledButton.isDrawsBorder }
      set { _filledButton.isDrawsBorder = newValue }
   }
   
   
   
   // MARK: - Initialization
   
   override init() {
      super.init()
      _initialize()
   }
   
   init(target: AnyObject?, action: Selector?) {
      super.init()
      _initialize()
      self.target = target
      self.action = action
   }
   
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      _initialize()
   }
   
   private func _initialize() {
      customView = _filledButton
      _filledButton.setImage(image, for: .normal)
      _filledButton.addTarget(self, action: #selector(doBarButtonItemAction), for: .touchUpInside)
      _filledButton.contentEdgeInsets = .new(horizontal: 4, vertical: 2)
      _filledButton.backgroundColor = .clear
      _filledButton.isDrawsBorder = false
      isFilledDidChange()
   }
   
   private func isFilledDidChange() {
      if isFilled {
         _filledButton.selectedColor = tintColor
         _filledButton.backgroundColor = tintColor
         _filledButton.tintColor = .white
      } else {
         _filledButton.selectedColor = tintColor
         _filledButton.backgroundColor = .clear
         _filledButton.tintColor = tintColor
      }
      
      _filledButton.isFilled = isFilled
      _filledButton.borderColor = .clear
   }
   
   @objc private func doBarButtonItemAction() {
      _ = target?.perform(action!, with: self)
   }
}
#endif
