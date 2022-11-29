//
//  UIGradientBeginingLabel.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 05.12.17.
//
#if os(iOS)
import UIKit

/** A label with a gradient 'fade-out' view in the left before the label text starts.
 - author: Lukas Danckwerth */
class UIGradientBeginingLabel: UILabel {


   // MARK: - Properties

   /// The width of the gradient. Defaults to 60.
   var gradientWidth: CGFloat = 30

   /// The layer which draws the gradient in the left.
   var gradientLayer: CAGradientLayer!

   /// The background color of the layer.
   var layerBackgroundColor: UIColor? {
      didSet {
         if layerBackgroundColor != nil {
            gradientLayer.colors = [
               UIColor.white.withAlphaComponent(0.0).cgColor,
               layerBackgroundColor!.cgColor
            ]
         } else {
            gradientLayer.colors = nil
         }
      }
   }

   /// Override layer class in order to use a `CAGradientLayer`.
   open override class var layerClass: AnyClass {
      return CAGradientLayer.classForCoder()
   }


   // MARK: - Initialization

   /// Default initialization from given frame.
   override init(frame: CGRect) {
      super.init(frame: frame)
      style()
   }

   /// Default initialization from storyboard.
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      style()
   }

   /// Does some additional styling of the label, especially draws the gradient.
   private func style() {
    gradientLayer = self.layer as? CAGradientLayer
      gradientLayer.startPoint = CGPoint(x: 0, y: 0);
      gradientLayer.colors = [UIColor.white.withAlphaComponent(0.0).cgColor,
                              UIColor.white.cgColor]
      self.backgroundColor = UIColor.white.withAlphaComponent(0.0)

      layoutSubviews()
   }

   /// Updates the layer so it is wided about `gradientWidth` in the left.
   override func layoutSubviews() {
      super.layoutSubviews()

      self.layer.frame.size.width = self.frame.width + gradientWidth
      self.layer.frame.origin.x = self.frame.origin.x - gradientWidth

      // Calculate the end point of the gradient.
      gradientLayer.endPoint = CGPoint(x: 1 - (self.frame.width / (self.frame.width + gradientWidth)), y: 0.0);
   }
}
#endif
