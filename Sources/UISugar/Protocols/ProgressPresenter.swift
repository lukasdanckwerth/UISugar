//
//  ProgressPresenter.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 05.07.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// A protocol that can be implemented by views that can show progress / text and can be dismissed after the progress is
/// finished.  Such as a `MBProgressHUD`, `UILabel` or the `LoadingViewController`.
public protocol ProgressPresenter: class {
    
    /// The text which is presented by this `ProgressPresenter`.
    var text: String? {get set}
    
    /// Dismisses this `ProgressPresenter`.
    func dismiss()
    
    /// Dismisses this `ProgressPresenter` after the given delay.
    func dismiss(after delay: TimeInterval)
}


// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Default Implementation
// ===-----------------------------------------------------------------------------------------------------------===

extension ProgressPresenter {
    
    public func dismiss(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.dismiss()
        }
    }
    
    /// Updates the `text` property of the receiver in the main thread.  Useful when updating text from a background
    /// thread.
    func update(text: String) {
        DispatchQueue.main.async {
            self.text = text
        }
    }
}



// MARK: - Extend UILabel about the ProgressPresenter protocol

#if canImport(UILabel)
extension UILabel: ProgressPresenter {
    
    public func dismiss() {
        /* nothin to do here */
    }
}
#endif

// MARK: - Extend MBProgressHUD about the ProgressPresenter protocol

#if canImport(MBProgressHUD)
import MBProgressHUD

extension MBProgressHUD: ProgressPresenter {
    
    public var text: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    public func dismiss() {
        hide(animated: true)
    }
    
    public func dismiss(after delay: TimeInterval) {
        hide(animated: true, afterDelay: delay)
    }
}
#endif


// MARK: - Extend UILoadingViewController about the ProgressPresenter protocol

//extension UILoadingViewController: ProgressPresenter {
//    
//    var text: String? {
//        get { return stackView.text }
//        set { stackView.text = newValue }
//    }
//    
//    func dismiss() {
//        remove()
//    }
//    
//    @objc private func _dismiss() {
//        dismiss()
//    }
//}
