//
//  Dictionary + WinValue.swift
//  UltraExpertGoTests
//
//  Created by Lukas Danckwerth on 27.03.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func formatContents() -> String? {
        var componentString = ComponentsString()
        for entry in self {
            componentString += "\(entry.key) : \(entry.value)"
        }
        return componentString.string
    }
    
}
