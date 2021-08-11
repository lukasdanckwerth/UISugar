//
//  UIView + Constraints.swift
//  
//
//  Created by Lukas on 05.01.21.
//
#if canImport(UIKit)
import UIKit

public extension UIView {
    
    func addConstraints(bindingTo otherView: UIView) {
        otherView.addConstraints([
            topAnchor.constraint(equalTo: otherView.topAnchor),
            leadingAnchor.constraint(equalTo: otherView.leadingAnchor),
            bottomAnchor.constraint(equalTo: otherView.bottomAnchor),
            trailingAnchor.constraint(equalTo: otherView.trailingAnchor)
        ])
    }
    
    @available(iOS 11.0, *)
    func addConstraints(bindingSafeAreaTo otherView: UIView) {
        otherView.addConstraints([
            safeAreaLayoutGuide.topAnchor.constraint(equalTo: otherView.safeAreaLayoutGuide.topAnchor),
            safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: otherView.safeAreaLayoutGuide.leadingAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: otherView.safeAreaLayoutGuide.bottomAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: otherView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
#endif
