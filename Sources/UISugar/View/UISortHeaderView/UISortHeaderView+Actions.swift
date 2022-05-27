//
//  UISortHeaderView+Actions.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 07.10.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

extension UISortHeaderView {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Actions
   // ===-----------------------------------------------------------------------------------------------------------===

   @objc func segmentedControlAction(_ sender: UISegmentedControl?) {
      guard let selectedIndex = sender?.selectedSegmentIndex else { return }
      delegate?.sortHeaderView(self, didSelectSortItemAtIndex: selectedIndex)
   }
   
   @objc func filterButtonItemAction(_ sender: UIBarButtonItem?) {
      
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      let filterItems = self.filterItems
      
      for item in filterItems {
         
         let action = UIAlertAction(title: item, style: .default, handler: { _ in
            
            self.selectedFilter = item
            self.filterButtonItem?.title = item
            
         })
         
         if let image = delegate?.sortHeaderView(self, imageForFilter: item) {
            action.image = image
         }
              
         if item == selectedFilter {
            action.isChecked = true
         }
         
         alert.addAction(action)
         
      }
      
      let noneAction = UIAlertAction.destructive(title: noFilterButtonTitle, handler: { _ in
         
         self.selectedFilter = nil
         self.filterButtonItem?.title = self.delegate?.filterTitle(self)
         self.delegate?.sortHeaderView(self, didSelectFilter: self.selectedFilter)
         
      })
      noneAction.isChecked = self.selectedFilter == nil
      alert.addAction(noneAction)
      
      alert.popoverPresentationController?.barButtonItem = sender
      
      self.parentViewController?.present(alert, animated: true)
   }
   
   @objc func directionButtonItemAction(_ sender: UIBarButtonItem?) {
      
      // toggle direction.  will call `updateDirectionButton(_:)`
      selectedDirection = selectedDirection == .ascending ? .descending : .ascending
      
      delegate?.sortHeaderView(self, didSelectDirection: selectedDirection)
   }
}
#endif
