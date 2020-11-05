//
//  ExtensionUIView.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 29.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Traverses the responder chain and resturns the first reponder which is a `UIViewController`.
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    class func fromNib<T: UIView>(nibName: String) -> T {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! T
    }
    
    @discardableResult
    func fromNib<T : UIView>(nibName: String) -> T? {
        guard let contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.bindFrameToSuperviewBounds()
        return contentView
    }
    
    func doJellyAnimation(firstDuration: Double = 0.2, secondDuration: Double = 0.1, factor: CGFloat = 1.2) {
        
        UIView.animate(withDuration: firstDuration, animations: {
            self.transform = CGAffineTransform(scaleX: factor, y: factor)
        }, completion: {_ in
            UIView.animate(withDuration: secondDuration, animations: {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
    }
    
    
    /// Returns an `UIImage` representation of the view.
    var imageRepresentation: UIImage? {
        
        UIGraphicsBeginImageContext(layer.frame.size)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        } else {
            return nil
        }
    }
}
