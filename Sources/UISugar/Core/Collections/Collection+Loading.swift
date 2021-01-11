//
//  Collection+Loading.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 26.01.20.
//  Copyright © 2020 WinValue. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `LoadingState`
// ===-----------------------------------------------------------------------------------------------------------===

public enum LoadingState {
   case loading     // is currently fetching / loading
   case idle        // is idle and ready to fetch
   case locked      // a locked state for disabling fetching
   case invalid     // an invalid state,  the collection shoul be reloaded
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `LoadingCollectionControlable`
// ===-----------------------------------------------------------------------------------------------------------===

protocol LoadingCollectionControlable: CollectionControlable {
   
   var state: LoadingState {get set}
   
   func reload()
   
}

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - Extension `LoadingCollectionControlable`
// ===-----------------------------------------------------------------------------------------------------------===

extension LoadableCollectionController {
   
   /// A Boolean value indicating wheather the collection is currently loading
   var isLoading: Bool {
      return state == .loading
   }
   
   /// A Boolean value indicating wheather the collection is idle
   var isIdle: Bool {
      return state == .idle
   }
   
   
   // MARK: - Invalidate
   
   /// A Boolean value indicating wheather the collection is invalid and thus should be reloaded
   var isInvalid: Bool {
      return state == .invalid
   }
   
   /// Sets the state to `.invalid`
   func invalidate() {
      self.state = .invalid
   }
   
   
   
   
   // MARK: - Lock
   
   /// A Boolean value indicating wheather the collection is locked
   var isLocked: Bool {
      return state == .locked
   }
   
   /// Sets the state to `.locked`
   func lock() {
      self.state = .locked
   }
   
   /// Sets the state to `.idle` only if current state is `.locked`
   func unlock() {
      guard self.state == .locked else { return }
      self.state = .idle
   }
}


// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `SortableCollection`
// ===-----------------------------------------------------------------------------------------------------------===

class LoadableCollectionController<Item: Equatable>: SortableCollectionController<Item>, LoadingCollectionControlable {
   
   typealias LoadingCompletion = ([ControlableItem]?, Bool) -> ()
   
   var state: LoadingState = .idle {
      didSet { loadingDelegate?.collection(didChangeState: state, previousState: oldValue) }
   }
   
   func reload() {
      guard self.state != .loading else { return }
      self.state = .loading
      self.loadingDelegate?.collectionDidStartLoading()
      self.load(completion: { items, error in
         self.removeAll()
         self.append(contentsOf: items ?? [])
         
         guard let delegate = self.loadingDelegate else { return }
         if let amount = items?.count {
            let indexSet = IndexSet(integersIn: 0..<amount)
            delegate.collection(didFinishLoadingIndexes: indexSet)
         } else {
            delegate.collection(didFinishLoadingIndexes: nil)
         }
      })
   }
   
   private var loadingDelegate: LazyLoadingDelegate? {
      return delegate as? LazyLoadingDelegate
   }
   
   func load(completion: @escaping LoadingCompletion) {
      // empty
   }
}



protocol LazyLoadingDelegate: SortableCollectionControllerDelegate {
   
   func collection(didChangeState newState: LoadingState,
                   previousState: LoadingState)
   
   func collectionDidStartLoading()
   
   func collection(didFinishLoadingIndexes indexes: IndexSet?)
   
}
