//
//  ExtensionUIAlertController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 30.01.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

public extension UIAlertController {
    
    /// Presents an alert controller with a single 'OK' action in the given view controller with the given title and message.
    ///
    /// - parameter vc: The view controller to show the alert in.
    /// - parameter title: The title of the alert.
    /// - parameter message: The message of the alert.
    /// - parameter handler: Closure to execute when user taps on 'OK'.
    ///
    /// - returns: The created and presented `UIAlertController`.
    @discardableResult
    static func presentAlert(_ vc: UIViewController, title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.ok(handler: handler))
        vc.present(alert, animated: true)
        return alert
    }
    
    /// Presents an confirm alert controller with two actions, one for canceling and one to do the confirmed action.
    ///
    /// - parameter vc: The view controller to show the alert in.
    /// - parameter title: The title of the alert.
    /// - parameter message: The message of the alert.
    /// - parameter buttonTitle: The title of the button to confirm the action.
    /// - parameter handler: Closure to execute when user taps the confirm button.
    ///
    /// - returns: The created and presented `UIAlertController`.
    @discardableResult
    static func presentConfirmAlert(_ vc: UIViewController, title: String? = nil, message: String? = nil, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.destructive(title: buttonTitle, handler: handler))
        alert.addAction(.cancel())
        vc.present(alert, animated: true)
        return alert
    }
}
#endif
