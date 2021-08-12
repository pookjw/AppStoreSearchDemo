//
//  XCUIApplication+runApp.swift
//  AppStoreSearchDemoUITests
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import XCTest

extension XCUIApplication {
    @discardableResult
    static func runApp() -> Self {
        let app: Self = .init()
        app.launchArguments = ["enable-testing"]
        app.launch()
        return app
    }
}
