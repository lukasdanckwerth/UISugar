//
//  SortableCollectionControlable.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 26.01.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SortDirection`
// ===-----------------------------------------------------------------------------------------------------------===

enum SortDirection {
   case ascending
   case descending
}

class Sort<Item: Equatable>: Equatable {
   static func == (lhs: Sort<Item>, rhs: Sort<Item>) -> Bool {
      lhs === rhs
   }
   
   typealias SortFunction = (Item, Item) -> Bool
   
   let title: String
   let function: SortFunction
   
   init(title: String, function: @escaping SortFunction) {
      self.title = title
      self.function = function
   }
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SortableCollectionControlable`
// ===-----------------------------------------------------------------------------------------------------------===

protocol SortableCollectionControlable: CollectionControlable {
   
   var direction: SortDirection {get set}
   
   var sort: Sort<ControlableItem>? {get set}
   
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SortableCollection`
// ===-----------------------------------------------------------------------------------------------------------===

class SortableCollectionController<Item: Equatable>: SelectableCollectionController<Item>, SortableCollectionControlable {
   
   var direction: SortDirection = .ascending {
      didSet {
         setSorted()
         sortableDelegate?.collection(didChangeDirection: direction)
      }
   }
   
   var sort: Sort<ControlableItem>? {
      didSet {
         setSorted()
         sortableDelegate?.collectionDidChangeSort()
      }
   }
   
   private func setSorted() {
      guard let sort = self.sort else { return }
      var sorted = items.sorted(by: sort.function)
      if self.direction == .descending {
         sorted = sorted.reversed()
      }
      self.set(newItems: sorted)
   }
   
   private var sortableDelegate: SortableCollectionControllerDelegate? {
      return delegate as? SortableCollectionControllerDelegate
   }
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SelectableCollectionControllerDelegate`
// ===-----------------------------------------------------------------------------------------------------------===

protocol SortableCollectionControllerDelegate: SelectableCollectionControllerDelegate {
   
   func collection(didChangeDirection direction: SortDirection)

   func collectionDidChangeSort()
   
}
