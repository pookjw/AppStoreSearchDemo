//
//  RecentKeywordStoreTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class RecentKeywordStoreTest: XCTestCase {
    private let recentKeywordStore: RecentKeywordStore = .init()
    private var disposeBag: DisposeBag = .init()
    
    override func setUp() {
        super.setUp()
        initializeLog()
    }
    
    func testCreateKeyword() {
        let expectation: XCTestExpectation = .init()
        
        recentKeywordStore
            .create { recentKeyword in
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
        
        recentKeywordStore
            .objects(predicate: nil)
            .subscribe { recentKeywords in
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
        
        recentKeywordStore
            .objects(predicate: nil)
            .flatMapCompletable { keywords -> Completable in
                let random: RecentKeyword = keywords.randomElement()!
                
                return self.recentKeywordStore
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
        
        recentKeywordStore
            .objects(predicate: nil)
            .flatMapCompletable { keywords -> Completable in
                let random: RecentKeyword = keywords.randomElement()!
                
                return self.recentKeywordStore
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
        
        recentKeywordStore
            .observe()
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }, onError: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        recentKeywordStore
            .create { _ in }
            .subscribe(onFailure: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}
