//
//  ExtensionUICollectionViewCell.swift
//  UltraExpert-Go
//
//  Created by Lukas on 18.09.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import UIKit.UICollectionViewCell

public extension UICollectionViewCell {
   
   
   
   // MARK: - Properties
   
   /// Returns the parental collection view.
   var collectionView: UICollectionView? {
      return superview as? UICollectionView
   }
   
   
   
   // MARK: - Functions
   
   /// Reloads the cell in the collection view.
   func reload() {
    
      guard let collectionView = self.collectionView else {
         return NSLog("can't receive collection view")
      }
      
      guard let indexPath = collectionView.indexPath(for: self) else {
         return NSLog("can't receive index path")
      }
      
      collectionView.reloadItems(at: [indexPath])
   }
}
