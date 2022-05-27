//
//  ExtensionUINavigationItem.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 26.03.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

extension UINavigationItem {
    
    convenience init(navigationBar: UINavigationBar) {
        self.init()
        navigationBar.pushItem(self, animated: false)
    }
}
#endif
