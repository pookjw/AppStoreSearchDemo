//
//  SearchViewControllerTest.swift
//  AppStoreSearchDemoUITests
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import XCTest
@testable import AppStoreSearchDemo

final class SearchViewControllerTest: XCTestCase {
    func testSearch() {
        let app: XCUIApplication = .runApp()
        
        app.swipeDown()
        let searchFields: XCUIElement = app.searchFields.element
        
        searchFields.tap()
        searchFields.typeText("DoroDoro")
        
        app.keyboards.buttons["search"].tap()
        
        let developerName: XCUIElement = app.staticTexts["Jinwoo Kim"]
        _ = developerName.waitForExistence(timeout: 5)
        developerName.tap()
    }
    
    func testSearchWithManualTyping() {
        let app: XCUIApplication = .runApp()
        
        app.swipeDown()
        app.searchFields.element.tap()
        
        "Dorodoro"
            .forEach { char in
                app.keys[String(char)].tap()
            }
        
        app.keyboards.buttons["search"].tap()
        
        let developerName: XCUIElement = app.staticTexts["Jinwoo Kim"]
        _ = developerName.waitForExistence(timeout: 5)
        developerName.tap()
    }
}
