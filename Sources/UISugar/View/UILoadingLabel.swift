//
//  UILoadingLabel.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 11.11.19.
//  Copyright © 2019 WinValue. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

@available(iOS 13.0, *)
class UILoadingLabel: UILabel {
    
    #if swift(>=4.2)
    lazy var activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    #else
    lazy var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    #endif
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        activityIndicatorView.hidesWhenStopped = true
    }
}
#endif
