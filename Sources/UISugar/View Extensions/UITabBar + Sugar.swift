//
//  Extension + UITabBar.swift
//  Rima iOS
//
//  Created by Lukas Danckwerth on 25.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

public extension UITabBar {
    
    var selectedTabIndex: Int? {
        guard let selectedItem = selectedItem else { return nil }
        return items?.firstIndex(of: selectedItem)
    }
}
#endif
