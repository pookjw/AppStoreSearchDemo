//
//  ITSServiceRepositoryTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class ITSServiceRepositoryTest: XCTestCase {
    private let repo: ITSServiceRepository = ITSServiceRepositoryImpl()
    private var disposeBag: DisposeBag = .init()
    
    func testRequest() {
        let expectation: XCTestExpectation = .init()
        
        repo
            .requestSoftware(text: "DoroDoro")
            .subscribe { infos in
                log.info(infos)
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}
