//
//  RecentKeywordTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class RecentKeywordTest: XCTestCase {
    private let local: LocalRealm = LocalRealmImpl()
    private var disposeBag: DisposeBag = .init()
    
    override func setUp() {
        super.setUp()
        initializeLog()
    }
    
    func testCreateKeyword() {
        let expectation: XCTestExpectation = .init()
        
        local
            .create { (recentKeyword: RecentKeyword) in
                recentKeyword.keyword = "도로도로"
            }
            .subscribe { _ in
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)

        
        wait(for: [expectation], timeout: 3)
    }
    
    func testLoadObjects() {
        let expectation: XCTestExpectation = .init()
        
        local
            .objects(predicate: nil)
            .subscribe { (recentKeywords: [RecentKeyword]) in
                recentKeywords.forEach { recentKeyword in
                    print(recentKeyword.keyword ?? "nil")
                }
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testModifyObject() {
        let expectation: XCTestExpectation = .init()
        
        local
            .objects(predicate: nil)
            .flatMapCompletable { (keywords: [RecentKeyword]) -> Completable in
                let random: RecentKeyword = keywords.randomElement()!
                
                return self.local
                    .modify(random) { keyword in
                        keyword.keyword = "티비리앙"
                    }
            }
            .subscribe {
                expectation.fulfill()
            } onError: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testDeleteObject() {
        let expectation: XCTestExpectation = .init()
        
        local
            .objects(predicate: nil)
            .flatMapCompletable { (keywords: [RecentKeyword]) -> Completable in
                let random: RecentKeyword = keywords.randomElement()!
                
                return self.local
                    .delete(random)
            }
            .subscribe {
                expectation.fulfill()
            } onError: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testObserveObjects() {
        let expectation: XCTestExpectation = .init()
        
        local
            .observe(type: RecentKeyword.self)
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }, onError: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        local
            .create { (_: RecentKeyword) in }
            .subscribe(onFailure: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}
