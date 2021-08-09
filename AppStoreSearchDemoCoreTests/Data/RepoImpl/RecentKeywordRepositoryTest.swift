//
//  RecentKeywordRepositoryTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class RecentKeywordRepositoryTest: XCTestCase {
    private let repo: RecentKeywordRepository = RecentKeywordRepositoryImpl()
    private var disposeBag: DisposeBag = .init()
    
    func testGetList() {
        let expectation: XCTestExpectation = .init()
        
        repo
            .getList()
            .subscribe { _ in
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 3)
    }
    
    func testCreate() {
        let expectation: XCTestExpectation = .init()
        
        repo
            .create { new in
                new.keyword = "DoroDoro"
            }
            .subscribe { new in
                XCTAssertEqual(new.keyword, "DoroDoro")
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 3)
    }
    
    func testObserve() {
        let expectation: XCTestExpectation = .init()
        
        repo
            .observe()
            .skip(1)
            .subscribe(onNext: { _ in
                expectation.fulfill()
            },
            onError: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        testCreate()
        
        wait(for: [expectation], timeout: 3)
    }
}
