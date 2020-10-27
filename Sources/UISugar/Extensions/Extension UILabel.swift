//
//  ExtensionUILabel.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 24.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// Creates a `UILabel` with the given text.
    static func withText(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
    
    
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>", htmlText)
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                      NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
}
