//
//  UIState.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 21.01.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import Foundation
import UIKit

public enum UIState {
   case fine
   case loading
   
   // 1. image name
   // 2. message
   // 3. button title
   // 3. action
   case stating(String?, String?, String?, UIErrorViewController.ReloadHandler?)
   
   case noInternet
   case empty(String)
   case failed(String)
   case render(UIViewController)
}
#endif
