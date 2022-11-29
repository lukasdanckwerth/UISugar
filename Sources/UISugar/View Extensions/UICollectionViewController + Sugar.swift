//
//  ExtensionUICollectionViewController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 07.05.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import UIKit

public extension UICollectionViewController {
    
    /// Returns the flow layout of the collection view if any.
    @objc
    var flowLayout: UICollectionViewFlowLayout? {
        return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }
}


// view registration

public extension UICollectionViewController {
   
   
   // convenient cell registration
   
   func register(cellClass: AnyClass) {
      collectionView?.register(cellClass, forCellWithReuseIdentifier: "\(cellClass.self)")
   }
   
   func cell<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell! {
      return collectionView?.dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell
   }

   
   // convenient header registration
   
   func register(headerClass: AnyClass) {
      #if swift(>=4.2)
      collectionView?.register(headerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(headerClass.self)")
      #else
      collectionView?.register(headerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(headerClass.self)")
      #endif
   }
   
   func header<Header: UICollectionReusableView>(indexPath: IndexPath) -> Header! {
      #if swift(>=4.2)
      return collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(Header.self)", for: indexPath) as? Header
      #else
      return collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(Header.self)", for: indexPath) as? Header
      #endif
   }
   
   
   // convenient footer registration
   
   func register(footerClass: AnyClass) {
      #if swift(>=4.2)
      collectionView?.register(footerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(footerClass.self)")
      #else
      collectionView?.register(footerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(footerClass.self)")
      #endif
   }
   
   func footer<Footer: UICollectionReusableView>(indexPath: IndexPath) -> Footer! {
      #if swift(>=4.2)
      return collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(Footer.self)", for: indexPath) as? Footer
      #else
      return collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(Footer.self)", for: indexPath) as? Footer
      #endif
   }
}
#endif
