//
//  ExtensionUIStackView.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 29.01.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

extension UIStackView {
    
    func removeArrangedSubviews() {
        for subview in arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
#endif
