//
//  UIActivityPresenting.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 22.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

#if os(iOS)
import UIKit.UIActivityIndicatorView

public protocol UIActivityPresenting: UIView {
   var activityIndicator: UIActivityIndicatorView { get }
}
#endif
