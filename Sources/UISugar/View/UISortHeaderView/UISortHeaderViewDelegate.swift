//
//  UISortHeaderViewDelegate.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 05.10.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//
#if canImport(UIKit)
import Foundation
import UIKit.UIImage

protocol UISortHeaderViewDelegate: class {
   
   func filterTitle(_ sortHeaderView: UISortHeaderView) -> String?
   
   func filterItemsIn(_ sortHeaderView: UISortHeaderView) -> [String]
   
   func sortHeaderView(_ sortHeaderView: UISortHeaderView, imageForFilter filter: String?) -> UIImage?
   
   func sortItemsIn(_ sortHeaderView: UISortHeaderView) -> [String]
   
   func sortHeaderView(_ sortHeaderView: UISortHeaderView, didSelectDirection direction: UISortHeaderView.Direction)
   
   func sortHeaderView(_ sortHeaderView: UISortHeaderView, didSelectFilter filter: String?)
   
   func sortHeaderView(_ sortHeaderView: UISortHeaderView, didSelectSortItemAtIndex index: Int?)
   
}
#endif
