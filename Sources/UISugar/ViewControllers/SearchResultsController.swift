//
//  SearchResultsController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 11.06.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

class SearchResultsController<ItemType>: UITableViewController, UISearchResultsUpdating {
   
   
   // MARK: - Properties
   
   /// Holds the collection of shown results.
   var results: [ItemType]? {
      didSet {
         resultsDidChange()
      }
   }
   
   /// Closure to be executed when an item has been selected.
   var onSelection: ((IndexPath, ItemType) -> ())?
   
   
   // MARK: - Configuration
   
   /// A Boolean value indicating whether the results should be cleared this view controller is dimissed.  Default is `true`
   var shouldClearResultsOnDismiss = true
   
   /// A Boolean value indication whether a selected row should be deselected immediately.  Default is `true`
   var shouldDeselectOnSelection = true
   
   /// A Boolean value indication whether this view controller is dismissed on selection of a row.  Default is `true`
   var shouldDismissOnSelection = true
   
   
   // MARK: - Initialization
   
   override init(style: UITableView.Style = .grouped) {
      super.init(style: style)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   // MARK: - Override UIViewController
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // configure table view
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "C0")
   }
   
   override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      
      // clear results when view controller is dismissed
      if shouldClearResultsOnDismiss {
         results = nil
         tableView.reloadData()
      }
   }
   
   
   // MARK: - Functionality
   
   func resultsDidChange() {
      
      // guard the view controller is currently visible.
      guard viewIfLoaded?.window != nil else {
         return
      }
      
      tableView.reloadData()
   }
   
   
   // MARK: Override UIViewController
   
   /// Overriden in order to set this controller as `searchResultsUpdater` property when parent is an `UISearchController`.
   #if swift(>=4.2)
   override func willMove(toParent parent: UIViewController?) {
      super.willMove(toParent: parent)
      (parent as? UISearchController)?.searchResultsUpdater = self
   }
   #else
   override func willMove(toParent parent: UIViewController?) {
      super.willMove(toParent: parent)
      (parent as? UISearchController)?.searchResultsUpdater = self
   }
   #endif
   
   
   
   
   // MARK: Override UITableViewController
   
   /// Returns 1.
   override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   /// Returns the number of items in the `results` collection or 0 if `results` is `nil`.
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return results?.count ?? 0
   }
   
   /// Returns a simple table view cell.
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "C0", for: indexPath)
      
      if let item = results?[indexPath.item] {
         cell.textLabel?.text = "\(item)"
      }
      
      return cell
   }
   
   /// Default implementation which gets the item at the given index path and calls the `onSelection` closure.
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      guard let item = results?[indexPath.item] else {
         return
      }
      
      if shouldDeselectOnSelection {
         tableView.deselectRow(at: indexPath, animated: true)
      }
      
      onSelection?(indexPath, item)
      
      if shouldDismissOnSelection {
         dismiss(animated: true)
      }
   }
   
   
   // MARK: - UISearchResultsUpdating
   
   func updateSearchResults(for searchController: UISearchController) {
      // default implementation does nothing
   }
}
#endif
