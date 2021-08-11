//
//  UIAnimatedBarButtonItem.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 29.05.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if canImport(UIKit)
import UIKit

class UIAnimatedBarButtonItem: UIBarButtonItem {
    
    
    /// Key used for the rotation animation.
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    
    // MARK: - Properties
    
    /// The image view that displays the animated image.
    var button: UIButton {
        return customView as! UIButton
    }
    
    /// Image displayed in a normal state.
    private var internalImage: UIImage?
    /// Image displayed when animating.
    private var animatedImage: UIImage?
    
    /// A Boolean value indicating whether the button item is currently rotating.
    var isRotating: Bool = false {
        didSet { isRotatingDidChange(oldValue: oldValue) }
    }
    
    
    // MARK: - Initialization
    
    convenience init(image: UIImage?, animatedImage: UIImage?, target: AnyObject?, action: Selector?) {
        self.init(customView: UIButton(type: .system))
        
        self.target = target
        self.action = action
        
        button.frame.size = CGSize(width: 32, height: 32)
        button.setImage(image, for: .normal)
        
        self.internalImage = image
        self.animatedImage = animatedImage
        
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }
    
    
    // MARK: - Functions
    
    @objc private func buttonAction(sender: UIButton) {
        _ = (target as? NSObject)?.perform(action, with: self)
    }
    
    open func isRotatingDidChange(oldValue: Bool) {
        
        guard oldValue != isRotating else { return }
        
        if isRotating {
            startAnimation()
        } else {
            stopAnimation()
        }
    }
    
    private func startAnimation() {
        
        UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromTop, animations: {
            
            self.button.setImage(self.animatedImage, for: .normal)
            
        }, completion: {_ in
            if self.isRotating {
                self.rotate(duration: 2)
            }
        })
        
        button.isUserInteractionEnabled = false
    }
    
    private func stopAnimation() {
        stopRotating()
        
        button.setImage(self.internalImage, for: .normal)
        button.isUserInteractionEnabled = true
    }
    
    private func rotate(duration: Double = 1) {
        if button.layer.animation(forKey: UIAnimatedBarButtonItem.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            button.layer.add(rotationAnimation, forKey: UIAnimatedBarButtonItem.kRotationAnimationKey)
        }
    }
    
    private func stopRotating() {
        if button.layer.animation(forKey: UIAnimatedBarButtonItem.kRotationAnimationKey) != nil {
            button.layer.removeAnimation(forKey: UIAnimatedBarButtonItem.kRotationAnimationKey)
        }
    }
}
#endif
