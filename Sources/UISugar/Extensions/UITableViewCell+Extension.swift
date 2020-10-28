//
//  UITableViewCell+Extension.swift
//  
//
//  Created by Lukas Danckwerth on 28.10.20.
//

import UIKit

public extension UITableViewCell {
    
    /// Returns the parental table view.
    var tableView: UITableView? {
        return next as? UITableView ?? next?.next as? UITableView
    }
    
    /// Returns the parental table view.
    var tableViewController: UITableViewController? {
        return tableView?.parentViewController as? UITableViewController
    }
}
