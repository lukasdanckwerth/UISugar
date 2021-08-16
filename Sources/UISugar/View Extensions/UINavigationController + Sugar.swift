//
//  ExtensionUINavigationController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 22.02.18.
//  Copyright © 2018 WinValue. All rights reserved.
//
#if canImport(UIKit)
import UIKit

extension UINavigationController {
    
    
    func popViewController(animated: Bool, completion: @escaping () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
#endif
