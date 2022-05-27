//
//  UIInputAlertController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 29.10.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

open class UIInputAlertController: UIAlertController, UITextFieldDelegate {
    
    /// Typealias for a validation block used to set the enabled status of the add button.
    public typealias Validation = (String?) -> Bool
    
    public typealias Completion = (String?) -> Void
    
    
    
    // MARK: - Properties
    
    open var enableButton: Validation? = { $0?.trimmingCharacters(in: .whitespaces).count ?? 0 > 0 }
    
    open var onDismiss: Completion?
    
    
    open var addText: String = NSLocalizedString("Add", comment: "")
    
    open var cancelText: String = NSLocalizedString("Cancel", comment: "")
    
    open var placeholderText: String = NSLocalizedString("Placeholder", comment: "")
    
    
    public lazy var addAlertAction = UIAlertAction(
        title: addText,
        style: .default,
        handler: { action in
            
            let text = self.textField.text
            self.onDismiss?(text)
            
        })
    
    public lazy var cancelAlertAction = UIAlertAction(
        title: cancelText,
        style: .cancel
    )
    
    public var textField: UITextField! {
        return textFields?.first
    }
    
    
    
    // MARK: - Initialization
    
    public convenience init(title: String?, message: String? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
    }
    
    
    
    // MARK: - Life Cycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addAlertAction.isEnabled = false
        
        addAction(addAlertAction)
        addAction(cancelAlertAction)
        
        addTextField(configurationHandler: { textField in
            
            textField.placeholder = self.placeholderText
            textField.autocapitalizationType = .words
            textField.addTarget(self, action: #selector(self.textDidChange(sender:)), for: .editingChanged)
            
        })
    }
    
    
    
    // MARK: - Functions
    
    @objc open func textDidChange(sender: UITextField) {
        
        if let enableButton = self.enableButton {
            addAlertAction.isEnabled = enableButton(textField?.text)
        } else if !addAlertAction.isEnabled {
            addAlertAction.isEnabled = true
        }
    }
}
#endif
