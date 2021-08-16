//
//  AppStoreReviewManager.swift
//  Rima
//
//  Created by Lukas on 25.12.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

#if canImport(StoreKit)
import StoreKit

public enum AppStoreReviewManager {
    
    public static var reviewWorthyActionsNumbers = [
        30,
        100,
        200,
        400
    ]
    
    public static var bundleName: String {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as? String ?? "AppStoreReviewManager"
    }
    
    public static var currentVersion: String? {
        Bundle.main.object(
            forInfoDictionaryKey: kCFBundleVersionKey as String
        ) as? String
    }
    
    public static var reviewWorthyActionsCount: Int {
        UserDefaults.standard.integer(
            forKey: "\(bundleName).AppStoreReviewManager.reviewWorthyActionsCount"
        )
    }
    
    public static var lastVersionPromptedForReview: String? {
        UserDefaults.standard.string(
            forKey: "\(bundleName).AppStoreReviewManager.lastVersionPromptedForReview"
        )
    }
    
    public static func increaseReviewWorthyActionsCount() {
        UserDefaults.standard.set(
            reviewWorthyActionsCount + 1,
            forKey: "\(bundleName).AppStoreReviewManager.reviewWorthyActionsCount"
        )
    }
    
    static func requestReviewIfAppropriate() {
        increaseReviewWorthyActionsCount()
        
        guard reviewWorthyActionsNumbers.contains(reviewWorthyActionsCount) else { return }
        guard currentVersion != lastVersionPromptedForReview else { return }
        
        let oneSecondFromNow = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: oneSecondFromNow) {
            
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                return
            }
            UserDefaults.standard.set(currentVersion, forKey: "\(bundleName).AppStoreReviewManager.lastVersionPromptedForReview")
        }
    }
}
#endif
