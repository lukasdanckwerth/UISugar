//
//  ExtensionUIBarButtonItem.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 04.06.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

extension UIBarButtonItem {
    
    class var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    class func fixedSpace(_ width: CGFloat? = nil) -> UIBarButtonItem {
        let feixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        feixedSpaceItem.width = width ?? feixedSpaceItem.width
        return feixedSpaceItem
    }
}
#endif
