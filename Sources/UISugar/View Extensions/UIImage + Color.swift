//
//  UIImage + Color.swift
//  UISugar
//
//  Created by Lukas on 15.12.20.
//
#if canImport(UIKit)
import UIKit

public extension UIImage {
    static func fromColor(color: UIColor, rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
#endif
