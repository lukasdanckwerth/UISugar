//
//  UIFilterLabel.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 05.10.17.
//
#if os(iOS)
import UIKit

/** A round edge label mostly used for displaying filters.
 - author: Lukas Danckwerth */
class UIFilterLabel: UILabel {
   
   
   
   static let imageSize: CGFloat = 18
   
   static let cornerRadius: CGFloat = 14
   
   static let filterImage = UIImage(named: "ToolbarIconFilterFilled")!
      .scaledTo(size: CGSize(width: imageSize, height: imageSize))
   
   static let clearImage = UIImage(named: "ButtonImageClear")!
      .scaledTo(size: CGSize(width: imageSize, height: imageSize))
   
   
   
   // MARK: - Properties
   
   /// A (lazy) image view displayed in the left of the label.
   lazy var imageView: UIImageView! = setupImageView()
   
   func setupImageView() -> UIImageView {
      let size = CGSize(width: UIFilterLabel.imageSize, height: UIFilterLabel.imageSize)
      let imageView = UIImageView(frame: CGRect(origin: .zero, size: size))
      imageView.contentMode = .center
      imageView.clipsToBounds = true
      addSubview(imageView)
      return imageView
   }
   
   /// Reference to the 'Delete' button in the right of the label.
   private lazy var deleteButton: UIButton! = setupButton()
   
   func setupButton() -> UIButton {
      let button = UIButton(type: .system)
      button.frame = CGRect(x: 0, y: 0, width: UIFilterLabel.imageSize, height: UIFilterLabel.imageSize)
      button.addTarget(self, action: #selector(self.buttonClearAction), for: .touchUpInside)
      button.contentMode = .center
      isButtonLoaded = true
      addSubview(button)
      return button
   }
   
   /// Boolean value that indicates whether the 'Delete' button is visible.
   var isButtonLoaded = false
   
   /// Reference to an optional reprecented object.
   var selectableCharacter: Any?
   
   /// Reference to the UIEdgeInsets used for this UIFilterLabel.
   var insets: UIEdgeInsets = .zero
   
   /// Reference to the closure which is fired when the delet button is taped.
   var deleteAction: (() -> (Void))?
   
   override public var intrinsicContentSize: CGSize {
      var intrinsicSuperViewContentSize = super.intrinsicContentSize
      
      intrinsicSuperViewContentSize.height += insets.top + insets.bottom
      intrinsicSuperViewContentSize.width += insets.left + insets.right
      intrinsicSuperViewContentSize.width += 30
      intrinsicSuperViewContentSize.width += 30
      
      return intrinsicSuperViewContentSize
   }
   
   
   
   // MARK: - Initialize
   
   /// Initialize from given parameters.
   public init(frame: CGRect = .zero, showButton: Bool = false) {
      super.init(frame: frame)
      initialize(showButton: showButton)
   }
   
   /// Default initialization from storyboard.
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      initialize()
   }
   
   /// Sets a border, the rounded corners and colors
   private func initialize(showButton: Bool = false) {
      
      layer.cornerRadius = UIFilterLabel.cornerRadius
      layer.borderWidth = 1.0   // Can be finetuned
      
      insets = .new(horizontal: 8, vertical: 4)
      
      if showButton {
         let clearButtonImage = UIFilterLabel.clearImage
         deleteButton.setImage(clearButtonImage, for: .normal)
      }
      
      font = font.withSize(CGFloat(15))
      
      imageView.image = UIFilterLabel.filterImage
   }
   
   override func sizeToFit() {
      super.sizeToFit()
      
      frame.size.width += insets.left + insets.right
      frame.size.width += 60
      
      deleteButton!.frame.origin.x = frame.size.width - insets.left - UIFilterLabel.imageSize
      deleteButton!.frame.origin.y = insets.top + ((frame.size.height - 18) / 2) + 1
      
      imageView!.frame.origin.x = insets.left
      imageView!.frame.origin.y = insets.top + ((frame.size.height - 18) / 2) + 1
      
   }
   
   override public func drawText(in rect: CGRect) {
      #if swift(>=4.2)
      var rect = rect.inset(by: insets)
      #else
      var rect = rect.inset(by: insets)
      #endif
      
      rect.origin.x += 16
      super.drawText(in: rect)
   }
   
   
   
   // MARK: - Private functions
   
   @objc private func buttonClearAction() {
      deleteAction?()
   }
}
#endif
