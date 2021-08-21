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
    
    /// Returns the bundle identifier.
    ///
    private static var bundleIdentifier: String {
        ApplicationInfo.shared.identifier ?? "AppStoreReviewManager"
    }
    
    /// Returns the user defaults key for storing the integer of the amount of review worthy actions.
    ///
    private static var actionCountKey: String {
        "\(bundleIdentifier).AppStoreReviewManager.reviewWorthyActionsCount"
    }
    
    /// Returns the user defaults key for storing the string of the version where the user was last prompted.
    ///
    private static var lastVersionKey: String {
        "\(bundleIdentifier).AppStoreReviewManager.lastVersionPromptedForReview"
    }
    
    /// Returns the current version (build number) of the app.
    ///
    private static var currentVersion: String? {
        ApplicationInfo.shared.buildNumber
    }
    
    /// Returns the amount of review worthy actions. Loaded from user defaults.
    ///
    private static var reviewWorthyActionsCount: Int {
        UserDefaults.standard.integer(forKey: actionCountKey)
    }
    
    /// Returns the version where the user was last prompted. Loaded from user defaults.
    ///
    private static var lastVersionPromptedForReview: String? {
        UserDefaults.standard.string(forKey: lastVersionKey)
    }
    
    /// Increases the amount of review worthy actions and stores it to the user defaults.
    ///
    private static func increaseReviewWorthyActionsCount() {
        UserDefaults.standard.set(reviewWorthyActionsCount + 1, forKey: actionCountKey)
    }
    
    
    // MARK: - Public API
    
    public static var reviewWorthyActionsNumbers = [
        10,
        25,
        50,
        100,
        200,
        400,
        600,
        1200
    ]
    
    public static func requestReviewIfAppropriate() {
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
            
            UserDefaults.standard.set(currentVersion, forKey: lastVersionKey)
        }
    }
}
#endif
