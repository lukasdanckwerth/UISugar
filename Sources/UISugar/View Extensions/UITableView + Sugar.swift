//
//  ExtensionUITableView.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 12.06.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

public extension UITableView {
   
   /// Returns a Boolean value indicating whether the cell at the given index path is presented and fully visible in the bounds of the table view.
   ///
   /// - parameter indexPath: The index path of the table view cell to check for fully visibility.
   ///
   /// - returns: A Boolean value indicating the fully visibility of the cell.
   func isCompletelyVisible(indexPath: IndexPath) -> Bool {
      return bounds.contains(rectForRow(at: indexPath))
   }
   
   /// Returns a Boolean value indicating whether the given cell is presented and fully visible in the bounds of the table view.
   ///
   /// - parameter cell: The table view cell to check for fully visibility.
   ///
   /// - returns: A Boolean value indicating the fully visibility of the cell.
   func isCompletelyVisible(cell: UITableViewCell) -> Bool {
      guard let indexPath = indexPath(for: cell) else { return false }
      return isCompletelyVisible(indexPath: indexPath)
   }
}



// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Cell Registration
// ===-----------------------------------------------------------------------------------------------------------===

public extension UITableView {
   
   // convenient cell registration
   
   func register(cellNibName name: String) {
      self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
   }
   
   func register(cellClass: AnyClass) {
      self.register(cellClass, forCellReuseIdentifier: "\(cellClass.self)")
   }
   
   func dequeue<CellType: UITableViewCell>(indexPath: IndexPath) -> CellType! {
      return self.dequeueReusableCell(withIdentifier: "\(CellType.self)", for: indexPath) as? CellType
   }

   
   // convenient header / footer registration
   
   func register(headerNibName name: String) {
      self.register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: name)
   }
   
   func register(headerFooterClass: AnyClass) {
      self.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: "\(headerFooterClass.self)")
   }
   
   func headerFooter<HeaderFooter: UITableViewHeaderFooterView>() -> HeaderFooter! {
      self.dequeueReusableHeaderFooterView(withIdentifier: "\(HeaderFooter.self)") as? HeaderFooter
   }
}
#endif
