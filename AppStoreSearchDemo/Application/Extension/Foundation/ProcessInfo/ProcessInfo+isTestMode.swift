//
//  ProcessInfo+isTestMode.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation

extension ProcessInfo {
    /// Check that app is running as Test mode.
    ///
    /// ```
    /// ProcessInfo.processInfo.isTestMode
    /// ```
    ///
    /// - Warning: Please run the app with "enable-testing" argument when running as Test mode. You can configure this argument at Xcode Scheme Settings or XCUIApplication's property.
    var isTestMode: Bool {
        return arguments.contains("enable-testing")
    }
}
