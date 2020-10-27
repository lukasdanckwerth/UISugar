//
//  UISortHeaderView.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 05.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

class UISortHeaderView: UIView {
   
   static let preferredHeight: CGFloat = 64
   
   let navigationBar: UINavigationBar
   
   let navigationItem: UINavigationItem
   
   var isEnabled: Bool = true {
      didSet {
         sortSegmentedControl?.isEnabled = self.isEnabled
         directionButtonItem?.isEnabled = self.isEnabled
         filterButtonItem?.isEnabled = self.isEnabled
      }
   }
   
   override func tintColorDidChange() {
      super.tintColorDidChange()
      self.sortSegmentedControl?.tintColor = self.tintColor
      self.directionButtonItem?.tintColor = self.tintColor
      self.filterButtonItem?.tintColor = self.tintColor
   }
   
   
   // MARK: - Segmented Control
   
   var sortSegmentedControl: UISegmentedControl? {
      return navigationItem.titleView as? UISegmentedControl
   }
   
   var sortSegmentedControlItems: [String] {
      return delegate?.sortItemsIn(self) ?? []
   }
   
   var sortSegmentedControlItemNames: [String] {
      return sortSegmentedControlItems.compactMap({ $0 })
   }
   
   var selectedSort: String? {
      didSet { selectedSortDidChange() }
   }
   
   var selectedSortIndex: Int? {
      guard let selectedSort = self.selectedSort else { return nil }
      return sortSegmentedControlItems.firstIndex(of: selectedSort)
   }
   
   func selectedSortDidChange() {
      if let selectedSort = self.selectedSort, let index = sortSegmentedControlItems.firstIndex(of: selectedSort) {
         sortSegmentedControl?.selectedSegmentIndex = index
      } else {
         #if swift(>=4.2)
         sortSegmentedControl?.selectedSegmentIndex = UISegmentedControl.noSegment
         #else
         sortSegmentedControl?.selectedSegmentIndex = UISegmentedControl.noSegment
         #endif
      }
   }
   
   
   
   
   // MARK: - Direction Button
   
   var showsDirectionButton = true {
      didSet { navigationItem.leftBarButtonItem = showsDirectionButton ? setupDirectionButtonItem() : nil }
   }
   
   var directionButtonItem: UIBarButtonItem? {
      return navigationItem.rightBarButtonItem
   }
   
   var selectedDirection: UISortHeaderView.Direction = .ascending {
      didSet { updateDirectionButton() }
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Filter Button
   // ===-----------------------------------------------------------------------------------------------------------===
   
   var showsFilterButton = true {
      didSet { navigationItem.leftBarButtonItem = showsFilterButton ? setupFilterButtonItem() : nil }
   }
   
   var noFilterButtonTitle: String = NSLocalizedString("None", comment: "No filter button title")
   
   var filterButtonItem: UIBarButtonItem? {
      return navigationItem.leftBarButtonItem
   }
   
   var filterItems: [String] {
      return delegate?.filterItemsIn(self) ?? []
   }
   
   var selectedFilter: String? = nil {
      didSet { selectedFilterDidChange() }
   }
   
   func selectedFilterDidChange() {
      updateFilterButton()
      delegate?.sortHeaderView(self, didSelectFilter: selectedFilter)
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Delegate
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// The object that acts as a delegate for this `UIOrganizingContentBar`.
   weak var delegate: UISortHeaderViewDelegate? {
      didSet { setup() }
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   override init(frame: CGRect) {
      
      navigationBar = UINavigationBar(frame: frame)
      
      navigationItem = UINavigationItem()
      
      super.init(frame: frame)
      
      // first do setup..
      setup()
      
      navigationBar.translatesAutoresizingMaskIntoConstraints = false
      addSubview(navigationBar)
      if #available(iOS 11.0, *) {
         addConstraints([
            navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            navigationBar.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
         ])
      } else {
         addConstraints([
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navigationBar.centerYAnchor.constraint(equalTo: self.centerYAnchor)
         ])
      }
      
      // ..then push item
      navigationBar.pushItem(navigationItem, animated: false)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Direction Button
   // ===-----------------------------------------------------------------------------------------------------------===
   
   static var imageDirectionAscending: UIImage? {
      return .named("ToolbarAscending")
   }
   
   static var imageDirectionDescending: UIImage? {
      return .named("ToolbarDescending")
   }
   
   func updateDirectionButton() {
      
      if selectedDirection == .ascending {
         directionButtonItem?.image = UISortHeaderView.imageDirectionAscending
      } else {
         directionButtonItem?.image = UISortHeaderView.imageDirectionDescending
      }
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Filter Button
   // ===-----------------------------------------------------------------------------------------------------------===
   
   static var imageFilter: UIImage? {
      return .named("ToolbarFilter")
   }
   
   static var imageFilterFilled: UIImage? {
      return .named("ToolbarFilterFilled")
   }
   
   func updateFilterButton() {
      
      guard let filterButtonItem = self.filterButtonItem else { return }
      
      if let filter = self.selectedFilter {
         filterButtonItem.title = filter
         filterButtonItem.image = UISortHeaderView.imageFilterFilled
      } else if let title = self.delegate?.filterTitle(self) {
         filterButtonItem.title = title
         filterButtonItem.image = UISortHeaderView.imageFilter
      } else {
         filterButtonItem.title = nil
         filterButtonItem.image = UISortHeaderView.imageFilter
      }
   }
}

extension UISortHeaderView {
   enum Direction: Int {
      case ascending
      case descending
   }
}
#endif
