//
//  ObserveRecentKeywordUseCaseTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class ObserveRecentKeywordUseCaseTest: XCTestCase {
    private let observeUseCase: ObserveRecentKeywordUseCase = ObserveRecentKeywordUseCaseImpl()
    private let createUseCase: CreateRecentKeywordUseCase = CreateRecentKeywordUseCaseImpl()
    private var disposeBag: DisposeBag = .init()
    
    func testGet() {
        let expectation: XCTestExpectation = .init()
        
        observeUseCase
            .observe()
            .skip(1)
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }, onError: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        createUseCase
            .create(text: "DoroDoro")
            .subscribe {
                
            } onError: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)

        
        wait(for: [expectation], timeout: 3)
    }
}
