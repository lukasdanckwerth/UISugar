//
//  CollectionController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 23.01.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `CollectionControlable`
// ===-----------------------------------------------------------------------------------------------------------===

protocol CollectionControlable {
   
   associatedtype ControlableItem: Equatable
   
   
   
   // MARK: - Properties
   
   /// The number of elements in the collection
   var count: Int {get}
   
   /// A Boolean value indicating whether the collection is empty
   var isEmpty: Bool {get}
   
   
   
   // MARK: - Functions
   
   func set(newItems: [ControlableItem])
   
   func append(_ newItem: ControlableItem)
   
   func append(contentsOf newItems: [ControlableItem])
   
   func removeAll()
   
   func remove(at index: Int)
   
   func index(of item: ControlableItem) -> Int?
   
   subscript(index: Int) -> ControlableItem { get set }
   
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `CollectionController`
// ===-----------------------------------------------------------------------------------------------------------===

class CollectionController<Item: Equatable> {
   
   
   // MARK: - Properties
   
   private(set) var items: [Item] = [] {
      didSet { itemsDidChange() }
   }
   
   weak var delegate: CollectionControllerDelegate?
   
   // override point.  subclasses must call super
   open func itemsDidChange() {
      self.delegate?.collection(didChangeItems: items)
   }
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `CollectionController` + `CollectionControlable`
// ===-----------------------------------------------------------------------------------------------------------===

extension CollectionController: CollectionControlable {
   
   typealias ControlableItem = Item
   
   
   // satisfy `CollectionControllerProtocol`
   
   var count: Int {
      return self.items.count
   }
   
   var isEmpty: Bool {
      return self.items.isEmpty
   }
   
   
   func set(newItems: [Item]) {
      self.items = newItems
   }
   
   func append(_ newItem: Item) {
      self.items.append(newItem)
      self.delegate?.collection(didAddItemsAt: IndexSet(integer: count - 1))
   }
   
   func append(contentsOf newItems: [Item]) {
      self.items.append(contentsOf: newItems)
      let start = self.count - newItems.count
      let end = self.count
      let indexSet = IndexSet(integersIn: start..<end)
      self.delegate?.collection(didAddItemsAt: indexSet)
   }
   
   func removeAll() {
      self.items.removeAll()
      self.delegate?.collectionDidRemoveAll()
   }
   
   func remove(at index: Int) {
      self.items.remove(at: index)
      self.delegate?.collection(didRemoveItemsAt: IndexSet(integer: index))
   }
   
   func index(of item: Item) -> Int? {
      return self.items.firstIndex(of: item)
   }
   
   subscript(index: Int) -> Item {
      get { return self.items[index] }
      set { self.items[index] = newValue }
   }
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `CollectionControllerDelegate`
// ===-----------------------------------------------------------------------------------------------------------===

protocol CollectionControllerDelegate: class {
   
   // MARK: - change
   
   func collection(didChangeItems items: [Any])
   
   // MARK: - add
   
   func collection(didAddItemsAt indexSet: IndexSet)
   
   // MARK: - remove
   
   func collectionDidRemoveAll()
   
   func collection(didRemoveItemsAt indexSet: IndexSet)
   
}
