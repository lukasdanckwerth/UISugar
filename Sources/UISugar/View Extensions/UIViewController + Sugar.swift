//
//  ExtensionUIViewController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 25.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if canImport(UIKit)
import UIKit

#if canImport(MBProgressHUD)
import MBProgressHUD
#endif

public extension UIViewController {
    
    /// A bar button item to dismiss this view controller.
    public var wv_dismissButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissBarButtonAction))
    }
    
    /// A bar button item to dismiss this view controller.
    public var dismissDoneButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissBarButtonAction))
    }
    
    /// Returns a bar button to dismiss this view controller with an image instead of text.
    public var dismissImageButtonItem: UIBarButtonItem {
        return UIBarButtonItem(image: .named("ToolbarIconCancel"), style: .plain, target: self, action: #selector(dismissBarButtonAction))
    }
    
    /// Selector for dismissing this view controller.
    @objc
    open func dismissBarButtonAction(sender: UIBarButtonItem?) {
        self.dismiss(animated: true)
    }
    
    /// Returns a bar button item to present the search controller. NOTE: This item only will call the the `presentSearchController(sender:)` of
    /// this view controller. The presentation of the `SearchController` is the responsibility of the developer.
    public var searchButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(presentSearchController(sender:)))
    }
    
    /// Tells this view controller to present a search controller.
    @objc
    public func presentSearchController(sender: UIBarButtonItem?) {
        /* Nothing to do here. Subclasses should override. */
    }
    
    
    /// Presents the given view controller as the root view controller of a navigation view controller.
    @discardableResult
    public func presentInNavigationViewController(_ vc: UIViewController,
                                                  animated: Bool = true,
                                                  completion: (() -> Void)? = nil,
                                                  modalPresentationStyle: UIModalPresentationStyle = .currentContext) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = modalPresentationStyle
        self.present(navigationVC, animated: animated, completion: completion)
        return navigationVC
    }
    
    /// Presents an alert controller with a single 'OK' action with the given title and message.
    ///
    /// - parameter title: The title of the alert.
    /// - parameter message: The message of the alert.
    /// - parameter handler: Closure to execute when user taps on 'OK'.
    ///
    /// - returns: The created and presented `UIAlertController`.
    @discardableResult func presentAlert(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertController {
        return UIAlertController.presentAlert(self, title: title, message: message, handler: handler)
    }
    
    /// Presents an confirm alert controller with two actions, one for canceling and one to do the confirmed action.
    ///
    /// - parameter title: The title of the alert.
    /// - parameter message: The message of the alert.
    /// - parameter buttonTitle: The title of the button to confirm the action.
    /// - parameter handler: Closure to execute when user taps the confirm button.
    ///
    /// - returns: The created and presented `UIAlertController`.
    @discardableResult func presentConfirmAlert(title: String? = nil, message: String? = nil, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertController {
        return UIAlertController.presentConfirmAlert(self, title: title, message: message, buttonTitle: buttonTitle, handler: handler)
    }
    
    #if canImport(MBProgressHUD)
    /// Presents and returns a `MBProgressHUD` with an activity indicator and optional with a message.
    ///
    /// - parameter message: The message to display in the HUD. Default is `nil`.
    /// - parameter lockView: Boolean value indicating wheather the view of this view controller will be locked
    ///                       as long as the HUD is shown. Locked means `isUserInteractionEnabled` is set to `false`. Default is `false`.
    func presentProgressHUD(message: String? = nil, lockView: Bool = false) -> MBProgressHUD {
        
        if let view = self.view {
            
            let progressHud = MBProgressHUD.showAdded(to: view, animated: true)
            progressHud.label.text = message
            progressHud.animationType = .zoom
            
            if lockView {
                view.isUserInteractionEnabled = false
                progressHud.completionBlock = {
                    view.isUserInteractionEnabled = true
                }
            }
            return progressHud
        }
        
        /// Should never happen due to `self.view` should have a valid value.
        return MBProgressHUD()
    }
    #endif
    
    
    /// Creates a new instance from a storyboard. NOTE: Preconditions that the name of the storyboard and the identifier
    /// of the requested view controller are the same as the type name.
    class func fromStoryboard() -> Self {
        return _fromStoryboard()
    }
    
    /// Private internal helper function for `fromStoryboard` class function.
    private class func _fromStoryboard<T>() -> T {
        
        // receive 'simple' class name.
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: name) as! T
        return controller
    }
    
    @discardableResult func add<Type>(_ child: Type) -> Type where Type: UIViewController {
        child.viewIfLoaded?.frame = view.frame
        
        #if swift(>=4.2)
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        #else
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        #endif
        
        layout(child: child)
        
        return child
    }
    
    func remove() {
        guard parent != nil else { return }
        
        #if swift(>=4.2)
        willMove(toParent: nil)
        removeFromParent()
        #else
        willMove(toParent: nil)
        removeFromParent()
        #endif
        
        view.removeFromSuperview()
    }
}

@objc extension UIViewController {
    func layoutChildViewControllers() {
        #if swift(>=4.2)
        let controllers = self.children
        #else
        let controllers = self.children
        #endif
        versionIndependantlayoutChildViewControllers(controllers)
    }
    
    fileprivate func versionIndependantlayoutChildViewControllers(_ controllers: [UIViewController]) {
        for viewController in controllers {
            layout(child: viewController)
        }
    }
    
    fileprivate func layout(child: UIViewController) {
        guard let view = viewIfLoaded else { return }
        child.view.frame.size = view.frame.size
        child.view.center = view.center
    }
}

extension UITableViewController {
    override func layout(child: UIViewController) {
        child.viewIfLoaded?.frame = view.frame
        child.viewIfLoaded?.center = view.center
        child.viewIfLoaded?.frame.origin.y += tableView.contentOffset.y
    }
}

extension UICollectionViewController {
    override func layout(child: UIViewController) {
        guard let collectionView = self.collectionView else { return }
        child.viewIfLoaded?.frame = collectionView.frame
        child.viewIfLoaded?.center = collectionView.center
        child.viewIfLoaded?.frame.origin.y += collectionView.contentOffset.y
    }
}
#endif
