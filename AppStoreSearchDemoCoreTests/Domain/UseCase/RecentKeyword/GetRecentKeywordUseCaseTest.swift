//
//  GetRecentKeywordUseCaseTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class GetRecentKeywordUseCaseTest: XCTestCase {
    private let useCase: GetRecentKeywordUseCase = GetRecentKeywordUseCaseImpl()
    private var disposeBag: DisposeBag = .init()
    
    func testGet() {
        let expectation: XCTestExpectation = .init()
        
        useCase
            .getList()
            .subscribe { _ in
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}
