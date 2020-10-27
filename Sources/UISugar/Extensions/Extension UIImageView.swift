//
//  ExtensionUIImageView.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 04.03.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import UIKit

extension UIImageView {
   
   @discardableResult
   func fill(with url: URL, completion: ((UIImage?) -> Void)? = nil) -> URLSessionDataTask {
      
      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
         
         if let data = data {
            DispatchQueue.main.async {
               self.image = UIImage(data: data)
               completion?(self.image)
            }
         } else if let error = error {
            print(error)
         }
      })
      task.resume()
      return task
   }
   
   func rotate(duration: CFTimeInterval = 2) {
      let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
      rotation.toValue = NSNumber(value: Double.pi * 2)
      rotation.duration = duration
      rotation.isCumulative = true
      rotation.repeatCount = Float.greatestFiniteMagnitude
      self.layer.add(rotation, forKey: "rotationAnimation")
   }
   
   /// Sets the `isHidden` property of the receiver to `true` if the receiver doesn't contains an image.  Sets it to
   /// `false` for an existend image.
   func hideIfImageIsNil() {
      self.isHidden = image == nil
   }
}
