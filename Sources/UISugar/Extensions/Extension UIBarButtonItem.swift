//
//  ExtensionUIBarButtonItem.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 04.06.18.
//  Copyright © 2018 WinValue. All rights reserved.
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
