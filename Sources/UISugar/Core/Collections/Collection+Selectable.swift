//
//  SelectableCollectionController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 26.01.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SelectableCollectionControlable`
// ===-----------------------------------------------------------------------------------------------------------===

protocol SelectableCollectionControlable: CollectionControlable {
   
   var selected: ControlableItem? {get set}
   
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Extension `CollectionControlable` for `SelectableCollectionControlable`
// ===-----------------------------------------------------------------------------------------------------------===

extension SelectableCollectionControlable {
   
   /// The index of the current selected item or nil
   var selectedIndex: Int? {
      get {
         guard let selected = self.selected else { return nil }
         return self.index(of: selected)
      }
      set {
         if let selectedIndex = newValue, selectedIndex > 0, selectedIndex < count {
            selected = self[selectedIndex]
         } else {
            selected = nil
         }
      }
   }
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SelectableCollectionController`
// ===-----------------------------------------------------------------------------------------------------------===

class SelectableCollectionController<Item: Equatable>: CollectionController<Item>, SelectableCollectionControlable {
   
   var selected: Item? {
      didSet { selectableDelegate?.collection(didSelectItemAt: selectedIndex) }
   }
   
   private var selectableDelegate: SelectableCollectionControllerDelegate? {
      return delegate as? SelectableCollectionControllerDelegate
   }
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SelectableCollectionControllerDelegate`
// ===-----------------------------------------------------------------------------------------------------------===

protocol SelectableCollectionControllerDelegate: CollectionControllerDelegate {
   
   func collection(didSelectItemAt itemIndex: Int?)
   
}
