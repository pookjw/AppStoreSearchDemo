//
//  CreateRecentKeywordUseCaseTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class CreateRecentKeywordUseCaseTest: XCTestCase {
    private let useCase: CreateRecentKeywordUseCase = CreateRecentKeywordUseCaseImpl()
    private var disposeBag: DisposeBag = .init()
    
    func testCreate() {
        let expectation: XCTestExpectation = .init()
        
        useCase
            .create(text: "DoroDoro")
            .subscribe(onCompleted: {
                expectation.fulfill()
            }, onError: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}
