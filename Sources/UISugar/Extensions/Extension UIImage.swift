//
//  ExtensionUIImage.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 02.11.17.
//

import UIKit

public extension UIImage {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Class Functions
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Creates a new instance initiated through the `init(named: String)` constructor
    class func named(_ name: String) -> UIImage? {
        return UIImage(named: name)
    }
    
    /// Creates a new `UIImage` instance initiated through the `init(systemName: String)` constructor.  Falls back on
    /// `init(named: String)` for versions before iOS 13.0
    class func systemNamed(_ systemName: String) -> UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: systemName) ?? UIImage(named: systemName)
        } else {
            return UIImage(named: systemName)
        }
    }
    
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Initialization
    // ===-----------------------------------------------------------------------------------------------------------===
    
    // NOTE: Extension from https://stackoverflow.com/questions/30696307/how-to-convert-a-uiview-to-an-image
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
    /// Creates a new instance from the image at the given `URL`.
    convenience init?(url: URL) {
        self.init(contentsOfFile: url.path)
    }
    
    /// Creates a new instance from the given base 64 `String`.
    convenience init?(base64: String) {
        guard let data = Data(base64Encoded: base64) else { return nil }
        self.init(data: data)
    }
    
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Properties
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Returnes the base 64 encoded PNG string representation of this image.
    var base64PNG: String? {
        return self.dataPNG?.base64EncodedString()
    }
    
    /// Returnes the base 64 encoded JPEG string representation of this image.
    var base64JPEG: String? {
        return self.dataJPEG?.base64EncodedString() // 1.0 for least compression (best quality)
    }
    
    /// Returns the images PNG `Data`.
    var dataPNG: Data? {
        #if swift(>=4.2)
        return self.pngData()
        #else
        return self.pngData()
        #endif
    }
    
    /// Returns the images JPEG `Data`.
    var dataJPEG: Data? {
        #if swift(>=4.2)
        return self.jpegData(compressionQuality: 1.0)
        #else
        return self.jpegData(compressionQuality: 1.0)
        #endif
    }
    
    
    
    // MARK: - Functions
    
    /// Returns a new copy of this image scaled to the given size.
    ///
    /// - parameter size: The size of the new image.
    func scaledTo(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: size.width, height: size.height)))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Returns a new copy cropping the given rectangle of this image.
    ///
    /// - parameter to: The rectangle to crop from the image.
    func cropping(to rect: CGRect) -> UIImage {
        return UIImage(cgImage: cgImage!.cropping(to: rect)!)
    }
    
    /// Returns a new copy of this image downscaled so the higher side of the image will be the given max size.
    func scaleIfBigger(maxSize: CGFloat) -> UIImage {
        
        if max(size.width, size.height) > maxSize {
            
            if size.width > size.height {
                
                // landscape
                return scaledTo(size: CGSize(width: maxSize, height: size.height * (maxSize / size.width)))
            } else {
                
                // portrait
                return scaledTo(size: CGSize(width: size.width * (maxSize / size.height), height: maxSize))
            }
        }
        
        return self
    }
}
