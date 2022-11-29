//
//  UIAnimatedLabel.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 10.10.17.
//
#if canImport(UIKit)
import UIKit

class UIAnimatedLabel: UILabel {


   func setText(_ text: String, animated: Bool) {

      if animated {

         if let superview = self.superview {
            self.isOpaque = false

            let labelHeight = self.frame.height
            let tmpLabelOld = UILabel(frame: self.frame)
            let tmpLabelNew = UILabel(frame: self.frame)

            tmpLabelOld.textColor = self.textColor
            tmpLabelNew.textColor = self.textColor

            tmpLabelOld.text = self.text
            tmpLabelNew.text = text

            tmpLabelNew.frame.size.height = 0

            self.text = tmpLabelNew.text
            superview.addSubview(tmpLabelOld)
            superview.addSubview(tmpLabelNew)

            UIView.animate(withDuration: UISugar.fadeDuration, animations: {

               tmpLabelOld.frame.origin.y += labelHeight
               tmpLabelOld.alpha = CGFloat(0)
               tmpLabelNew.frame.size.height = labelHeight

            }, completion: {_ in

               tmpLabelOld.removeFromSuperview()
               tmpLabelNew.removeFromSuperview()
               self.isOpaque = true

            })
         }
      } else {
         self.text = text
      }
   }
}
#endif
