//
//  UIInitialsCircleView.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 07.03.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if os(iOS)
import UIKit

class UIInitialsCircleView: UIView {
    
    
    // MARK: - Properties
    
    /// The label to display the initials.
    private var label: UILabel!
    
    /// The font used by the label to display the initials.
    var font: UIFont! {
        get {return label.font}
        set {label.font = newValue}
    }
    
    /// The full name.
    var fullName: String? {
        didSet { fullNameDidChange() }
    }
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    private func _init() {
        backgroundColor = tintColor
        layer.cornerRadius = frame.width / 2;
        layer.masksToBounds = true;
        
        // Initialize and configure label
        label = UILabel(frame: frame)
        label.textAlignment = .center
        label.textColor = .white
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
    // MARK: - Functions
    
    private func fullNameDidChange() {
        
        guard let fullName = fullName?.replacingOccurrences(of: "\u{00a0}", with: " ") else {
            label.text = nil
            return
        }
        
        let initials = fullName.split(separator: " ").compactMap({
            guard $0.count > 0 else { return nil }
            return String($0[$0.startIndex])
        }).joined(separator: " ")
        
        label.text = initials
    }
}
#endif
