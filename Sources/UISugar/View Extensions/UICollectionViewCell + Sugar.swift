//
//  ExtensionUICollectionViewCell.swift
//  UltraExpert-Go
//
//  Created by Lukas on 18.09.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

#if canImport(UIKit)
import UIKit.UICollectionViewCell

public extension UICollectionViewCell {
    
    // MARK: - Functions
    
    /// Reloads the cell in the collection view.
    ///
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
#endif
