//
//  UICollectionReusableView + Sugar.swift
//  
//
//  Created by Lukas on 16.08.21.
//

#if canImport(UIKit)
import UIKit

public extension UICollectionReusableView {
    
    // MARK: - Properties
    
    /// Returns the parental collection view.
    ///
    var collectionView: UICollectionView? {
        return superview as? UICollectionView
    }
    
    /// Returns the parental collection view controller if present.
    ///
    var collectionViewController: UICollectionViewController? {
        return collectionView?.parentViewController as? UICollectionViewController
    }
}
#endif
