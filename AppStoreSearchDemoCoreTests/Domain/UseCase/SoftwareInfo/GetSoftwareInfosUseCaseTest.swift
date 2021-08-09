//
//  GetSoftwareInfosUseCaseTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class GetSoftwareInfosUseCaseTest: XCTestCase {
    private let useCase: GetSoftwareInfosUseCase = GetSoftwareInfosUseCaseImpl()
    private var disposeBag: DisposeBag = .init()
    
    func testGet() {
        let expectation: XCTestExpectation = .init()
        
        useCase
            .get(text: "DoroDoro")
            .subscribe { _ in
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}
