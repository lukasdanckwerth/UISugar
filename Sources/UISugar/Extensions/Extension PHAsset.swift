//
//  Extension PHAsset.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 27.02.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

#if canImport(Photos)
import Photos.PHAsset
import UIKit.UIImage

extension PHAsset {
   
   public func requestImage(completion: @escaping (UIImage?) -> Void) {
      
      let options = PHImageRequestOptions()
      options.isNetworkAccessAllowed = true
      options.deliveryMode = .highQualityFormat
      
      let targetSize = CGSize(width: self.pixelWidth,
                              height: self.pixelHeight)
      
      PHImageManager.default().requestImage(
         for: self,
         targetSize: targetSize,
         contentMode: .default,
         options: options
      ) { (image, _) in
         completion(image)
      }
   }
}
#endif
