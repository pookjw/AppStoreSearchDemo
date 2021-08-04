//
//  RecentKeywordDataStackTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class RecentKeywordDataStackTest: XCTestCase {
    private let recentKeywordDataStack: RecentKeywordDataStack = .init()
    private var disposeBag: DisposeBag = .init()
    
    override func setUp() {
        super.setUp()
        initializeLog()
    }
    
    func testAddKeyword() {
        let expectation: XCTestExpectation = .init()
        
        let recentKeyword: RecentKeyword = .init()
        
        recentKeywordDataStack
            .add(recentKeyword)
            .subscribe {
                expectation.fulfill()
            } onError: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 30)
    }
}
