//
//  UISwitch + Sugar.swift
//  
//
//  Created by Lukas on 09.08.21.
//
#if canImport(UIKit)
import UIKit

public extension UISwitch {
    func toggle() { setOn(!isOn, animated: true) }
}
#endif
