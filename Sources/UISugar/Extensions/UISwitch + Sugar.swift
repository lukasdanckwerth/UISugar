//
//  UISwitch + Sugar.swift
//  
//
//  Created by Lukas on 09.08.21.
//

import UIKit

public extension UISwitch {
    func toggle() { setOn(!isOn, animated: true) }
}
