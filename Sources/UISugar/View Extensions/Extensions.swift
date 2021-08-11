//
//  Extensions.swift
//  French-Rap-Lyrics-Corpus
//
//  Created by Lukas Danckwerth on 04.12.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

#if os(macOS)

import Cocoa
import MapKit

extension NSImage {
   
   var pngData: Data? {
      guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
      return bitmapImage.representation(using: .png, properties: [:])
   }
   
   @discardableResult func pngWrite(to url: URL, options: Data.WritingOptions = .atomic) -> Bool {
      do {
         try pngData?.write(to: url, options: options)
         return true
      } catch {
         print(error)
         return false
      }
   }
}

extension NSView {
   var snapshot: NSImage {
      guard let bitmapRep = bitmapImageRepForCachingDisplay(in: bounds) else { return NSImage() }
      cacheDisplay(in: bounds, to: bitmapRep)
      let image = NSImage()
      image.addRepresentation(bitmapRep)
      bitmapRep.size = bounds.size.doubleScale()
      return image
   }
}

extension CGSize {
   func doubleScale() -> CGSize {
      return CGSize(width: width * 2, height: height * 2)
   }
}

// MARK: - Extension LatLng

//extension LatLng {
//   
//   var location2D: CLLocationCoordinate2D {
//      return CLLocationCoordinate2D(latitude: lng, longitude: lat)
//   }
//}

#endif
