//
//  UISortHeaderView+Setup.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 07.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

extension UISortHeaderView {
   
   func setup() {
      
      navigationItem.titleView = setupSegmentedControl()
      
      navigationItem.leftBarButtonItem = showsFilterButton ? setupFilterButtonItem() : nil
      navigationItem.rightBarButtonItem = showsDirectionButton ? setupDirectionButtonItem() : nil
   }
   
   func setupSegmentedControl() -> UISegmentedControl {
      let control = UISegmentedControl(items: sortSegmentedControlItemNames)
      control.addTarget(self, action: #selector(self.segmentedControlAction), for: .valueChanged)
      return control
   }
   
   func setupFilterButtonItem() -> UIBarButtonItem {
      let item = UIBarButtonItem(
         title: NSLocalizedString("Filter", comment: ""),
         style: .plain,
         target: self,
         action: #selector(self.filterButtonItemAction)
      )
      
      item.image = UISortHeaderView.imageFilter
      item.title = NSLocalizedString("Filter", comment: "")
      
      return item
   }
   
   func setupDirectionButtonItem() -> UIBarButtonItem {
      let item = UIBarButtonItem(
         image: UISortHeaderView.imageDirectionAscending,
         style: .plain,
         target: self,
         action: #selector(self.directionButtonItemAction(_:))
      )
      return item
   }
}
#endif
